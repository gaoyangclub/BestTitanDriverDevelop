//
//  PhotoTranslateUtils.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PhotoTranslateUtils.h"

@implementation PhotoAlbumVo
@end

@implementation PhotoTranslateUtils

static PHCachingImageManager* imageManager;

+(PHCachingImageManager*)getImageManager{
    if (!imageManager) {
        imageManager = [[PHCachingImageManager alloc]init];
    }
    return imageManager;
}

+(void)translateImageByAsset:(PhotoAlbumVo *)asset completeHandler:(void (^)())completeHandler{
    if (asset.phAsset) {
        [[PhotoTranslateUtils getImageManager] requestImageForAsset:asset.phAsset
                                          targetSize:PHImageManagerMaximumSize
                                         contentMode:PHImageContentModeAspectFill
                                             options:nil
                                       resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                           asset.image = result;
                                           if (completeHandler) {
                                               completeHandler();
                                           }
                                       }];
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
