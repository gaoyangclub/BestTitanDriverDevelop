//
//  MathUtils.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/10/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MathUtils.h"

@implementation MathUtils

+(CGFloat)goldenSection{
    return 0.618;
}

//外接圆圆心
+(CGPoint)getTriangleOutCenter:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3{
    return (CGPoint){
        [MathUtils cal_center_x:x1 _:y1 _:x2 _:y2 _:x3 _:y3],
        [MathUtils cal_center_y:x1 _:y1 _:x2 _:y2 _:x3 _:y3]
    };
}

+(float)S:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3{
    return ((x1 - x3) * (y2 - y3) - (y1 - y3) * (x2 - x3));
}

+(float)cal_center_x:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3{
    return [MathUtils S:x1*x1+y1*y1 _:y1 _:x2*x2+y2*y2 _:y2 _:x3*x3+y3*y3 _:y3] / (2 * [MathUtils S:x1 _:y1 _:x2 _:y2 _:x3 _:y3]);
//    (S(x1*x1+y1*y1,y1, x2*x2+y2*y2, y2,x3*x3+y3*y3,y3)/(2*S(x1,y1,x2,y2,x3,y3)) )
}

+(float)cal_center_y:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3{
    return [MathUtils S:x1 _:x1*x1+y1*y1 _:x2 _:x2*x2+y2*y2 _:x3 _:x3*x3+y3*y3] / (2 * [MathUtils S:x1 _:y1 _:x2 _:y2 _:x3 _:y3]);
//    return (S(x1, x1*x1+y1*y1, x2, x2*x2+y2*y2, x3, x3*x3+y3*y3) / (2*S(x1,y1,x2,y2,x3,y3)));
}

//内切圆圆心
+(CGPoint)getTriangleInnerCenter:(float)x1 _:(float)y1 _:(float)x2 _:(float)y2 _:(float)x3 _:(float)y3{
    float dax = x1 - x2;
    float day = y1 - y2;
    
    float dbx = x3 - x2;
    float dby = y3 - y2;
    
    float const tempA = dax * dax + day * day * 1.0f;
    float const absA = sqrtf(tempA);
    float const tempB = dbx * dbx + dby * dby * 1.0f;
    float const absB = sqrtf(tempB);
    
    // 第一个角平分线方程
    // a(y - n1) = b(x - m1)
    float const ka = (absB * day - absA * dby);
    float const kb = (absA * dbx - absB * dax);

    
    dax = x1 - x3;
    day = y1 - y3;
    
    dbx = x2 - x3;
    dby = y2 - y3;
    
    float const tempC = dax * dax + day * day * 1.0f;
    float const absC = sqrtf(tempC);
    float const tempD = dbx * dbx + dby * dby * 1.0f;
    float const absD = sqrtf(tempD);
    
    float const kc = (absD * day - absC * dby);
    float const kd = (absC * dbx - absD * dax);
    
    float pointX = 0.0f;
    float pointY = 0.0f;
    if(ka != 0)
    {
        pointX = (kc * kb * x2 + y3 * ka * kc - y2 * ka * kc - ka * kd * x3) / (kc * kb - ka * kd);
        pointY = kb * (pointX - x2) / ka + y2;
        
    }else
    {
        pointX = x2;
        pointY = kd * (x2 - x3) / kc + y3;
    }
    return (CGPoint){pointX,pointY};
}


@end
