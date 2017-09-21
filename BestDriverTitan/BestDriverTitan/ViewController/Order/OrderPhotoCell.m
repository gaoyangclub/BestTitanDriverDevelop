//
//  OrderPhotoCell.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderPhotoCell.h"
#import "FlatButton.h"
#import "QBImagePickerController.h"
#import "OwnerViewController.h"
#import "PhotoSelectionView.h"
#import "ShipmentTaskBean.h"

@interface OrderPhotoCell()

//@property(nonatomic,retain)ASTextNode* titleLabel;
@property(nonatomic,retain)PhotoSelectionView* photoView;

@end

@implementation OrderPhotoCell

//-(ASTextNode *)titleLabel{
//    if(!_titleLabel){
//        _titleLabel = [[ASTextNode alloc]init];
//        _titleLabel.layerBacked = YES;
//        [self.contentView.layer addSublayer:_titleLabel.layer];
//    }
//    return _titleLabel;
//}

-(PhotoSelectionView *)photoView{
    if (!_photoView) {
        _photoView = [[PhotoSelectionView alloc]init];
//        [[PhotoSelectionView alloc]initWithFrame:CGRectNull collectionViewLayout:[[UICollectionViewLayout alloc]init]];
        [self.contentView addSubview:_photoView];
//        _photoView.maxSelectCount = 6;//最多选6个
        _photoView.parentController = [OwnerViewController sharedInstance];
    }
    return _photoView;
}

-(BOOL)showSelectionStyle{
    return NO;
}

-(void)showSubviews{
    ShipmentTaskBean* bean = self.data;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat padding = 5;
    CGFloat itemHeight = self.contentView.height - padding * 2;
    
    self.photoView.frame = CGRectMake(padding, padding, self.contentView.width - padding * 2, itemHeight);
    self.photoView.itemSize = CGSizeMake(itemHeight, itemHeight);
    self.photoView.assetsArray = bean.assetsArray;
}


@end
