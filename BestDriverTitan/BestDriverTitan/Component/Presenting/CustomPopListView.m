//
//  CustomComboboxView.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopListView.h"
#import "FlatButton.h"
#import "MJTableBaseView.h"

@interface PopTableViewCell : MJTableViewCell

@end
@implementation PopTableViewCell

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    self.textLabel.textColor = [UIColor blackColor];//COLOR_BLACK_ORIGINAL;
    self.textLabel.text = (NSString*)self.data;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end

@interface CustomPopListView()<UITableViewDelegate>

//@property(nonatomic,retain)UIScrollView* scrollView;
@property(nonatomic,retain)MJTableBaseView* tableView;

@end

@implementation CustomPopListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.dataField = @"label";
        self.popFromDirection = CustomPopDirectionBottom;
        self.popToDirection = CustomPopDirectionBottom;
        self.clickItemDismiss = YES;
    }
    return self;
}

-(MJTableBaseView *)tableView{
    if (!_tableView) {
        _tableView = [[MJTableBaseView alloc]initWithFrameAndParams:CGRectZero showHeader:NO showFooter:NO useCellIdentifer:YES topEdgeDiverge:NO];
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc]init];
//        [self.contentView addSubview:_scrollView];
//    }
//    return _scrollView;
//}

-(CGRect)getTableViewFrame{
    return self.contentView.bounds;
}

-(void)viewDidLoad{
    self.tableView.frame = [self getTableViewFrame];
    
//    CGFloat buttonWidth = CGRectGetWidth(self.contentView.bounds);
//    CGFloat buttonHeight = 50;

    //为null或者前后时间不一致
    NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
    SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:0 headerClass:NULL headerData:NULL];
    [self.tableView addSource:svo];
    self.tableView.delegate = self;
    
    Class viewClass;
    if (self.cellClass) {
        viewClass = self.cellClass;
    }else{
        viewClass = [PopTableViewCell class];
    }
    NSInteger count = self.dataArray.count;
    for (NSInteger i = 0 ; i < count; i ++) {
        NSObject* data = self.dataArray[i];
        NSObject* viewData;
        if(viewClass || [data isKindOfClass:[NSString class]]){
            viewData = data;
        }else{
            viewData = [data valueForKey:self.dataField];
        }
        [sourceData addObject:
         [CellVo initWithParams:50 cellClass:viewClass cellData:viewData]];
//        FlatButton* button = [[FlatButton alloc]init];
//        
//        button.title = title;
//        button.titleColor = COLOR_BLACK_ORIGINAL;
//        button.fillColor = [UIColor clearColor];
//        
//        button.frame = CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight);
//        button.tag = i;
//        [self.scrollView addSubview:button];
//        
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
//    self.scrollView.contentSize = CGSizeMake(buttonWidth, buttonHeight * count);
    
    [self.tableView reloadMJData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:index:)]){
            [self.delegate onSelectedIndex:self index:indexPath.row];
        }
        if ([self.delegate respondsToSelector:@selector(onSelectedItem:item:)]) {
            [self.delegate  onSelectedItem:self item:self.dataArray[indexPath.row]];
        }
    }
    //    button.tag;
    if (self.clickItemDismiss) {
        [self dismiss];
    }
}

-(void)buttonClick:(UIView*)button{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:index:)]){
            [self.delegate onSelectedIndex:self index:button.tag];
        }
        if ([self.delegate respondsToSelector:@selector(onSelectedItem:item:)]) {
            [self.delegate  onSelectedItem:self item:self.dataArray[button.tag]];
        }
    }
//    button.tag;
    [self dismiss];
}

@end
