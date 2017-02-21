//
//  LCTabBarBadge.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCTabBarBadge.h"
//#import "LCTabBarCONST.h"

@implementation LCTabBarBadge

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.hidden = YES;
//        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        
//        NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"LCTabBarController" ofType:@"bundle"];
//        NSString *imagePath = [bundlePath stringByAppendingPathComponent:@"LCTabBarBadge@2x.png"];
//        [self setBackgroundImage:[self resizedImageFromMiddle:[UIImage imageWithContentsOfFile:imagePath]]
//                        forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont {
    
    _badgeTitleFont = badgeTitleFont;
    
    self.titleLabel.font = badgeTitleFont;
}

-(void)setBadgeColor:(UIColor *)badgeColor{
    _badgeColor = badgeColor;
    [self setNeedsDisplay];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    _badgeValue = [badgeValue copy];
    
    self.hidden = !self.badgeValue || self.badgeValue.length == 0;
    
    if (self.badgeValue && self.badgeValue.length > 0) {
        
//        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:badgeValue];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:strRange];
        [self setAttributedTitle:str forState:UIControlStateNormal];
        
        
        CGRect frame = self.frame;
        
        if (self.badgeValue.length > 1) {
        
            CGFloat badgeW = self.currentBackgroundImage.size.width;
            CGFloat badgeH = self.currentBackgroundImage.size.height;
            
            CGFloat paddingV = 10;
            CGFloat paddingH = 2;
            
            CGSize titleSize = [badgeValue sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.badgeTitleFont, NSFontAttributeName, nil]];
            frame.size.width = MAX(badgeW, titleSize.width + paddingV);
            frame.size.height = MAX(badgeH, titleSize.height + paddingH);
            self.frame = frame;
        }
        else {
            frame.size.width = self.badgeTitleFont.pointSize + 5;//12.0f;
            frame.size.height = frame.size.width;
        }
        
//        frame.origin.x = 58.0f * ([UIScreen mainScreen].bounds.size.width / self.tabBarItemCount) / 375.0f * 4.0f;
//        frame.origin.y = 2.0f;
        self.frame = frame;
        [self setNeedsDisplay];
    }
}

- (UIImage *)resizedImageFromMiddle:(UIImage *)image {
    
    return [self resizedImage:image width:0.5f height:0.5f];
}

- (UIImage *)resizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}

-(void)drawRect:(CGRect)rect{
    CGFloat cornerRadius = MIN(rect.size.width, rect.size.height) / 2.;
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [self.badgeColor setFill];
    [roundedRect fill];
}

@end
