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

@property (nonatomic,retain)RoundRectNode* node1;
@property (nonatomic,retain)RoundRectNode* node2;
@property (nonatomic,retain)RoundRectNode* node3;
@property (nonatomic,retain)RoundRectNode* node4;

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
-(RoundRectNode *)node1{
    if (!_node1) {
        _node1 = [[RoundRectNode alloc]init];
        _node1.layerBacked = YES;
        [self addSubnode:_node1];
    }
    return _node1;
}
-(RoundRectNode *)node2{
    if (!_node2) {
        _node2 = [[RoundRectNode alloc]init];
        _node2.layerBacked = YES;
        [self addSubnode:_node2];
    }
    return _node2;
}
-(RoundRectNode *)node3{
    if (!_node3) {
        _node3 = [[RoundRectNode alloc]init];
        _node3.layerBacked = YES;
        [self addSubnode:_node3];
    }
    return _node3;
}
-(RoundRectNode *)node4{
    if (!_node4) {
        _node4 = [[RoundRectNode alloc]init];
        _node4.layerBacked = YES;
        [self addSubnode:_node4];
    }
    return _node4;
}

-(void)layout{
    [super layout];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
//    CGFloat lineGap = 1;
    
    self.back1.cornerRadius = 5;//self.back2.cornerRadius = self.back3.cornerRadius =
//    self.back1.topRightRadius = 5;
//    self.back1.bottomLeftRadius = 5;
    self.back1.frame = self.bounds;
    self.back1.fillColor = self.fillColor;
    self.back1.strokeColor = self.compleColor;
    self.back1.strokeWidth = 1;
    
//    self.back2.frame = CGRectMake(lineGap, lineGap, width - lineGap * 2, height - lineGap * 2);
//    self.back2.fillColor = self.compleColor;
//    
//    self.back3.frame = CGRectMake(lineGap * 2, lineGap * 2, width - lineGap * 4, height - lineGap * 4);
//    self.back3.fillColor = self.fillColor;
    
    
    CGFloat topMargin = 4;
    CGFloat leftMargin = 18;
    
    CGFloat nodeWidth = 6;
    CGFloat nodeHeight = 2;
    
    UIColor* nodeColor = [UIColor whiteColor];
    
    self.node1.frame = CGRectMake(leftMargin, topMargin, nodeWidth, nodeHeight);
    self.node1.fillColor = nodeColor;
    
    self.node2.frame = CGRectMake(width - leftMargin - nodeWidth, topMargin, nodeWidth, nodeHeight);
    self.node2.fillColor = nodeColor;
    
    self.node3.frame = CGRectMake(leftMargin, height - topMargin - nodeHeight, nodeWidth, nodeHeight);
    self.node3.fillColor = nodeColor;
    
    self.node4.frame = CGRectMake(width - leftMargin - nodeWidth, height - topMargin - nodeHeight, nodeWidth, nodeHeight);
    self.node4.fillColor = nodeColor;
    self.node1.cornerRadius = self.node2.cornerRadius = self.node3.cornerRadius = self.node4.cornerRadius = nodeHeight / 2.;
    
    
}

@end
