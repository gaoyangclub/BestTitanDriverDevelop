//
//  PhotoTranslateUtils.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PhotoTranslateUtils.h"

@implementation PhotoAlbumVo

- (id)copyWithZone:(NSZone *)zone
{
    PhotoAlbumVo *aCopy = [[PhotoAlbumVo allocWithZone:zone] init];
    if(aCopy)
    {
        aCopy.phAsset = self.phAsset;
        aCopy.image = self.image;
    }
    return aCopy;
}

- (id)init
{
    if (self = [super init]) {
        _myHash = (NSUInteger)self;
    }
    return self;
}

//-(NSUInteger)hash
//{
//    return self._myHash;
//}

- (BOOL)isEqual:(id)object
{
    return self.myHash == ((PhotoAlbumVo *)object).myHash;
}

@end

@implementation PhotoTranslateUtils

static PHCachingImageManager* imageManager;
static NSCache* callBackCache;

+(void)load{
    callBackCache = [[NSCache alloc]init];
    imageManager = [[PHCachingImageManager alloc]init];
}

//+(PHCachingImageManager*)getImageManager{
//    if (!imageManager) {
//        imageManager = [[PHCachingImageManager alloc]init];
//    }
//    return imageManager;
//}

+(void)translateImageByAsset:(PhotoAlbumVo *)asset completeHandler:(void (^)())completeHandler{
    if (asset.phAsset) {
//        [[PhotoTranslateUtils getImageManager] requestImageForAsset:asset.phAsset
//                                          targetSize:PHImageManagerMaximumSize
//                                         contentMode:PHImageContentModeAspectFill
//                                             options:nil
//                                       resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                                           asset.image = result;
//                                           if (completeHandler) {
//                                               completeHandler();
        //                                               completeHandler();
//                                           }
//                                       }];
//        NSLog(@"phAsset burstIdentifier:%@",asset.phAsset.burstIdentifier);
        if(asset.image){//直接回调
            if (completeHandler) {
                completeHandler();
            }
            return;
        }
        BOOL canTranslate = NO;
        NSMutableArray* handlerArray = [callBackCache objectForKey:asset];
        if (!handlerArray) {
            handlerArray = [NSMutableArray array];
            [callBackCache setObject:handlerArray forKey:asset];
            canTranslate = YES;
        }
//        else{
//            NSLog(@"多个回调处理...");
//        }
        [handlerArray addObject:completeHandler];//先存起来
        
        if (canTranslate) {//开始转换 [PhotoTranslateUtils getImageManager]
            [imageManager requestImageDataForAsset:asset.phAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                UIImage * result = [UIImage imageWithData:imageData];
                asset.image = result;
//                if (completeHandler) {
//                    completeHandler();
//                }
                NSMutableArray* handlerArray = [callBackCache objectForKey:asset];
                for (TranslateCompletionHandler hander in handlerArray) {//全部回调
                    hander();
                }
                [callBackCache removeObjectForKey:asset];
                handlerArray = nil;
            }];
        }
        
    }
}

+(void)translateImagesByAssets:(NSMutableArray<PhotoAlbumVo *> *)assets completeHandler:(void (^)())completeHandler{
     [PhotoTranslateUtils translateImagesByAssets:0 assets:assets completeHandler:completeHandler];
}

+(void)translateImagesByAssets:(NSInteger)currentIndex assets:(NSMutableArray<PhotoAlbumVo *> *)assets completeHandler:(void (^)())completeHandler{
    if (currentIndex < assets.count) {
        PhotoAlbumVo * asset = assets[currentIndex];
        if (asset.phAsset && !asset.image) {//开始解析
            [PhotoTranslateUtils translateImageByAsset:asset completeHandler:^{
                [PhotoTranslateUtils translateImagesByAssets:currentIndex + 1 assets:assets completeHandler:completeHandler];
            }];
        }else{//有image数据直接转换下一个
            [PhotoTranslateUtils translateImagesByAssets:currentIndex + 1 assets:assets completeHandler:completeHandler];
        }
    }else{
        if (completeHandler) {
            completeHandler();
        }
    }
    
}

@end
