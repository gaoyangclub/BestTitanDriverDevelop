//
//  PhotoSelectionView.h
//  BestDriverTitan
//  单行图片选择器 图片附件横向选择器 可删除选中附件
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoTranslateUtils.h"

@class PhotoSelectionView;

@protocol PhotoSelectionDelegate <NSObject>
@optional
-(void)photoAdded:(PhotoSelectionView*)selectionController;//有数据添加了
@optional
-(void)photoDeleted:(PhotoSelectionView*)selectionController;//有数据删除了
@optional
-(void)contentSizeChanged:(PhotoSelectionView*)selectionController contentSize:(CGSize)contentSize;

@end

@interface PhotoSelectionView : UICollectionView

@property(nonatomic,retain) UINavigationController* parentController;//用来弹出照片内容及跳转页面的窗口
@property(nonatomic,assign) CGFloat hGap;
@property(nonatomic) CGSize itemSize;
@property(nonatomic) UICollectionViewScrollDirection scrollDirection;//默认横向
@property(nonatomic,assign) NSInteger maxSelectCount;

@property(nonatomic,copy) NSString* title;

@property(nonatomic,retain) NSMutableArray<PhotoAlbumVo*>* assetsArray;

@property(nonatomic, weak) id<PhotoSelectionDelegate> selectionDelegate;

-(void)clearAll;//将图片清空
-(void)showActionSheet;
-(void)showPhotoByIndexPath:(NSIndexPath*)indexPath;

@end
