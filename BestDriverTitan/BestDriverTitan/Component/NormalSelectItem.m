//
//  NormalSelectItem.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NormalSelectItem.h"
#import "RoundRectNode.h"
#import "UIArrowView.h"

@interface NormalSelectItem()

@property(nonatomic,retain)ASDisplayNode* topLine;
@property(nonatomic,retain)ASDisplayNode* bottomLine;
@property(nonatomic,retain)RoundRectNode* iconArea;
@property(nonatomic,retain)ASTextNode* iconText;
@property(nonatomic,retain)UIArrowView* rightArrow;

@property(nonatomic,retain)ASTextNode* labelText;

@end

@implementation NormalSelectItem

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.strokeWidth = 0.5;
        self.showTopLine = YES;
        self.showBottomLine = YES;
        self.showRightArrow = YES;
        self.showIconLine = YES;
        self.arrowStrokeWidth = 2;
        self.arrowSize = CGSizeMake(8, 14);
        self.iconMargin = 10;
//        self.iconName = ICON_WO_DE_SELECTED;
//        self.iconSize = 36;
        self.iconColor = [UIColor whiteColor];
//        self.iconBackColor = COLOR_PRIMARY;
        self.iconCornerRadius = 5;
        
        self.showLabel = YES;
        self.labelName = @"";
        self.labelSize = 14;
        self.labelColor = [UIColor blackColor];
    }
    return self;
}

-(ASDisplayNode *)topLine{
    if (!_topLine) {
        _topLine = [[ASDisplayNode alloc]init];
        _topLine.layerBacked = YES;
        [self.layer addSublayer:_topLine.layer];
    }
    return _topLine;
}

-(ASDisplayNode *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[ASDisplayNode alloc]init];
        _bottomLine.layerBacked = YES;
        [self.layer addSublayer:_bottomLine.layer];
    }
    return _bottomLine;
}

-(RoundRectNode *)iconArea{
    if (!_iconArea) {
        _iconArea = [[RoundRectNode alloc]init];
        _iconArea.layerBacked = YES;
        [self.layer addSublayer:_iconArea.layer];
    }
    return _iconArea;
}

-(ASTextNode *)iconText{
    if (!_iconText) {
        _iconText = [[ASTextNode alloc]init];
        _iconText.layerBacked = YES;
        [self.iconArea addSubnode:_iconText];
    }
    return _iconText;
}

-(ASTextNode *)labelText{
    if (!_labelText) {
        _labelText = [[ASTextNode alloc]init];
        _labelText.layerBacked = YES;
        [self.layer addSublayer:_labelText.layer];
    }
    return _labelText;
}

-(UIArrowView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [[UIArrowView alloc]init];
        _rightArrow.direction = ArrowDirectRight;
//                _rightArrow.lineColor = COLOR_LINE;
        [self addSubview:_rightArrow];
    }
    return _rightArrow;
}

-(void)setLabelName:(NSString *)labelName{
    _labelName = labelName;
    [self setNeedsLayout];
}

-(void)setLabelColor:(UIColor *)labelColor{
    _labelColor = labelColor;
    [self setNeedsLayout];
}

-(void)setLabelSize:(CGFloat)labelSize{
    _labelSize = labelSize;
    [self setNeedsLayout];
}

//-(void)setFrame:(CGRect)frame{
//    [super setFrame:frame];
//    //重新布局
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    self.topLine.hidden = !self.showTopLine;
    if (self.showTopLine) {
        self.topLine.backgroundColor = self.strokeColor;
        self.topLine.frame = CGRectMake(self.lineTopLeftMargin, 0, viewWidth - self.lineTopLeftMargin - self.lineTopRightMargin, self.strokeWidth);
    }
    
    self.bottomLine.hidden = !self.showBottomLine;
    if (self.showBottomLine) {
        self.bottomLine.backgroundColor = self.strokeColor;
        self.bottomLine.frame = CGRectMake(self.lineBottomLeftMargin, viewHeight - self.strokeWidth, viewWidth - self.lineBottomLeftMargin - self.lineBottomRightMargin, self.strokeWidth);
    }
    
    CGFloat iconHeight = viewHeight - self.iconMargin * 2;
    
    if(self.showIconLine){
        self.iconArea.strokeColor = self.strokeColor;
        self.iconArea.strokeWidth = self.strokeWidth;
    }else{
        self.iconArea.strokeWidth = 0;
        self.iconArea.strokeColor = [UIColor clearColor];
    }
    self.iconArea.cornerRadius = self.iconCornerRadius;
    self.iconArea.fillColor = self.iconBackColor;
    
    
    self.iconArea.frame = CGRectMake(self.iconMargin, self.iconMargin, iconHeight, iconHeight);
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.iconColor size:self.iconSize content:self.iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.iconText.frame = (CGRect){
        CGPointMake((iconHeight - iconSize.width) / 2., (iconHeight - iconSize.height) / 2.),
        iconSize
    };
    
    self.labelText.hidden = !self.showLabel;
    if (self.showLabel) {
        self.labelText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.labelColor size:self.labelSize content:self.labelName];
        CGSize labelSize = [self.labelText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        self.labelText.frame = (CGRect){
            CGPointMake(self.iconMargin * 2 + iconHeight, (viewHeight - labelSize.height) / 2.),
            labelSize
        };
    }
    
    self.rightArrow.hidden = !self.showRightArrow;
    if (self.showRightArrow) {
        self.rightArrow.lineColor = self.strokeColor;
        self.rightArrow.lineThinkness = self.arrowStrokeWidth;
        self.rightArrow.frame = (CGRect){
            CGPointMake(viewWidth - self.iconMargin - self.arrowSize.width, (viewHeight - self.arrowSize.height) / 2.),
            self.arrowSize
        };
    }
    
    
}


@end
