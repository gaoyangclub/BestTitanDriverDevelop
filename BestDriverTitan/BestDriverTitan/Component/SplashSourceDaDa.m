//
//  SplashSourceDaDa.m
//  SplashViewTest
//
//  Created by admin on 16/9/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SplashSourceDaDa.h"
//#import "CACircleLayer.h"

@interface SplashSourceDaDa (){
    BOOL isAnimation;//
}

@property(nonatomic,retain) UIImageView* logoImg;
@property(nonatomic,retain) UILabel* nameLab;// 达达
@property(nonatomic,retain) UILabel* desLab;

@end

@implementation SplashSourceDaDa


-(UIImageView *)logoImg{
    if (_logoImg == NULL) {
        UIImage* image = [UIImage imageNamed:@"splashLogo"];
        _logoImg = [[UIImageView alloc]initWithImage:image];
        _logoImg.contentMode = UIViewContentModeScaleAspectFit;
//        _logoImg.layer.position = CGPointMake(190, 0);
        
//        _logoImg.layer.cornerRadius = 15;
//        _logoImg.layer.masksToBounds = YES;
        
        [self addSubview:_logoImg];
    }
    return _logoImg;
}

-(UILabel *)nameLab{
    if (_nameLab == NULL) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"百世通";
        _nameLab.font = [UIFont systemFontOfSize:40];
        _nameLab.textColor = [UIColor whiteColor];//[[UIColor alloc]initWithRed:58.0/255 green:139.0/255 blue:253.0/255 alpha:1];
        [_nameLab sizeToFit];
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc]init];
        _desLab.font = [UIFont systemFontOfSize:25];
        _desLab.textColor = [UIColor whiteColor];//[UIColor colorWithRed:58.0/255 green:139.0/255 blue:253.0/255 alpha:1];
        _desLab.text = @"在路上一直伴您左右";
        [_desLab sizeToFit];
        [self addSubview:_desLab];
    }
    return _desLab;
}

-(void)display{
    
    self.backgroundColor = COLOR_PRIMARY;
    
    CGFloat screenWidth = self.frame.size.width;
    CGFloat screenHeight = self.frame.size.height;
    
    CGFloat logoWidth = 150;
    
    CGFloat offset = -15;
    
    self.logoImg.frame = CGRectMake((screenWidth - logoWidth) / 2 + offset, (screenHeight - logoWidth) / 2 - 80 , logoWidth, logoWidth);
    
    CGFloat nameWidth = self.nameLab.frame.size.width;
    CGFloat nameHeight = self.nameLab.frame.size.height;
    CGFloat nameY = (screenHeight - nameHeight) / 2 + 30;
    self.nameLab.frame = CGRectMake((screenWidth - nameWidth) / 2, nameY, nameWidth, nameHeight);
    
    CGFloat desWidth = self.desLab.frame.size.width;
    CGFloat desHeight = self.desLab.frame.size.height;
    self.desLab.frame = CGRectMake((screenWidth - desWidth) / 2,nameY + 65, desWidth, desHeight);
    
    
    [self animationDaDaLogo];
    [self animationLabel];
}


- (void) animationDaDaLogo
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1 / 100.0f;   // 设置视点在Z轴正方形z=100
    
    // 动画结束时，在Z轴负方向60
    CATransform3D startTransform = CATransform3DTranslate(transform, 0, 0, -60);
    // 动画结束时，绕Y轴逆时针旋转90度
    CATransform3D firstTransform = CATransform3DRotate(startTransform, M_PI_2, 0, 1, 0);
    // 动画开始时，绕Y轴顺时针旋转90度
    CATransform3D secondTransform = CATransform3DRotate(startTransform, -M_PI_2, 0, 1, 0);
    
    // 通过CABasicAnimation修改transform属性
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 向后移动同时绕Y轴逆时针旋转90度
    animation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation1.toValue = [NSValue valueWithCATransform3D:firstTransform];
    animation1.duration = 0.5;
//    animation1.removedOnCompletion = NO;    // 动画结束时停止，不回复原样
    animation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 向前移动同时绕Y轴逆时针旋转90度
    animation2.fromValue = [NSValue valueWithCATransform3D:secondTransform];
    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation2.duration = 0.5f;
    animation2.beginTime = 0.6f;
//    animation2.removedOnCompletion = NO;    // 动画结束时停止，不回复原样
    animation2.fillMode = kCAFillModeForwards;
    
    // 虽然只有一个动画，但用Group只为以后好扩展
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2];
    group.duration = 2;
//    animationGroup.delegate = self;     // 动画回调，在动画结束调用animationDidStop
//    animationGroup.removedOnCompletion = NO;    // 动画结束时停止，不回复原样
    group.fillMode = kCAFillModeForwards;
    group.repeatCount = FLT_MAX;
    
    [self.logoImg.layer addAnimation:group forKey:nil];//@"FristAnimation"
}

-(void)animationLabel{
//    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation1.fromValue = @0;
//    animation1.toValue = @1;
//    animation1.duration = 0.5;
//    animation1.fillMode = kCAFillModeForwards;
//    animation1.repeatCount = FLT_MAX;
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];//关键帧动画
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 0.5)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.5)]];
    animation1.values = values;
    animation1.duration = 1;
    animation1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.fromValue = @1.0;
    animation2.toValue = @0;
    animation2.duration = 0.5;
    animation2.fillMode = kCAFillModeForwards;
    animation2.beginTime = 1.5;
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2];
    group.duration = 2;
    group.fillMode = kCAFillModeForwards;
    group.repeatCount = FLT_MAX;
//    group.delegate = self;
    
    [self.nameLab.layer addAnimation:group forKey:nil];
    [self.desLab.layer addAnimation:group forKey:nil];
}

-(void)removeFromSuperview{
    [self.logoImg.layer removeAllAnimations];
    [self.nameLab.layer removeAllAnimations];
    [self.desLab.layer removeAllAnimations];
    [super removeFromSuperview];
}

@end
