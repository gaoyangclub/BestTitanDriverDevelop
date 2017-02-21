//
//  TaskViewSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewSection.h"

@interface TaskViewSection(){
    
}

@property(nonatomic,retain)ASDisplayNode* square;
@property(nonatomic,retain)ASTextNode* title;

@end

@implementation TaskViewSection

-(ASDisplayNode *)square{
    if (!_square) {
        _square = [[ASDisplayNode alloc]init];
        _square.backgroundColor = COLOR_PRIMARY;
        [self.layer addSublayer:_square.layer];
    }
    return _square;
}

-(ASTextNode *)title{
    if (!_title) {
        _title = [[ASTextNode alloc]init];
        [self.layer addSublayer:_title.layer];
    }
    return _title;
}

-(void)layoutSubviews{
    self.backgroundColor = COLOR_BACKGROUND;
    
//    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    CGFloat squareHeight = 18;
    
    self.square.frame = CGRectMake(0, (sectionHeight - squareHeight) / 2., 5, squareHeight);
    
    self.title.attributedString = SimpleHtmlText(FlatGrayDark, @"4", ConcatStrings(@"2017-02-15",self.itemIndex));
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(self.square.frame.origin.x + self.square.frame.size.width + 5, (sectionHeight - titleSize.height) / 2.),titleSize};
}

@end
