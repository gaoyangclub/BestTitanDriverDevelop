//
//  DIYTabBarItem.m
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DIYTabBarItem.h"
#import "LCTabBarBadge.h"

#define selectColor COLOR_PRIMARY
#define normalColor COLOR_NAVI_TITLE

@interface DIYTabBarItem(){
    BOOL badgeChange;
}

@property(nonatomic,retain) UILabel* titleLabel;
@property(nonatomic,retain) UILabel* imageLabel;//图片文本
//@property(nonatomic,retain) CustomBadge* customBadge;
@property(nonatomic,retain) LCTabBarBadge* lcTabBadge;

@end


@implementation DIYTabBarItem

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)imageLabel{
    if (!_imageLabel) {
        _imageLabel = [[UILabel alloc] init];
        _imageLabel.font = [UIFont fontWithName:ICON_FONT_NAME size: 25];
        [self addSubview:_imageLabel];
    }
    return _imageLabel;
}

//-(CustomBadge *)customBadge{
//    if (!_customBadge) {
//        _customBadge =
//        //[[CustomBadge alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        [CustomBadge customBadgeWithString:@"1" withScale:0.78];
////        _customBadge.badgeStyle = [[BadgeStyle alloc]init];
//        _customBadge.badgeStyle.badgeInsetColor = [UIColor colorWithRed:253/255. green:86/255. blue:56/255. alpha:1];
//        _customBadge.badgeStyle.badgeTextColor = [UIColor whiteColor];
//        _customBadge.userInteractionEnabled = NO;
//        [self addSubview:_customBadge];
//    }
//    return _customBadge;
//}

-(LCTabBarBadge *)lcTabBadge{
    if (!_lcTabBadge) {
        _lcTabBadge = [[LCTabBarBadge alloc] init];
        [self addSubview:_lcTabBadge];
        _lcTabBadge.badgeTitleFont = [UIFont systemFontOfSize:11];
        _lcTabBadge.badgeColor = [UIColor colorWithRed:253/255. green:86/255. blue:56/255. alpha:1];
    }
    return _lcTabBadge;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    badgeChange = YES;
    [super setBadgeValue:badgeValue];
}

//-(NSString *)badgeValue{
//    return @"9";
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    DIYBarData* tabData = (DIYBarData *)self.data;
    
    self.imageLabel.text = tabData.image;
    [self.imageLabel sizeToFit];
    
    self.titleLabel.text = tabData.title;
    [self.titleLabel sizeToFit];
    
    CGFloat centerX = CGRectGetWidth(self.bounds) / 2.;
    CGFloat titleY = CGRectGetHeight(self.bounds) * 2 / 3.;
    CGFloat imageCenterY = CGRectGetHeight(self.bounds) * 1 / 3.;
    
    self.imageLabel.center = CGPointMake(centerX, imageCenterY);
    self.titleLabel.center = CGPointMake(centerX, titleY + CGRectGetHeight(self.titleLabel.bounds) / 2.);
    if (self.selected) {
        self.titleLabel.textColor = selectColor;
        self.imageLabel.textColor = selectColor;
        self.imageLabel.text = tabData.selectedImage;
//        self.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.titleLabel.textColor = normalColor;
        self.imageLabel.textColor = normalColor;
        self.imageLabel.text = tabData.image;
//        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    if (badgeChange) {
        badgeChange = NO;
        if(self.badgeValue == NULL){
//            NSLog(@"badgeValue为空");
        }
        self.lcTabBadge.badgeValue = self.badgeValue;
    }
    CGRect badgeFrame = self.lcTabBadge.frame;
    badgeFrame.origin = CGPointMake(CGRectGetWidth(self.bounds) * 7 / 11. - CGRectGetWidth(badgeFrame) / 2, 2);
    self.lcTabBadge.frame = badgeFrame;
    
//    if (self.badgeValue) {
//        self.customBadge.hidden = NO;
//        self.customBadge.badgeText = self.badgeValue;
//        [self.customBadge autoBadgeSizeWithString:self.badgeValue];
//        CGRect customFrame = self.customBadge.frame;
//        customFrame.origin = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(self.customBadge.bounds),0);
////                                         * self.customBadge.badgeScaleFactor, 0);
//        self.customBadge.frame = customFrame;
//    }else{
//        self.customBadge.hidden = YES;
//    }
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    if(self.selected){
        //设置圆角矩形范围
        CGFloat toppadding = 2;
        CGFloat leftpadding = 5;
        CGRect pathRect = CGRectMake(leftpadding, toppadding, CGRectGetWidth(rect) - leftpadding * 2, CGRectGetHeight(rect) - toppadding * 2);
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:3.];
        
        [[selectColor colorWithAlphaComponent:0.3] setFill];
        [path fill];
    }
}

@end

@implementation DIYBarData

+(instancetype)initWithParams:(NSString *)title image:(NSString *)image{

    return [self initWithParams:title image:image selectedImage:nil];
}

+(instancetype)initWithParams:(NSString *)title image:(NSString *)image selectedImage:(NSString*)selectedImage;{
    DIYBarData *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.image = image;
            instance.selectedImage = selectedImage;
        }
    }
    return instance;
}

@end
