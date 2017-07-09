//
//  UIButton+Style.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

static const void *UnderlineNoneKey = &UnderlineNoneKey;

@dynamic underlineNone;

+(void)load{
    [self swizzleMethod:@selector(setTitle:forState:) withMethod:@selector(setTitleChange:forState:)];
    [self swizzleMethod:@selector(setTitleColor:forState:) withMethod:@selector(setTitleColorChange:forState:)];
    [self swizzleMethod:@selector(layoutSubviews) withMethod:@selector(layoutSubviewsChange)];
}

-(void)setUnderlineNone:(BOOL)underlineNone{
    //存储
    objc_setAssociatedObject(self, UnderlineNoneKey, @(underlineNone), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsLayout];
}

-(BOOL)underlineNone{
    return objc_getAssociatedObject(self, UnderlineNoneKey);
}

-(void)checkUnderline{
    BOOL value = self.underlineNone;
    if(value){
        NSString *text = [self titleForState:UIControlStateNormal];
        UIColor* color = [self titleColorForState:UIControlStateNormal];
        if (text) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
            //    [str addAttribute:NSForegroundColorAttributeName value:ColorForGestureButton range:NSMakeRange(0,forgetPasswordText.length)];
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0,text.length)];
            
            [str addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0,text.length)];
            
            [self setAttributedTitle:str forState:UIControlStateNormal];
        }
    }
//    else{
//        NSString *text = [self titleForState:UIControlStateNormal];
//        UIColor* color = [self titleColorForState:UIControlStateNormal];
//        if (text) {
//            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
//            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0,text.length)];
//            
//            [str addAttribute:NSStrokeColorAttributeName value:color range:NSMakeRange(0,text.length)];
//            
//            [self setAttributedTitle:str forState:UIControlStateNormal];
//        }
//    }
}

-(void)setTitleChange:(nullable NSString *)title forState:(UIControlState)state{
    [self setTitleChange:title forState:state];
//    [self checkUnderline];
    [self setNeedsLayout];
}

- (void)setTitleColorChange:(nullable UIColor *)color forState:(UIControlState)state{
    [self setTitleColorChange:color forState:state];
    [self setNeedsLayout];
}


-(void)layoutSubviewsChange{
    [self layoutSubviewsChange];
    [self checkUnderline];
}



@end
