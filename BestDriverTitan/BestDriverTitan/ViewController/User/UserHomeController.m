//
//  UserHomeController.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UserHomeController.h"
#import "UserDefaultsUtils.h"
#import "OwnerViewController.h"
#import "GYTabBarController.h"

@interface UserHomeController ()

@property(nonatomic,retain)UIView* titleView;

@property(nonatomic,retain)UIScrollView* scrollView;

@property(nonatomic,retain)UIView* userBack;
@property(nonatomic,retain)UILabel* userLabel;
@property(nonatomic,retain)UILabel* userPhone;
@property(nonatomic,retain)UIView* userStarBack;

@property(nonatomic,retain)UIButton* logoutButton;

@end

@implementation UserHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self showUserInfo:[Config getUser]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self measure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_USER superView:_titleView];
    }
    return _titleView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIView *)userBack{
    if (!_userBack) {
        _userBack = [[UIView alloc]init];
        _userBack.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_userBack];
    }
    return _userBack;
}

-(UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = [UICreationUtils createLabel:ICON_FONT_NAME size:16 color:COLOR_PRIMARY];
        [self.userBack addSubview:_userLabel];
    }
    return _userLabel;
}

-(UILabel *)userPhone{
    if (!_userPhone) {
        _userPhone = [UICreationUtils createLabel:ICON_FONT_NAME size:14 color:COLOR_PRIMARY];
        [self.userBack addSubview:_userPhone];
    }
    return _userPhone;
}

-(UIView *)userStarBack{
    if (!_userStarBack) {
        _userStarBack = [[UIView alloc]init];
        [self.userBack addSubview:_userStarBack];
    }
    return _userStarBack;
}

-(UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.backgroundColor = COLOR_DAI_WAN_CHENG;
        [_logoutButton setTitle:@"退   出" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _logoutButton.underlineNone = YES;
        [self.view addSubview:_logoutButton];
        
        _logoutButton.layer.cornerRadius = 5;
        _logoutButton.layer.masksToBounds = YES;
        
        [_logoutButton setShowTouch:YES];
        [_logoutButton addTarget:self action:@selector(clickLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

-(void)clickLogoutButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否现在退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    __weak __typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击确认");
        [UserDefaultsUtils removeObject:USER_KEY];//清除数据
        [[OwnerViewController sharedInstance]popLoginview:YES completion:^{
            [(GYTabBarController*)weakSelf.tabBarController valueCommit:0];//自动回到主页
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)initTitleArea{
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)measure{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    
    self.scrollView.frame = self.view.bounds;

    CGFloat gap = 5;
    
    CGFloat bottomY = gap;
    bottomY = [self initUserItem:bottomY];
    bottomY += gap * 4;
    bottomY = [self initLogoutButton:bottomY];
    bottomY += gap * 2;
    
    self.scrollView.contentSize = CGSizeMake(viewWidth, bottomY);
}

-(CGFloat)initLogoutButton:(CGFloat)bottomY{
    CGFloat buttonHeight = 40;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat padding = 5;
    
    self.logoutButton.frame = CGRectMake(padding, bottomY, viewWidth - padding * 2, buttonHeight);
    
    return bottomY + buttonHeight;
}

-(CGFloat)initUserItem:(CGFloat)bottomY{//用户数据条目
    CGFloat backHeight = 70;
    self.userBack.frame = CGRectMake(0, bottomY, CGRectGetWidth(self.view.bounds), backHeight);
    
    return bottomY + backHeight;
}

-(void)showUserInfo:(User*)user{
    if (user) {
        
        CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
        CGFloat backHeight = CGRectGetHeight(self.userBack.bounds);
        
        self.userLabel.text = ConcatStrings(ICON_WO_DE_SELECTED,user.name);
        [self.userLabel sizeToFit];
        
        self.userPhone.text = ConcatStrings(ICON_DIAN_HUA,user.telphone);
        [self.userPhone sizeToFit];
        
        user.stars = 3;
        
        UIColor* selectColor = FlatOrange;
        UIColor* normalColor = COLOR_LINE;
        
        CGFloat starHeight = 0;
        CGFloat starWidth = 0;
        
        [self.userStarBack removeAllSubViews];
        
        for (NSInteger i = 4; i >= 0; i--) {
            UILabel* starIcon = [[UILabel alloc]init];
            [self.userStarBack addSubview:starIcon];
            
            starIcon.font = [UIFont fontWithName:ICON_FONT_NAME size:14];
            starIcon.text = ICON_STAR;
            starIcon.textColor = user.stars > i ? selectColor : normalColor;
            
            [starIcon sizeToFit];
            
            CGSize starSize = starIcon.frame.size;
            
            starHeight = starSize.height;
            starWidth = starSize.width;
            
            starIcon.frame = (CGRect){CGPointMake(i * starSize.width, 0),starSize};
        }
        
        CGSize userSize = self.userLabel.bounds.size;
        CGSize phoneSize = self.userPhone.bounds.size;
        
        CGFloat gap = 5;
        
        CGFloat totalStarWidth = starWidth * 5;
        
        CGFloat baseY = (backHeight - (userSize.height + phoneSize.height + starHeight + gap * 2)) / 2.;
        
        self.userLabel.frame = (CGRect){CGPointMake((viewWidth - userSize.width) / 2., baseY),userSize};
        
        self.userPhone.frame = (CGRect){CGPointMake((viewWidth - phoneSize.width) / 2., baseY + userSize.height + gap),phoneSize};
        
        self.userStarBack.frame = CGRectMake((viewWidth - totalStarWidth) / 2., baseY + userSize.height + phoneSize.height + gap * 2, totalStarWidth, starHeight);
        
        
        
    }
}


@end
