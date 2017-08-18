//
//  AdminViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AdminViewController.h"
#import "FlatButton.h"
#import "OwnerViewController.h"
#import "VersionInfoController.h"
#import "HudManager.h"
#import "LoginViewModel.h"
#import "AuthCodeBean.h"
#import "UserDefaultsUtils.h"

@interface AdminViewController ()

//@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIView* inputArea;
@property(nonatomic,retain)UILabel* usernameIcon;
@property(nonatomic,retain)UITextField* usernameText;

@property(nonatomic,retain)UILabel* writableIcon;
@property(nonatomic,retain)UILabel* writableLabel;
@property(nonatomic,retain)UISwitch* writableSwitch;
//@property(nonatomic,retain)UITextField* authcodeText;
//@property(nonatomic,retain)UIButton* authcodeButton;
@property(nonatomic,retain)UIView* inputLineCenterY;

@property(nonatomic,retain)FlatButton* submitButton;

@property(nonatomic,retain)FlatButton* loginButton;//直接登录
@property(nonatomic,retain)FlatButton* returnButton;//返回登录页

@property(nonatomic,retain)UILabel* logoIcon;
@property(nonatomic,retain)UILabel* logoLabel;
@property(nonatomic,retain)UILabel* logoDes;
//@property(nonatomic,retain)UILabel* versionLabel;

//@property(nonatomic,retain)UILabel* operateLabeL;
//@property(nonatomic,retain)FlatButton* operateButton;

@property(nonatomic,retain)LoginViewModel* loginViewModel;

@end

@implementation AdminViewController

-(LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}

//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_ADMIN superView:nil];
//    }
//    return _titleLabel;
//}

-(UILabel *)logoIcon{
    if (!_logoIcon) {
        _logoIcon = [UICreationUtils createLabel:ICON_FONT_NAME size:SYSTEM_SCALE_FACTOR * 100 color:COLOR_USER_PROXY text:ICON_JIAN_KONG sizeToFit:YES superView:self.view];
    }
    return _logoIcon;
}

-(UILabel *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [UICreationUtils createLabel:24 color:COLOR_BLACK_ORIGINAL text:@"管理员大帝" sizeToFit:YES superView:self.view];
    }
    return _logoLabel;
}

-(UILabel *)logoDes{
    if (!_logoDes) {
        _logoDes = [UICreationUtils createLabel:16 color:COLOR_BLACK_ORIGINAL text:@"监控模式" sizeToFit:YES superView:self.view];
    }
    return _logoDes;
}
//
//-(UILabel *)versionLabel{
//    if (!_versionLabel) {
//        _versionLabel = [UICreationUtils createLabel:14 color:FlatGray];
//        [self.view addSubview:_versionLabel];
//    }
//    return _versionLabel;
//}

-(UIView *)inputArea{
    if (!_inputArea) {
        _inputArea = [[UIView alloc]init];
        _inputArea.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_inputArea];
    }
    return _inputArea;
}

-(UILabel *)usernameIcon{
    if (!_usernameIcon) {
        _usernameIcon = [UICreationUtils createLabel:ICON_FONT_NAME size:24 color:COLOR_USER_PROXY text:ICON_WO_DE sizeToFit:YES superView:self.inputArea];
    }
    return _usernameIcon;
}

-(UILabel *)writableIcon{
    if (!_writableIcon) {
        _writableIcon = [UICreationUtils createLabel:ICON_FONT_NAME size:24 color:COLOR_USER_PROXY text:ICON_XIE_RU sizeToFit:YES superView:self.inputArea];
    }
    return _writableIcon;
}

-(UILabel *)writableLabel{
    if (!_writableLabel) {
        _writableLabel = [UICreationUtils createLabel:14 color:FlatGray text:@"可提交数据" sizeToFit:YES superView:self.inputArea];
    }
    return _writableLabel;
}

-(UISwitch *)writableSwitch{
    if (!_writableSwitch) {
        _writableSwitch = [[UISwitch alloc] init];
//        [_writableSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        [self.inputArea addSubview: _writableSwitch];
    }
    return _writableSwitch;
}

-(UITextField *)usernameText{
    if (!_usernameText) {
        _usernameText = [[UITextField alloc]init];
        _usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _usernameText.font = [UIFont systemFontOfSize:16];
        _usernameText.textColor = COLOR_BLACK_ORIGINAL;
        //        _usernameText.delegate = self; //文本交互代理
        _usernameText.placeholder = @"请输入手机号";
        _usernameText.keyboardType = UIKeyboardTypePhonePad;
        _usernameText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        [self.inputArea addSubview:_usernameText];
    }
    return _usernameText;
}

-(UIView *)inputLineCenterY{
    if (!_inputLineCenterY) {
        _inputLineCenterY = [[UIView alloc]init];
        _inputLineCenterY.backgroundColor = COLOR_LINE;
        [self.inputArea addSubview:_inputLineCenterY];
    }
    return _inputLineCenterY;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.fillColor = COLOR_USER_PROXY;
        _submitButton.title = @"监控用户";
        _submitButton.titleSize = 20;
        [self.view addSubview:_submitButton];
 
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(FlatButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[FlatButton alloc]init];
        _loginButton.fillColor = COLOR_PRIMARY;
        _loginButton.title = @"直接登录";
        _loginButton.titleSize = 20;
//        _loginButton.cornerRadius = 0;
        [self.view addSubview:_loginButton];
        
        [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(FlatButton *)returnButton{
    if (!_returnButton) {
        _returnButton = [[FlatButton alloc]init];
        _returnButton.fillColor = [UIColor whiteColor];
        _returnButton.titleColor = _returnButton.strokeColor = COLOR_PRIMARY;
        _returnButton.strokeWidth = 1;
        _returnButton.title = @"退出监控";
        _returnButton.titleSize = 20;
//        _returnButton.cornerRadius = 0;
        [self.view addSubview:_returnButton];
        
        [_returnButton addTarget:self action:@selector(clickReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self initTitleArea];
//    self.view.backgroundColor = COLOR_BACKGROUND;
//}

//-(void)initTitleArea{
//    self.navigationItem.leftBarButtonItem =
//    [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
//    self.navigationItem.titleView = self.titleLabel;
//}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [self initLogoArea];
    [self initInputArea:100];
    
    [self initData];
}

-(void)initData{
    [self.usernameText setText:[UserDefaultsUtils getObject:PROXY_PHONE_KEY]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initLogoArea{
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat logoMarginTop = 50;
//    CGFloat logoMarginBottom = 95;
    
//    CGSize iconSize = self.logoIcon.frame.size;
    
    CGFloat logoMarginTop = (self.view.centerY - self.logoIcon.height - self.logoLabel.height - self.logoDes.height) / 2.;
    
    self.logoIcon.centerX = self.view.centerX;
    self.logoIcon.y = logoMarginTop;
//    self.logoIcon.frame = (CGRect){ CGPointMake((viewWidth - iconSize.width) / 2., logoMarginTop),iconSize};
    
    CGFloat logoLabelHeight = CGRectGetHeight(self.logoLabel.bounds);
    CGFloat logoLabelWidth = CGRectGetWidth(self.logoLabel.bounds);
    
    CGFloat logoLabelY = CGRectGetMaxY(self.logoIcon.frame) + 10;
    
    self.logoLabel.frame = CGRectMake((viewWidth - logoLabelWidth) / 2., logoLabelY, logoLabelWidth, logoLabelHeight);
    
    CGFloat logoDesHeight = CGRectGetHeight(self.logoDes.bounds);
    CGFloat logoDesWidth = CGRectGetWidth(self.logoDes.bounds);
    
    self.logoDes.frame = CGRectMake((viewWidth - logoDesWidth) / 2., logoLabelY + logoLabelHeight, logoDesWidth, logoDesHeight);
    
//    [self showVersionLabel];
}

-(void)initInputArea:(CGFloat)areaHeight{
    CGFloat padding = 10;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    CGFloat iconWidth = 50;
    CGFloat inputHeight = areaHeight / 2.;
    
    self.inputArea.frame = CGRectMake(0, self.view.centerY, viewWidth, areaHeight);
    
    CGFloat usernameIconHeight = CGRectGetHeight(self.usernameIcon.bounds);
    CGFloat usernameIconWidth = CGRectGetWidth(self.usernameIcon.bounds);
    
    self.usernameIcon.frame = CGRectMake((iconWidth - usernameIconWidth) / 2., (inputHeight - usernameIconHeight) / 2., usernameIconWidth, usernameIconHeight);
    
    self.usernameText.frame = CGRectMake(iconWidth + padding, 0, viewWidth - iconWidth - padding * 2, inputHeight);
    
    self.inputLineCenterY.frame = CGRectMake(0, inputHeight, viewWidth, LINE_WIDTH);
    
    CGSize writableIconSize = self.writableIcon.frame.size;
    
    self.writableIcon.frame = (CGRect){
        CGPointMake((iconWidth - writableIconSize.width) / 2., inputHeight + (inputHeight - writableIconSize.height) / 2.),writableIconSize
    };
    CGSize writableLabelSize = self.writableLabel.frame.size;
    self.writableLabel.frame = (CGRect){
        CGPointMake(iconWidth + padding, inputHeight + (inputHeight - writableLabelSize.height) / 2.),writableLabelSize
    };
    
    self.writableSwitch.frame = CGRectMake(CGRectGetMaxX(self.writableLabel.frame) + padding, 0, 100, 10);
    CGPoint switchCenter = self.writableSwitch.center;
    switchCenter.y = self.writableLabel.center.y;
    self.writableSwitch.center = switchCenter;
    
    self.submitButton.frame = CGRectMake(padding, CGRectGetMaxY(self.inputArea.frame) + inputHeight, viewWidth - padding * 2, inputHeight);
//    self.loginButton.frame = CGRectMake(padding, CGRectGetMaxY(self.submitButton.frame) + inputHeight, viewWidth - padding * 2, inputHeight);
    
    self.returnButton.frame = CGRectMake(0, viewHeight - inputHeight - padding, 0, inputHeight);
    //    if (!self.submitButton.hidden) {
    self.loginButton.frame = CGRectMake(0, viewHeight - inputHeight - padding, 0, inputHeight);
    //    }
    [UICreationUtils autoEnsureViewsWidth:0 totolWidth:viewWidth views:@[self.returnButton,self.loginButton] viewWidths:@[@"40%",@"60%"] padding:padding];
    
    if(self.submitButton.maxY > self.returnButton.y){
        self.submitButton.maxY = self.returnButton.y - padding;
    }
}

-(void)clickSubmitButton:(UIView*)sender{
//    [PopAnimateManager startClickAnimation:sender];
    
    NSString* phone = self.usernameText.text;
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    [SVProgressHUD showWithStatus:@"登陆中" maskType:SVProgressHUDMaskTypeBlack];
    __weak __typeof(self) weakSelf = self;
    [self.loginViewModel getAuthCode:phone isAdmin:YES returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AuthCodeBean* authCode = [AuthCodeBean yy_modelWithJSON:returnValue];//记录userInfo
        [strongSelf.loginViewModel logon:phone authcode:authCode.authCode returnBlock:^(id returnValue) {
            [SVProgressHUD dismiss];
            [strongSelf tryAnalyzeUserProxy:returnValue];
        } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
            [SVProgressHUD dismiss];
            [HudManager showToast:errorMsg];
            [PopAnimateManager startShakeAnimation:sender];
        }];
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        [HudManager showToast:errorMsg];
        [PopAnimateManager startShakeAnimation:sender];
    }];
    
}

-(void)tryAnalyzeUserProxy:(id)returnValue{
    User *user = [User yy_modelWithJSON:returnValue];//记录userInfo
    if (![user hasAudited]) {
        [HudManager showToast:@"用户正在审核中，请切换用户"];
    }else{
        [Config setUserProxy:user];
        [Config setIsUserProxyMode:YES];
        [Config setHasPermission:self.writableSwitch.selected];
        
        [UserDefaultsUtils setObject:user.telphone forKey:PROXY_PHONE_KEY];//记住监控手机
        
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(adminLoginComplete:)]) {
            [self.delegate adminLoginComplete:user];
        }
    }
}

-(void)clickLoginButton:(UIView*)sender{
//    [PopAnimateManager startClickAnimation:sender];
//    [[OwnerViewController sharedInstance] pushViewController:[[VersionInfoController alloc]init] animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(adminLoginComplete:)]) {
        [self.delegate adminLoginComplete:[Config getUser]];
    }
}

-(void)clickReturnButton:(UIView*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(adminWillReturnBack)]) {
        [self.delegate adminWillReturnBack];
    }
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(adminDidReturnBack)]) {
            [strongSelf.delegate adminDidReturnBack];
        }
    }];
    
}


@end
