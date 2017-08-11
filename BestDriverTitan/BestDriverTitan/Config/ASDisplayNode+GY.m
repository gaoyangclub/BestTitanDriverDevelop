//
//  ASDisplayNode+GY.m
//  BestDriverTitan
//
//  Created by admin on 17/2/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ASDisplayNode+GY.h"

@implementation ASDisplayNode (GY)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.x = centerX - self.width / 2.;
}

- (CGFloat)centerX
{
    return self.x + self.width / 2.;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.y = centerY - self.height / 2.;
}

- (CGFloat)centerY
{
    return self.y + self.height / 2.;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(void)setMaxX:(CGFloat)maxX{
    self.x = maxX - self.width;
}

-(CGFloat)maxX{
    return self.x + self.width;
}

-(void)setMaxY:(CGFloat)maxY{
    self.y = maxY - self.height;
}

-(CGFloat)maxY{
    return self.y + self.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)removeAllSubNodes{
    for (ASDisplayNode* subNode in self.subnodes) {//子对象全部移除干净
        [subNode removeFromSupernode];
    }
}

@end
