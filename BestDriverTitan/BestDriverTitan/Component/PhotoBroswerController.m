//
//  PhotoBroswerController.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PhotoBroswerController.h"
#import "STPhotoBroswer.h"
#import "HudManager.h"

@interface PhotoBroswerController()<UIAlertViewDelegate>

@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)STPhotoBroswer* broswer;

@end

@implementation PhotoBroswerController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = @"图片查看";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    
    self.navigationItem.rightBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHAN_CHU target:self action:@selector(rightClick)];
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightClick{
    UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定需要删除该图片吗？" delegate:self cancelButtonTitle:@"容朕想想" otherButtonTitles:@"准奏", nil];
    [alart show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {//确定删除
        if(self.delegate && [self.delegate respondsToSelector:@selector(photoBroswerDelete:index:)]){
            [self.delegate photoBroswerDelete:self index:self.broswer.index];
        }
        [self leftClick];
    }
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(STPhotoBroswer *)broswer{
    if (!_broswer) {
        _broswer = [[STPhotoBroswer alloc]init];
        [self.view addSubview:_broswer];
    }
    return _broswer;
}

-(void)viewDidLayoutSubviews{
    self.broswer.frame = self.view.bounds;
}

-(void)viewDidLoad{
    [HudManager showToast:@"左右滑动可切换图片"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.broswer.imageArray = self.imageArray;
    self.broswer.index = self.selectedIndex;
}

@end
