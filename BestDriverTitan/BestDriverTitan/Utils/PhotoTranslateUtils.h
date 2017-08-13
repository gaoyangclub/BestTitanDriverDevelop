//
//  PhotoTranslateUtils.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoAlbumVo : NSObject

@property(nonatomic,retain)UIImage* image;
@property(nonatomic,retain)PHAsset* phAsset;

@end

@interface PhotoTranslateUtils : NSObject

+(void)translateImageByAsset:(PhotoAlbumVo*)asset completeHandler:(void(^)())completeHandler;
+(void)translateImagesByAssets:(NSMutableArray<PhotoAlbumVo*>*)assets completeHandler:(void(^)())completeHandler;

@end
