//
//  MathUtils.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/10/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MATH_GOLDEN_SECTION [MathUtils goldenSection]


@interface MathUtils : NSObject

//黄金比例值
+(CGFloat)goldenSection;

//三角形外接圆圆心
+(CGPoint)getTriangleOutCenter:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3;
//三角形内切圆圆心
+(CGPoint)getTriangleInnerCenter:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3;

@end
