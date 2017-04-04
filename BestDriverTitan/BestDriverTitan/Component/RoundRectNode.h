//
//  RoundRectNode.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/2/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface RoundRectNode : ASDisplayNode

@property(nonatomic,retain) UIColor* fillColor;
@property(nonatomic,assign) CGFloat cornerRadius;
@property(nonatomic,assign) CGFloat topLeftRadius;
@property(nonatomic,assign) CGFloat topRightRadius;
@property(nonatomic,assign) CGFloat bottomRightRadius;
@property(nonatomic,assign) CGFloat bottomLeftRadius;
@property(nonatomic,retain) UIColor* strokeColor;
@property(nonatomic,assign) CGFloat strokeWidth;

@end
