//
//  ViewController.m
//  BestDriverTitan
//
//  Created by admin on 16/11/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "UIArrowView.h"
#import "AppDelegate.h"
#import "MMDrawerController.h"

@interface ViewController ()

@property(nonatomic,retain)UIView* titleView;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
    [self.view addSubview:btn];
    [btn setTitle:@"试试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor brownColor];
    [btn addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    UIArrowView* arrowView = [[UIArrowView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    arrowView.direction = ArrowDirectRight;
    [self.view addSubview:arrowView];
    
    UIView* subView = [[UIView alloc]init];
    [self.view addSubview:subView];
    subView.backgroundColor = [UIColor orangeColor];
    
    subView.frame = self.view.frame;//CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 50);
    
}

-(void)buttonSelect:(UIView* )btn{
    ViewController* tempController = [[ViewController alloc]init];
//    tempController.title = @"新页面";
    [self.navigationController pushViewController:tempController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_HOME superView:_titleView];
    }
    return _titleView;
}

-(void)initTitleArea{
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
//    [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
//    [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)rightItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:nil];
}





@end
