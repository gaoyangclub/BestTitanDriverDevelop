//
//  CircleNode.h
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface CircleNode : ASDisplayNode

@property(nonatomic,retain) UIColor* fillColor;
@property(nonatomic,retain) UIColor* strokeColor;
@property(nonatomic,assign) CGFloat strokeWidth;

@end
