//
//  PhotoSelectionView.h
//  BestDriverTitan
//  单行图片选择器 图片附件横向选择器 可删除选中附件
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSelectionView : UICollectionView

@property(nonatomic,retain) UIViewController* parentController;//用来弹出照片内容页的窗口
@property(nonatomic,assign) CGFloat hGap;
@property(nonatomic) CGSize itemSize;

@property(nonatomic,copy) NSString* title;

-(void)clearAll;//将图片清空

@end
