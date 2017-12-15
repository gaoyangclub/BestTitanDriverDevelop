//
//  OrderReceiptCell.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderReceiptCell.h"
#import "PhotoSelectionView.h"
#import "OwnerViewController.h"
#import "ShipmentTaskBean.h"

#define RECEIPT_PHOTO_GAP rpx(5)

static CGFloat minOrderReceiptHeight;

@interface OrderReceiptCell()<PhotoSelectionDelegate>{
    BOOL photoNeedMeasure;
}

@property(nonatomic,retain)PhotoSelectionView* photoView;

@end

@implementation OrderReceiptCell


-(PhotoSelectionView *)photoView{
    if (!_photoView) {
        _photoView = [[PhotoSelectionView alloc]init];
        //        [[PhotoSelectionView alloc]initWithFrame:CGRectNull collectionViewLayout:[[UICollectionViewLayout alloc]init]];
        [self.contentView addSubview:_photoView];
        _photoView.maxSelectCount = 50;//最多选6个//不做限制
        _photoView.parentController = [OwnerViewController sharedInstance];
        _photoView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _photoView.selectionDelegate = self;
    }
    return _photoView;
}

-(BOOL)showSelectionStyle{
    return NO;
}

-(CGFloat)getCellHeight:(CGFloat)cellWidth{
    
    ShipmentTaskBean* bean = self.data;
    self.contentView.backgroundColor = [UIColor whiteColor];
//    CGFloat viewWidth = self.tableView.width;
    CGFloat padding = RECEIPT_PHOTO_GAP;
    NSInteger hCount = 3;//一排3个
//    NSLog(@"屏幕宽度%f",[UIScreen mainScreen].nativeBounds.size.width);
    if (SCREEN_WIDTH > IPHONE_5S_WIDTH) {
        hCount = 4;
    }
//    if (SYSTEM_SCALE > 2) {//3倍大小多一个
//    }
    
    CGFloat itemWidth = (cellWidth - padding * 2 - padding * (hCount - 1)) / hCount;
    self.photoView.hGap = padding;
    self.photoView.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.photoView.assetsArray = bean.assetsArray;
    if(self.cellVo.cellHeight > 0){
        self.photoView.frame = CGRectMake(padding, padding, cellWidth - padding * 2, self.cellVo.cellHeight - padding * 2);
        return 0;
    }else{
        NSInteger itemCount = 2;
        if (SYSTEM_SCALE > 2) {
            itemCount = 3;
        }
        if (!minOrderReceiptHeight) {
            minOrderReceiptHeight = itemWidth * itemCount + padding * (itemCount - 1);
        }
        self.photoView.frame = CGRectMake(padding, padding, cellWidth - padding * 2, minOrderReceiptHeight);
        return minOrderReceiptHeight + padding * 2;
    }
}

////-(void)showSubviews{
//    if (self->noShowData) {
//        return;
//    }
//    
//    ShipmentTaskBean* bean = self.data;
//    
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    
//    CGFloat padding = RECEIPT_PHOTO_GAP;
////    CGFloat itemHeight = self.contentView.height - padding * 2;
//    NSInteger hCount = 3;//一排3个
//    CGFloat itemWidth = (self.contentView.width - padding * 2 - padding * hCount) / hCount - 2;
//   
//    self.photoView.hGap = padding;
//    
//    self.photoView.frame = CGRectMake(padding, padding, self.contentView.width - padding * 2 + 1, self.contentView.height - padding * 2);
//    self.photoView.itemSize = CGSizeMake(itemWidth, itemWidth);
//    self.photoView.assetsArray = bean.assetsArray;
//}

-(void)contentSizeChanged:(PhotoSelectionView *)selectionController contentSize:(CGSize)contentSize{
    if(self->photoNeedMeasure){
        CGFloat padding = RECEIPT_PHOTO_GAP;
        CGFloat targetHeight = contentSize.height + padding * 2;
        if (targetHeight < minOrderReceiptHeight) {
            targetHeight = minOrderReceiptHeight;
        }
//    if (contentSize.height > self.photoView.height) {
        self.cellVo.cellHeight = targetHeight;
        self.photoView.height = targetHeight - padding * 2;
//        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView deselectRowAtIndexPath:self.indexPath animated:YES];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        self->photoNeedMeasure = NO;
    }
}

-(void)photoAdded:(PhotoSelectionView *)selectionController{
    self->photoNeedMeasure = YES;
//    if (self.photoView.contentSize.height + RECEIPT_PHOTO_GAP * 2 > self.contentView.height) {
//        CGFloat padding = RECEIPT_PHOTO_GAP;
//        self.cellVo.cellHeight = self.photoView.contentSize.height + padding * 2;
//        self.photoView.frame = CGRectMake(padding, padding, self.contentView.width - padding * 2 + 1, self.contentView.height - padding * 2);
//        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
//    }
}
//
-(void)photoDeleted:(PhotoSelectionView *)selectionController{
    self->photoNeedMeasure = YES;
//    CGFloat padding = RECEIPT_PHOTO_GAP;
//    self.cellVo.cellHeight = self.photoView.contentSize.height + padding * 2;
//    self.photoView.frame = CGRectMake(padding, padding, self.contentView.width - padding * 2 + 1, self.contentView.height - padding * 2);
//    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
}



@end
