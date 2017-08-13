//
//  PhotoSelectionView.h
//  BestDriverTitan
//  单行图片选择器 图片附件横向选择器 可删除选中附件
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoTranslateUtils.h"

@interface PhotoSelectionView : UICollectionView

@property(nonatomic,retain) UINavigationController* parentController;//用来弹出照片内容及跳转页面的窗口
@property(nonatomic,assign) CGFloat hGap;
@property(nonatomic) CGSize itemSize;
@property(nonatomic,assign) NSInteger maxSelectCount;

@property(nonatomic,copy) NSString* title;

@property(nonatomic,retain) NSMutableArray<PhotoAlbumVo*>* assetsArray;

-(void)clearAll;//将图片清空
-(void)showActionSheet;
-(void)showPhotoByIndexPath:(NSIndexPath*)indexPath;

@end
