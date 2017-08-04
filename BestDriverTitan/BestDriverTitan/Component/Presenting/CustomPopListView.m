//
//  CustomComboboxView.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopListView.h"
#import "FlatButton.h"

@interface CustomPopListView()

@property(nonatomic,retain)UIScrollView* scrollView;

@end

@implementation CustomPopListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.dataField = @"label";
        self.popFromDirection = CustomPopDirectionBottom;
        self.popToDirection = CustomPopDirectionBottom;
    }
    return self;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

-(void)viewDidLoad{
    self.scrollView.frame = self.contentView.bounds;
    
    CGFloat buttonWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat buttonHeight = 50;
    
    NSInteger count = self.dataArray.count;
    
    for (NSInteger i = 0 ; i < count; i ++) {
        NSObject* data = self.dataArray[i];
        NSString* title;
        if ([data isKindOfClass:[NSString class]]) {
            title = (NSString*)data;
        }else{
            title = [data valueForKey:self.dataField];
        }
        
        FlatButton* button = [[FlatButton alloc]init];
        
        button.title = title;
        button.titleColor = FlatBlack;
        button.fillColor = [UIColor clearColor];
        
        button.frame = CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight);
        button.tag = i;
        [self.scrollView addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.scrollView.contentSize = CGSizeMake(buttonWidth, buttonHeight * count);
}

-(void)buttonClick:(UIView*)button{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onSelectedIndex:index:)]){
            [self.delegate onSelectedIndex:self index:button.tag];
        }
        if ([self.delegate respondsToSelector:@selector(onSelectedItem:item:)]) {
            [self.delegate  onSelectedItem:self item:self.dataArray[button.tag]];
        }
    }
//    button.tag;
    [self dismiss];
}

@end
