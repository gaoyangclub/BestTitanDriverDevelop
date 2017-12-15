//
//  ScanHomeController.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanHomeController.h"
#import "MathUtils.h"
#import "ScanViewController.h"

static NSArray<NSString*> *activityCodes;

@interface ScanTypeButton : UIControl

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* icon;
@property(nonatomic,retain) UIColor* iconColor;

@property(nonatomic,retain) ASTextNode* titleNode;
@property(nonatomic,retain) ASTextNode* iconNode;

@end

@implementation ScanTypeButton

+(void)load{
    activityCodes = @[ACTIVITY_CODE_PICKUP_HANDOVER,ACTIVITY_CODE_SIGN_FOR_RECEIPT];
}

-(void)setIcon:(NSString *)icon{
    _icon = icon;
    [self setNeedsLayout];
}

-(void)setIconColor:(UIColor *)iconColor{
    _iconColor = iconColor;
    [self setNeedsLayout];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)iconNode{
    if (!_iconNode) {
        _iconNode = [[ASTextNode alloc]init];
        _iconNode.layerBacked = YES;
        [self.layer addSublayer:_iconNode.layer];
    }
    return _iconNode;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    [self setShowTouch:YES];
    
    self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.iconColor size:rpx(60) content:self.icon];
    self.iconNode.size = [self.iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:self.title];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleNode.centerY = self.iconNode.centerY = self.height / 2.;
    
    CGFloat const iconGap = rpx(20);
    CGFloat const baseX = (self.width - (self.iconNode.width + iconGap + self.titleNode.width)) / 2.;
    
    self.iconNode.x = baseX;
    self.titleNode.x = self.iconNode.maxX + iconGap;
}


@end

@interface ScanHomeController ()

@property(nonatomic,retain) UIImageView* backImageView;//背景图
@property(nonatomic,retain) UILabel* titleLabel;//大标题栏

@end

@implementation ScanHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_SCAN superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    
//    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_DI_TU target:self action:@selector(rightClick)];
    
    self.titleLabel.text = NAVIGATION_TITLE_SCAN;
    [self.titleLabel sizeToFit];
    //    self.titleView.bounds = titleLabel.bounds;
    self.navigationItem.titleView = self.titleLabel;//self.titleView;
    
    //    titleLabel.center = self.titleView.center;
    
}

-(UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanbackgroud.jpg"]];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.layer.masksToBounds = YES;
        [self.view addSubview:_backImageView];
    }
    return _backImageView;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.frame = CGRectMake(0, 0, self.view.width, self.view.width * MATH_GOLDEN_SECTION);
    
    [self initButtonAreas];
}

-(void)initButtonAreas{
    NSInteger const column = 2;//2列排列
    CGFloat const buttonGap = rpx(5);
    CGFloat const buttonLeftMargin = rpx(5);
    CGFloat const buttonTopMargin = rpx(15) + self.backImageView.height;
    CGFloat const buttonWidth = (self.view.width - buttonLeftMargin - buttonLeftMargin * 2) / column;
    CGFloat const buttonHeight = buttonWidth * MATH_GOLDEN_SECTION;//黄金分割
    
    NSInteger const count = activityCodes.count;
    
    for (NSInteger i = 0; i < count; i++) {
        NSString* activityCode = activityCodes[i];
        ScanTypeButton* button = [[ScanTypeButton alloc]init];
        button.title = ConcatStrings(@"扫描",[Config getActivityLabelByCode:activityCode]);
        button.iconColor = [Config getActivityColorByCode:activityCode];
        button.icon = ICON_SAO_MA;//icons[i];
        button.tag = i;
        [self.view addSubview:button];
        
        button.frame = CGRectMake(buttonLeftMargin + i % column * (buttonWidth + buttonGap), buttonTopMargin + (i / column) * (buttonHeight + buttonGap), buttonWidth, buttonHeight);
        
        [button addTarget:self action:@selector(clickScanButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickScanButton:(UIView*)sender{
    NSString* activityCode = activityCodes[sender.tag];
    //或下面方法
    
    ScanViewController *scan = [[ScanViewController alloc] init];
//    [[ScanViewController alloc] initWithSuccessBlock:^(NSString *qrCodeInfo) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        cell.detailTextLabel.text = QRCodeInfo;
//        NSLog(@"------------->  qrCodeInfo:%@",qrCodeInfo);
//    }];
    scan.activityCode = activityCode;
    scan.navigationTitle = ConcatStrings(@"扫描",[Config getActivityLabelByCode:activityCode]);
//    UITabBarController* tabBarCtl = [[UITabBarController alloc] init];
//    UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:scan];
//    [tabBarCtl setViewControllers:@[navi]];
////    navi.navigationBarHidden = YES;//隐藏顶部
//    navi.navigationBar.barTintColor = FlatBlack;
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
