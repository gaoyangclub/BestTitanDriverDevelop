//
//  DiyLicensePlateNode.m
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DiyLicensePlateNode.h"
#import "RoundRectNode.h"
#import "CircleNode.h"

@interface DiyLicensePlateNode(){
    UIColor* _fillColor;
    UIColor* _compleColor;
}
@property (nonatomic,retain)RoundRectNode* back1;
@property (nonatomic,retain)RoundRectNode* back2;
@property (nonatomic,retain)RoundRectNode* back3;

@property (nonatomic,retain)CircleNode* node1;
@property (nonatomic,retain)CircleNode* node2;
@property (nonatomic,retain)CircleNode* node3;
@property (nonatomic,retain)CircleNode* node4;

@end

@implementation DiyLicensePlateNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        
        self.back1.hidden = NO;
        self.back2.hidden = NO;
        self.back3.hidden = NO;
        self.node1.hidden = NO;
        self.node2.hidden = NO;
        self.node3.hidden = NO;
        self.node4.hidden = NO;
    }
    return self;
}

-(void)setCompleColor:(UIColor *)compleColor{
    _compleColor = compleColor;
    [self setNeedsLayout];
}

-(UIColor *)compleColor{
    if (!_compleColor) {
        _compleColor = [UIColor whiteColor];
    }
    return _compleColor;
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsLayout];
}

-(UIColor *)fillColor{
    if (!_fillColor) {
        _fillColor = [UIColor blackColor];
    }
    return _fillColor;
}

-(RoundRectNode *)back1{
    if (!_back1) {
        _back1 = [[RoundRectNode alloc]init];
        _back1.layerBacked = YES;
        [self addSubnode:_back1];
    }
    return _back1;
}
-(RoundRectNode *)back2{
    if (!_back2) {
        _back2 = [[RoundRectNode alloc]init];
        _back2.layerBacked = YES;
        [self addSubnode:_back2];
    }
    return _back2;
}
-(RoundRectNode *)back3{
    if (!_back3) {
        _back3 = [[RoundRectNode alloc]init];
        _back3.layerBacked = YES;
        [self addSubnode:_back3];
    }
    return _back3;
}
-(CircleNode *)node1{
    if (!_node1) {
        _node1 = [[CircleNode alloc]init];
        _node1.layerBacked = YES;
        [self addSubnode:_node1];
    }
    return _node1;
}
-(CircleNode *)node2{
    if (!_node2) {
        _node2 = [[CircleNode alloc]init];
        _node2.layerBacked = YES;
        [self addSubnode:_node2];
    }
    return _node2;
}
-(CircleNode *)node3{
    if (!_node3) {
        _node3 = [[CircleNode alloc]init];
        _node3.layerBacked = YES;
        [self addSubnode:_node3];
    }
    return _node3;
}
-(CircleNode *)node4{
    if (!_node4) {
        _node4 = [[CircleNode alloc]init];
        _node4.layerBacked = YES;
        [self addSubnode:_node4];
    }
    return _node4;
}

-(void)layout{
    [super layout];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat lineGap = 1;
    
    self.back1.frame = self.bounds;
    self.back1.fillColor = self.fillColor;
    
    self.back2.frame = CGRectMake(lineGap, lineGap, width - lineGap * 2, height - lineGap * 2);
    self.back2.fillColor = self.compleColor;
    
    self.back3.frame = CGRectMake(lineGap * 2, lineGap * 2, width - lineGap * 4, height - lineGap * 4);
    self.back3.fillColor = self.fillColor;
    
    CGFloat nodeWidth = lineGap * 3;
    
    self.node1.frame = CGRectMake(lineGap * 8 - nodeWidth / 2., lineGap * 8 - nodeWidth / 2., nodeWidth, nodeWidth);
    self.node1.backgroundColor = [UIColor clearColor];
    self.node1.fillColor = self.compleColor;
    
    self.node2.frame = CGRectMake(width - lineGap * 8 - nodeWidth / 2., lineGap * 8 - nodeWidth / 2., nodeWidth, nodeWidth);
    self.node2.fillColor = self.compleColor;
    
    self.node3.frame = CGRectMake(lineGap * 8 - nodeWidth / 2., height - lineGap * 8 - nodeWidth / 2., nodeWidth, nodeWidth);
    self.node3.fillColor = self.compleColor;
    
    self.node4.frame = CGRectMake(width - lineGap * 8 - nodeWidth / 2., height - lineGap * 8 - nodeWidth / 2., nodeWidth, nodeWidth);
    self.node4.fillColor = self.compleColor;
    
}

@end
