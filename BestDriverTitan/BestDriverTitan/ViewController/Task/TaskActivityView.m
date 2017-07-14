//
//  TaskActivityController.m
//  BestDriverTitan
//  活动按钮选择界面 从TaskTripConrtoller弹窗出来
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskActivityView.h"
#import "CircleNode.h"


@interface ActivityArea:UIControl

@property(nonatomic,retain)ShipmentActivityBean* data;//活动数据

@property(nonatomic,retain)CircleNode* backNode;
@property(nonatomic,retain)ASTextNode* iconNode;
@property(nonatomic,retain)ASTextNode* labelNode;
@property(nonatomic,retain)ASControlNode* alertNode;//警告货量差异
//@property(nonatomic,retain)ASTextNode* stateNode;//完成情况状态

-(void)sizeToFit;//根据容器内容重新布局

@end

@implementation ActivityArea

-(CircleNode *)backNode{
    if (!_backNode) {
        _backNode = [[CircleNode alloc]init];
        _backNode.layerBacked = YES;
//        _backNode.strokeWidth = 0;
        _backNode.fillColor = COLOR_PRIMARY;
        [self.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

-(ASTextNode *)iconNode{
    if (!_iconNode) {
        _iconNode = [[ASTextNode alloc]init];
        _iconNode.layerBacked = YES;
        [self.backNode addSubnode:_iconNode];
    }
    return _iconNode;
}

-(ASTextNode *)labelNode{
    if (!_labelNode) {
        _labelNode = [[ASTextNode alloc]init];
        _labelNode.layerBacked = YES;
        [self.layer addSublayer:_labelNode.layer];
    }
    return _labelNode;
}

-(void)sizeToFit{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);

//    self.backNode.cornerRadius = viewWidth / 2;
    self.backNode.frame = CGRectMake(0, 0, viewWidth, viewWidth);
    
    self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor whiteColor] size:30 content:[Config getActivityIconByCode:self.data.activityDefinitionCode]];
    CGSize iconSize = [self.iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.iconNode.frame = (CGRect){CGPointMake((viewWidth - iconSize.width) / 2., (viewWidth - iconSize.height) / 2.),iconSize};
    
    self.labelNode.attributedString = [NSString simpleAttributedString:FlatGray size:14 content:[Config getActivityLabelByCode:self.data.activityDefinitionCode]];
    CGSize labelSize = [self.labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.labelNode.frame = (CGRect){CGPointMake((viewWidth - labelSize.width) / 2., viewHeight - labelSize.height),labelSize};
}

@end

@interface TaskActivityView ()

@property(nonatomic,retain)UIButton* cancelButton;
@property(nonatomic,retain)CircleNode* cancelCircle;

@end

@implementation TaskActivityView

-(CircleNode *)cancelCircle{
    if (!_cancelCircle) {
        _cancelCircle = [[CircleNode alloc]init];
        _cancelCircle.layerBacked = YES;
        _cancelCircle.strokeColor = COLOR_PRIMARY;
        _cancelCircle.strokeWidth = 1.5;
        _cancelCircle.fillColor = [UIColor clearColor];
        [self.cancelButton.layer addSublayer:_cancelCircle.layer];
    }
    return _cancelCircle;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:ICON_CLOSE forState:UIControlStateNormal];
        [_cancelButton setTitleColor:COLOR_PRIMARY forState:UIControlStateNormal];
        
        _cancelButton.underlineNone = YES;
        
//        _cancelButton.layer.borderColor = COLOR_PRIMARY.CGColor;
//        _cancelButton.layer.borderWidth = 1;
        
        _cancelButton.titleLabel.font = [UIFont fontWithName:ICON_FONT_NAME size:16];
        
        [self.contentView addSubview:_cancelButton];
        
        [_cancelButton setShowTouch:YES];
    }
    return _cancelButton;
}

- (void)viewDidLoad {
    
    self.popFromDirection = CustomPopDirectionBottom;
    self.popToDirection = CustomPopDirectionBottom;
    self.cancelOnTouchOutside = NO;
    
    CGFloat bottomMargin = 20;
    
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds);
    
    CGFloat cancelWidth = MORE_BUTTON_RADIUS * 2;
    
    self.cancelButton.frame = CGRectMake((viewWidth - cancelWidth) / 2., viewHeight - cancelWidth - bottomMargin, cancelWidth, cancelWidth);
    self.cancelCircle.frame = self.cancelButton.bounds;
    
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self mearsureActivityButtons];
}

-(void)mearsureActivityButtons{
    CGFloat bottomMargin = 20;
    
    CGFloat itemWidth = 50;
    CGFloat itemHeight = 65;
    
    CGFloat vGap = 10;
    
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds) - MORE_BUTTON_RADIUS * 2 - bottomMargin;
    
    NSInteger cloumCount = 2;//列数
    
    NSInteger totalcount = self.activityBeans.count;
    
    NSInteger rowCount = (totalcount - 1) / cloumCount + 1;//行数
    
    CGFloat topMargin = (viewHeight - (rowCount * itemHeight + (rowCount - 1) * vGap)) / 2.;
    CGFloat leftMargin = (viewWidth - cloumCount * itemWidth) / (cloumCount + 1);
    CGFloat hGap = leftMargin;
    
    for (NSInteger i = 0; i < totalcount; i++) {
        ActivityArea* button = [[ActivityArea alloc]initWithFrame:
                                  CGRectMake(leftMargin + i % cloumCount * (itemWidth + hGap),
                                            topMargin + ((NSInteger)(i / cloumCount)) * (itemHeight + vGap),
                                                                                 itemWidth, itemHeight)];
        [self.contentView addSubview:button];
        button.data = self.activityBeans[i];
        [button setShowTouch:YES];
        [button sizeToFit];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttonClick:(ActivityArea*)sender{
    if (self.taskActivityDelegate && [self.taskActivityDelegate respondsToSelector:@selector(activitySelected:)]) {
        [self.taskActivityDelegate activitySelected:sender.data];
    }
    [self dismiss];
}


@end
