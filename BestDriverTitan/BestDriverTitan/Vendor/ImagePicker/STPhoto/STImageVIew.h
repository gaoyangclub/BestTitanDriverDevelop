//
//  STImageVIew.h
//  STPhotoBroeser
//
//  Created by StriEver on 16/3/15.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol STImageViewDelegate;
@interface STImageVIew : UIImageView
@property (nonatomic, weak)id<STImageViewDelegate>delegate;
//@property (nonatomic,retain)PHAsset* phAsset;
@property (nonatomic,retain)NSData* imageData;//将转换好的二进制数据临时存储起来

-(void)resetView;
//-(void)translateAssetImage:(CGSize)targetSize completeHandler:(void (^)(STImageVIew*))completeHandler;
//显示imageData图片数据
-(void)showImage;
-(void)hideImage;

@end
@protocol STImageViewDelegate <NSObject>

- (void)stImageVIewSingleClick:(STImageVIew *)imageView;

@end