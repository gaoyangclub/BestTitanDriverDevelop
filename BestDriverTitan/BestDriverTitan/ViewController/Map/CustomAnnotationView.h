//
//  CustomAnnotationView.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotationView : MAPinAnnotationView

@property(nonatomic,copy)NSString* title;
@property(nonatomic,retain)UIColor* titleColor;
@property(nonatomic,assign)NSInteger titleSize;
@property(nonatomic,retain)UIColor* backColor;

@end
