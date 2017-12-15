//
//  TaskPhoneListView.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskPhoneListView.h"
#import "FlatButton.h"
#import "TaskContactCell.h"

@interface TaskPhoneListView()

@property(nonatomic,retain)FlatButton* cancelButton;

@end

@implementation TaskPhoneListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.minWidth = rpx(300);
        self.cellClass = [TaskContactCell class];
        self.clickItemDismiss = NO;
    }
    return self;
}

-(FlatButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[FlatButton alloc]init];
        [self.contentView addSubview:_cancelButton];
        _cancelButton.titleFontName = ICON_FONT_NAME;
        _cancelButton.titleSize = rpx(16);
        _cancelButton.titleColor = [UIColor whiteColor];
//        _cancelButton.strokeColor =
//        _cancelButton.strokeWidth = 1;
        _cancelButton.title = ICON_CLOSE;
        _cancelButton.fillColor = COLOR_ACCENT;
        _cancelButton.cornerRadius = MORE_BUTTON_RADIUS;
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(CGRect)getTableViewFrame{
    CGFloat const cancelWidth = MORE_BUTTON_RADIUS * 2;
    CGFloat const bottomMargin = rpx(20);
    
    self.cancelButton.frame = CGRectMake((self.contentView.width - cancelWidth) / 2., self.contentView.height - cancelWidth - bottomMargin, cancelWidth, cancelWidth);
    return CGRectMake(0, 0, self.contentView.width, self.cancelButton.y);
}

@end
