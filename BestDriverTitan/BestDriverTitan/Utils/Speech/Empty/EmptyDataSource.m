//
//  EmptyDataSource.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EmptyDataSource.h"

@implementation EmptyDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.netErrorDescription = @"网络中断，请检查网络状态!";
        self.netErrorTitle = @"点我重试";
        self.noDataIconName = ICON_EMPTY_WAN_CHENG;
    }
    return self;
}

#pragma DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    //    NSString *title = @"狮子王";
    //    NSDictionary *attributes = @{
    //                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
    //                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
    //                                 };
    //    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
    if (self.netError){
        return [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:100 content:ICON_EMPTY_WANG_LUO];
    }
    return self.noDataDescription ? [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:100 content:self.noDataIconName] : nil;
}

#pragma DZNEmptyDataSetSource
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    //    NSString *text = self->selectedTaskCode ? @"该类型任务已完成!" : @"任务已全部完成";
    //    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    //    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    //    paragraph.alignment = NSTextAlignmentCenter;
    //    NSDictionary *attributes = @{
    //                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
    //                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
    //                                 NSParagraphStyleAttributeName:paragraph
    //                                 };
    //    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    if (self.netError){
        return [NSString simpleAttributedString:[UIColor lightGrayColor] size:16 content:self.netErrorDescription];
    }
    return self.noDataDescription ? [NSString simpleAttributedString:[UIColor lightGrayColor] size:16 content:self.noDataDescription] : nil;
}

#pragma DZNEmptyDataSetSource
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    //    if (!self->selectedTaskCode) {
    //        NSString *text = ;
    //        UIFont   *font = [UIFont systemFontOfSize:15.0];
    //        // 设置默认状态、点击高亮状态下的按钮字体颜色
    //        UIColor  *textColor = (state == UIControlStateNormal) ? FlatSkyBlueDark : FlatBlue;
    //
    //        NSMutableDictionary *attributes = [NSMutableDictionary new];
    //        [attributes setObject:font      forKey:NSFontAttributeName];
    //        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    //
    //        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    //    }
    if (self.netError) {
        return [NSString simpleAttributedString:(state == UIControlStateNormal) ? FlatSkyBlueDark : FlatBlue size:15 content:self.netErrorTitle];
    }
    return self.buttonTitle ? [NSString simpleAttributedString:(state == UIControlStateNormal) ? FlatSkyBlueDark : FlatBlue size:15 content:self.buttonTitle] : nil;
}

#pragma DZNEmptyDataSetSource
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock();
    }
//    [self.tableView headerBeginRefresh];
}

#pragma DZNEmptyDataSetDelegate 空白是否允许滚动视图
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

@end
