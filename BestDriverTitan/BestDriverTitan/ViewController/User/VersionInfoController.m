//
//  VersionInfoController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 admin. All rights reserved.
//

@interface VersionDetailInfo : NSObject

@property(nonatomic,assign)NSInteger appType;
@property(nonatomic,assign)NSInteger appIsLastest;
@property(nonatomic,copy)NSString* appVersion;
@property(nonatomic,assign)NSInteger appBuildVersion;
@property(nonatomic,assign)NSInteger appVersionNo;
@property(nonatomic,copy)NSString* appIdentifier;
@property(nonatomic,copy)NSString* appDescription;
@property(nonatomic,copy)NSString* appUpdateDescription;
@property(nonatomic,copy)NSString* appQRCodeURL;

@end

@implementation VersionDetailInfo

@end

@interface VersionGroupInfo : NSObject

@property(nonatomic,copy)NSString* code;
@property(nonatomic,copy)NSString* message;
@property(nonatomic,retain)NSMutableArray<VersionDetailInfo*>* data;

@end

@implementation VersionGroupInfo

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"data":[VersionDetailInfo class]};
}

@end

#import "VersionInfoController.h"
#import "UpdateVersionManager.h"
#import "FlatButton.h"
#import "UIImageView+WebCache.h"
#import "HudManager.h"
#import "LocalBundleManager.h"

@interface VersionInfoController ()

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIImageView* logoImg;
//@property(nonatomic,retain)UILabel* logoLabel;
//@property(nonatomic,retain)UILabel* logoDes;
@property(nonatomic,retain)UILabel* versionLabel;

@property(nonatomic,retain)UIView* infoBack;

@property(nonatomic,retain)UILabel* infoLabel;
@property(nonatomic,retain)UILabel* infoText;

@property(nonatomic,retain)UIScrollView* scrollView;

@property(nonatomic,retain)FlatButton* submitButton;

@property(nonatomic,retain)UIImageView* qrcodeImage;
@property(nonatomic,retain)UILabel* qrcodeLabel;


@end

static VersionDetailInfo* currentVersionInfo;//当前版本相关信息

static const CGFloat MARGIN_GAP = 15;
static const CGFloat MARGIN_TOP = 20;
static const CGFloat MARGIN_LEFT = 20;
static const CGFloat IMAGE_HEIGHT = 120;

@implementation VersionInfoController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIView *)infoBack{
    if (!_infoBack) {
        _infoBack = [[UIView alloc]init];
        _infoBack.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:_infoBack];
    }
    return _infoBack;
}

-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [UICreationUtils createLabel:18 color:COLOR_BLACK_ORIGINAL text:@"当前版本说明" sizeToFit:YES superView:self.infoBack];
        [self.infoBack addSubview:_infoLabel];
    }
    return _infoLabel;
}

-(UILabel *)infoText{
    if (!_infoText) {
        _infoText = [UICreationUtils createLabel:14 color:COLOR_BLACK_ORIGINAL];
        _infoText.numberOfLines = 0;
        [self.infoBack addSubview:_infoText];
    }
    return _infoText;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_VERSION superView:nil];
    }
    return _titleLabel;
}

-(UIImageView *)logoImg{
    if (!_logoImg) {
        UIImage* image = [UIImage imageNamed:@"splashLogo"];
        _logoImg = [[UIImageView alloc]initWithImage:image];
        _logoImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:_logoImg];
    }
    return _logoImg;
}

//-(UILabel *)logoLabel{
//    if (!_logoLabel) {
//        _logoLabel = [UICreationUtils createLabel:24 color:COLOR_BLACK_ORIGINAL text:APPLICATION_NAME sizeToFit:YES superView:self.scrollView];
//    }
//    return _logoLabel;
//}

//-(UILabel *)logoDes{
//    if (!_logoDes) {
//        _logoDes = [UICreationUtils createLabel:16 color:COLOR_BLACK_ORIGINAL text:APPLICATION_NAME_EN sizeToFit:YES superView:self.scrollView];
//    }
//    return _logoDes;
//}

-(UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [UICreationUtils createLabel:14 color:COLOR_BLACK_ORIGINAL];
        [self.infoBack addSubview:_versionLabel];
    }
    return _versionLabel;
}

-(UIImageView *)qrcodeImage{
    if (!_qrcodeImage) {
        _qrcodeImage = [[UIImageView alloc]init];
        _qrcodeImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:_qrcodeImage];
    }
    return _qrcodeImage;
}

-(UILabel *)qrcodeLabel{
    if (!_qrcodeLabel) {
        _qrcodeLabel = [UICreationUtils createLabel:14 color:COLOR_BLACK_ORIGINAL text:@"扫描二维码安装" sizeToFit:YES superView:self.scrollView];
    }
    return _qrcodeLabel;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
//        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = 18;
        _submitButton.title = @"版本检查";
        [self.view addSubview:_submitButton];
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)clickSubmitButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    [[UpdateVersionManager sharedInstance]checkVersionUpdate:^(NSDictionary * updateInfo) {
        if (!updateInfo) {//已经是最新版本
            [HudManager showToast:@"当前已经是最新版本!"];
        }
    }];
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    
    self.navigationItem.titleView = self.titleLabel;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLayoutSubviews{
    CGFloat margin = 4;
    CGFloat buttonAreaHeight = 55;
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    self.submitButton.frame = CGRectMake(margin, viewHeight - buttonAreaHeight + margin, viewWidth - margin * 2, buttonAreaHeight - margin * 2);
    
    self.scrollView.frame = CGRectMake(0, 0, viewWidth, viewHeight - buttonAreaHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UpdateVersionManager sharedInstance]checkVersionUpdate:nil];
    
    [self initLogoArea];
    
    if (!currentVersionInfo) {
        [[UpdateVersionManager sharedInstance]getLastVersionInfo:^(id returnValue) {
            VersionGroupInfo* groupInfo = [VersionGroupInfo yy_modelWithJSON:returnValue];//[VersionGroupInfo yy_modelWithJSON:returnValue];
            //        DDLog(@"%@",groupInfo);
            //        VersionDetailInfo* info = groupInfo.data[0];
            currentVersionInfo = [self getCurrentVersionInfoByGroup:groupInfo];
            [self showVersionInfo:currentVersionInfo];
        }];
    }else{
        [self showVersionInfo:currentVersionInfo];
    }
}

-(void)showVersionInfo:(VersionDetailInfo*)info{
    if(!info){
        return;
    }
    CGFloat viewWidth = self.view.bounds.size.width;
    
    self.qrcodeImage.frame = CGRectMake(0,CGRectGetMaxY(self.logoImg.frame) + MARGIN_GAP,viewWidth,IMAGE_HEIGHT);
    [self.qrcodeImage sd_setImageWithURL:[NSURL URLWithString:info.appQRCodeURL]];
    
    CGSize qrcodeSize = self.qrcodeLabel.frame.size;
    
    self.qrcodeLabel.frame = (CGRect){CGPointMake((viewWidth - qrcodeSize.width) / 2., CGRectGetMaxY(self.qrcodeImage.frame) + 5),qrcodeSize};
    
    CGSize labelSize = self.infoLabel.frame.size;
    
    self.infoLabel.frame = (CGRect){CGPointMake(MARGIN_LEFT, CGRectGetMaxY(self.versionLabel.frame) + MARGIN_GAP),labelSize};
    
    self.infoText.text = info.appUpdateDescription;
    
    CGSize textSize = [self.infoText sizeThatFits:CGSizeMake(viewWidth, FLT_MAX)];
    
    self.infoText.frame = (CGRect){CGPointMake(MARGIN_LEFT, CGRectGetMaxY(self.infoLabel.frame) + MARGIN_GAP),textSize};
    
    self.infoBack.frame = CGRectMake(0, CGRectGetMaxY(self.qrcodeLabel.frame) + MARGIN_GAP, viewWidth, CGRectGetMaxY(self.infoText.frame) + MARGIN_TOP);
    
    self.scrollView.contentSize = CGSizeMake(viewWidth, CGRectGetMaxY(self.infoBack.frame));
}

-(VersionDetailInfo*)getCurrentVersionInfoByGroup:(VersionGroupInfo*) groupInfo{
    for (VersionDetailInfo* info in groupInfo.data) {
        if ([info.appVersion isEqualToString:[LocalBundleManager getAppVersion]] &&
            info.appVersionNo == [LocalBundleManager getAppCode]) {
            return info;
        }
    }
    return nil;
}

-(void)initLogoArea{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    
    self.logoImg.frame = CGRectMake(0, MARGIN_GAP, viewWidth, IMAGE_HEIGHT);
    
//    CGFloat logoLabelHeight = CGRectGetHeight(self.logoLabel.bounds);
//    CGFloat logoLabelWidth = CGRectGetWidth(self.logoLabel.bounds);
//    
//    CGFloat logoLabelY = CGRectGetMaxY(self.logoImg.frame) + 10;
//    
//    self.logoLabel.frame = CGRectMake((viewWidth - logoLabelWidth) / 2., logoLabelY, logoLabelWidth, logoLabelHeight);
    
//    CGFloat logoDesHeight = CGRectGetHeight(self.logoDes.bounds);
//    CGFloat logoDesWidth = CGRectGetWidth(self.logoDes.bounds);
//    
//    self.logoDes.frame = CGRectMake((viewWidth - logoDesWidth) / 2., logoLabelY + logoLabelHeight, logoDesWidth, logoDesHeight);
    
    [self showVersionLabel];
}

-(void)showVersionLabel{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    self.versionLabel.text = ConcatStrings(APPLICATION_NAME,@" ",[Config getVersionDescription]);
    [self.versionLabel sizeToFit];
    
    CGSize versionSize = self.versionLabel.frame.size;
    
    self.versionLabel.frame = (CGRect){CGPointMake(MARGIN_LEFT,MARGIN_GAP),versionSize};
    
    self.infoBack.frame = CGRectMake(0, CGRectGetMaxY(self.logoImg.frame) + MARGIN_GAP, viewWidth, CGRectGetMaxY(self.versionLabel.frame) + MARGIN_GAP);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
