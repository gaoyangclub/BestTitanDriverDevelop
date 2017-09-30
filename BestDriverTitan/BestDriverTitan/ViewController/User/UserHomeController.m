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
#import "NormalSelectItem.h"
#import "UpdateVersionManager.h"
#import "VersionInfoController.h"

typedef NS_ENUM(NSInteger,ItemPostion){
    ItemPostionNormal = 1,
    ItemPostionTop,
    ItemPostionBottom,
    ItemPostionSingle,
};

@interface UserHomeController ()

@property(nonatomic,retain)UIView* titleView;

@property(nonatomic,retain)UIScrollView* scrollView;

@property(nonatomic,retain)NormalSelectItem* userBack;
@property(nonatomic,retain)UILabel* userLabel;
@property(nonatomic,retain)UILabel* userPhone;
@property(nonatomic,retain)UIView* userStarBack;
//@property(nonatomic,retain)UIButton* userIcon;

@property(nonatomic,retain)UIButton* logoutButton;

@property(nonatomic,retain)NormalSelectItem* versionItem;

@end

@implementation UserHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = FlatWhite;
    [self showUserInfo:[Config getUser]];
    NSString* version = ConcatStrings(@"版本 ",[Config getVersionDescription]);
    self.versionItem.labelName = version;
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
        
        [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_USER superView:_titleView];
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

-(NormalSelectItem *)userBack{
    if (!_userBack) {
        _userBack = [[NormalSelectItem alloc]init];
        _userBack.backgroundColor = [UIColor whiteColor];
        _userBack.strokeColor = COLOR_LINE;
//        _userBack.arrowSize = CGSizeMake(10, 22);
        _userBack.iconName = ICON_WO_DE_SELECTED;
        _userBack.iconSize = 36;
        _userBack.iconBackColor = COLOR_PRIMARY;
        
        _userBack.showLabel = NO;
        
        [_userBack setShowTouch:YES];
        [self.scrollView addSubview:_userBack];
    }
    return _userBack;
}

-(UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = [UICreationUtils createLabel:ICON_FONT_NAME size:16 color:COLOR_BLACK_ORIGINAL];
        [self.userBack addSubview:_userLabel];
    }
    return _userLabel;
}

-(UILabel *)userPhone{
    if (!_userPhone) {
        _userPhone = [UICreationUtils createLabel:ICON_FONT_NAME size:16 color:FlatGray];
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

//-(UIButton *)userIcon{
//    if (!_userIcon) {
//        _userIcon = [UIButton buttonWithType:UIButtonTypeCustom];
////        _userIcon.backgroundColor = COLOR_PRIMARY;
//        
//        [_userIcon setTitle:ICON_WO_DE_SELECTED forState:UIControlStateNormal];
//        [_userIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _userIcon.titleLabel.font = [UIFont fontWithName:ICON_FONT_NAME size:36];
//        
//        _userIcon.underlineNone = YES;
//        
//        _userIcon.layer.cornerRadius = 5;
//        _userIcon.layer.masksToBounds = YES;
//        
//        _userIcon.layer.borderColor = COLOR_LINE.CGColor;
//        _userIcon.layer.borderWidth = 1;
//        
//        [self.userBack addSubview:_userIcon];
//    }
//    return _userIcon;
//}

-(UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.backgroundColor = COLOR_DAI_WAN_CHENG;
        [_logoutButton setTitle:@"退   出" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _logoutButton.underlineNone = YES;
        [self.scrollView addSubview:_logoutButton];
        
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
        [[OwnerViewController sharedInstance]logout:^{
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

#pragma 坑爹!!! 必须时时跟随主view的frame
-(void)viewDidLayoutSubviews{
    self.scrollView.frame = self.view.bounds;
    [super viewDidLayoutSubviews];
}

-(void)measure{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
//    self.scrollView.frame = CGRectMake(0, 0, 100, 300);
//    self.scrollView.backgroundColor = [UIColor brownColor];

    CGFloat gap = 10;
    
    CGFloat bottomY = gap;
    bottomY = [self initUserItem:bottomY];
    bottomY += gap;
    //我的货量明细，我的收入，签到，分享，用户反馈，版本信息
    bottomY = [self initNormalItem:bottomY icon:ICON_JIN_QIAN labal:@"收支" iconBackColor:FlatYellow handler:nil itemPostion:ItemPostionTop];
    bottomY = [self initNormalItem:bottomY icon:ICON_HUO_LIANG labal:@"货量" iconBackColor:FlatOrange handler:nil];
//    bottomY = [self initNormalItem:bottomY icon:ICON_LI_CHENG labal:@"里程" iconBackColor:FlatYellowDark handler:nil];
    bottomY = [self initNormalItem:bottomY icon:ICON_QIAN_DAO labal:@"签到" iconBackColor:FlatMintDark handler:nil itemPostion:ItemPostionBottom];
    
    bottomY += gap;
    
    bottomY = [self initNormalItem:bottomY icon:ICON_FEN_XIANG labal:@"分享" iconBackColor:FlatYellowDark handler:nil itemPostion:ItemPostionTop];
    bottomY = [self initNormalItem:bottomY icon:ICON_FAN_KUI labal:@"反馈" iconBackColor:FlatGreenDark handler:nil
               itemPostion:ItemPostionBottom];
    
    bottomY += gap;
    bottomY = [self initNormalItem:bottomY icon:ICON_BAN_BEN labal:ConcatStrings(@"版本 ",[Config getVersionDescription]) iconBackColor:COLOR_PRIMARY handler:@selector(checkVersionHandler) itemPostion:ItemPostionSingle];
    self.versionItem = self.scrollView.subviews.lastObject;
    
    bottomY += gap;
    bottomY = [self initLogoutButton:bottomY];
    bottomY += gap;
    
    self.scrollView.contentSize = CGSizeMake(viewWidth, bottomY);
}

-(void)checkVersionHandler{
    [[OwnerViewController sharedInstance] pushViewController:[[VersionInfoController alloc]init]
                                                    animated:YES];
}

-(CGFloat)initLogoutButton:(CGFloat)bottomY{
    CGFloat buttonHeight = 40;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat padding = 5;
    
    self.logoutButton.frame = CGRectMake(padding, bottomY, viewWidth - padding * 2, buttonHeight);
    
    return bottomY + buttonHeight;
}

-(CGFloat)initUserItem:(CGFloat)bottomY{//用户数据条目
    CGFloat backHeight = 80;
    self.userBack.frame = CGRectMake(0, bottomY, CGRectGetWidth(self.view.bounds), backHeight);
    
    return bottomY + backHeight;
}

-(void)showUserInfo:(User*)user{
    if (user) {
//        CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
        CGFloat backHeight = CGRectGetHeight(self.userBack.bounds);
        
        self.userLabel.text = user.name;
        [self.userLabel sizeToFit];
        
        self.userPhone.text = user.telphone;
        [self.userPhone sizeToFit];
        
        user.stars = 3;
        
        UIColor* selectColor = FlatOrange;
        UIColor* normalColor = COLOR_LINE;
        
        CGFloat starHeight = 0;
        CGFloat starWidth = 0;
        
        [self.userStarBack removeAllSubViews];
        
        CGFloat starCount = 5;
        
        for (NSInteger i = starCount - 1; i >= 0; i--) {
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
        
        CGFloat totalStarWidth = starWidth * starCount;
        
        CGFloat baseY = (backHeight - (userSize.height + phoneSize.height + starHeight + gap * 2)) / 2.;
        
        CGFloat iconMargin = self.userBack.iconMargin;
        CGFloat iconHeight = backHeight - iconMargin * 2;
        
//        self.userIcon.backgroundColor = COLOR_PRIMARY;
//        self.userIcon.frame = CGRectMake(iconMargin, iconMargin, iconHeight, iconHeight);
        
        CGFloat leftLabelMargin = iconMargin * 2 + iconHeight;
        
        self.userLabel.frame = (CGRect){CGPointMake(leftLabelMargin, baseY),userSize};
        
        self.userPhone.frame = (CGRect){CGPointMake(leftLabelMargin, baseY + userSize.height + gap),phoneSize};
        
        self.userStarBack.frame = CGRectMake(leftLabelMargin, baseY + userSize.height + phoneSize.height + gap * 2, totalStarWidth, starHeight);
    }
}



-(CGFloat)initNormalItem:(CGFloat)bottomY icon:(NSString*)icon labal:(NSString*)label iconBackColor:(UIColor*)iconBackColor handler:(SEL)handler itemPostion:(ItemPostion)itemPostion{//用户数据条目
    CGFloat normalHeight = 45;
    
    NormalSelectItem* normalItem = [[NormalSelectItem alloc]init];
    normalItem.backgroundColor = [UIColor whiteColor];
    normalItem.strokeColor = COLOR_LINE;
    //        _userBack.arrowSize = CGSizeMake(10, 22);
    normalItem.iconName = icon;
    normalItem.iconSize = 20;
    normalItem.iconColor = handler ? iconBackColor : FlatGray;
    normalItem.iconBackColor = [UIColor clearColor];
    normalItem.showIconLine = NO;
    
    normalItem.labelName = label;
    normalItem.labelSize = 14;
    normalItem.labelColor = handler ? COLOR_BLACK_ORIGINAL : COLOR_LINE;
//    normalItem.lineLeftMargin = 50;
    if (itemPostion == ItemPostionTop) {
        normalItem.showTopLine = YES;
        normalItem.lineBottomLeftMargin = normalHeight;
    }else if (itemPostion == ItemPostionBottom) {
        normalItem.showTopLine = NO;
        normalItem.lineBottomLeftMargin = 0;
    }else if (itemPostion == ItemPostionNormal) {
        normalItem.showTopLine = NO;
        normalItem.lineBottomLeftMargin = normalHeight;
    }else if (itemPostion == ItemPostionSingle) {
        normalItem.showTopLine = YES;
        normalItem.lineBottomLeftMargin = 0;
    }
    
    [normalItem setShowTouch:YES];
    [self.scrollView addSubview:normalItem];
    
    normalItem.frame = CGRectMake(0, bottomY, CGRectGetWidth(self.view.bounds), normalHeight);
    
    [normalItem addTarget:self action:handler forControlEvents:UIControlEventTouchUpInside];
    
    return bottomY + normalHeight;
}

-(CGFloat)initNormalItem:(CGFloat)bottomY icon:(NSString*)icon labal:(NSString*)label iconBackColor:(UIColor*)iconBackColor handler:(SEL)handler{//用户数据条目
    return [self initNormalItem:bottomY icon:icon labal:label iconBackColor:iconBackColor handler:handler itemPostion:ItemPostionNormal];
}

@end
