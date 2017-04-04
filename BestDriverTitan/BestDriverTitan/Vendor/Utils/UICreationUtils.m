
//
//  UICreationUtils.m
//  BestDriverTitan
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UICreationUtils.h"
#import "UIArrowView.h"

@implementation UICreationUtils

+(UILabel*)createNavigationTitleLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text superView:(UIView*)superView{
    UILabel* uiLabel = [UICreationUtils createLabel:size color:color text:text sizeToFit:YES superView:superView];
    if (superView) {
        uiLabel.center = superView.center;//手动对齐
    }
    return uiLabel;
}

+(UIBarButtonItem*)createNavigationLeftButtonItem:(UIColor*)themeColor target:(id)target action:(SEL)action{
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:target action:action];
//    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:target action:action];
    UIArrowView* customView = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
    customView.direction = ArrowDirectLeft;
    ////        customView.isClosed = true
    customView.lineColor = themeColor;//UIColor.whiteColor()
    customView.lineThinkness = 2;
    ////        customView.fillColor = UIColor.blueColor()
    buttonItem.customView = customView;
    [customView addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
//    customView.showTouchEffect = YES;
    [customView setShowTouch:YES];
    return buttonItem;
}

+(UIBarButtonItem*)createNavigationNormalButtonItem:(UIColor*)themeColor font:(UIFont*)font text:(NSString*)text target:(id)target action:(SEL)action{
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithTitle:text style:(UIBarButtonItemStylePlain) target:target action:action];
    [buttonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] forState:(UIControlStateNormal)];
    [buttonItem setTintColor:themeColor];
    return buttonItem;
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color{
    return [UICreationUtils createLabel:size color:color text:@"" sizeToFit:NO superView:nil];
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit{
    return [UICreationUtils createLabel:size color:color text:text sizeToFit:sizeToFit superView:nil];
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit superView:(UIView*)superView{
    UILabel* uiLabel = [[UILabel alloc]init];
    if(superView){
        [superView addSubview:uiLabel];
    }
    uiLabel.font = [UIFont systemFontOfSize:size];//UIFont(name: "Arial Rounded MT Bold", size: size)
    uiLabel.textColor = color;
    uiLabel.text = text;
    uiLabel.userInteractionEnabled = false; //默认没有交互
    if(sizeToFit){
        [uiLabel sizeToFit];
    }
    return uiLabel;
}


@end
