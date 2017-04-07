//
//  OrderNormalCell.m
//  BestDriverTitan
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderNormalCell.h"
#import "DiyNumberAddView.h"

@interface OrderNormalCell()

@property(nonatomic,retain)DiyNumberAddView* countNumberView;

@end

@implementation OrderNormalCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(DiyNumberAddView *)countNumberView{
    if (!_countNumberView) {
        _countNumberView = [[DiyNumberAddView alloc]init];
        [self.contentView addSubview:_countNumberView];
        _countNumberView.cornerRadius = 5;
        _countNumberView.fillColor = [UIColor whiteColor];
        _countNumberView.strokeWidth = 1;
        _countNumberView.strokeColor = COLOR_LINE;
    }
    return _countNumberView;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.countNumberView.frame = CGRectMake(10, 10, 100, 30);
}

-(BOOL)showSelectionStyle{
    return NO;
}

@end
