//
//  LoginViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "HudManager.h"
#import "User.h"
#import "UserDefaultsUtils.h"

@interface LoginViewController (){
    NSTimer* timer;
    NSInteger countDownSecond;
}

@property(nonatomic,retain)UIView* inputArea;
@property(nonatomic,retain)UILabel* usernameIcon;
@property(nonatomic,retain)UITextField* usernameText;
@property(nonatomic,retain)UILabel* authcodeIcon;
@property(nonatomic,retain)UITextField* authcodeText;
@property(nonatomic,retain)UIButton* authcodeButton;
@property(nonatomic,retain)UIView* inputLineCenterY;

@property(nonatomic,retain)UIButton* submitButton;

@property(nonatomic,retain)UIImageView* logoImg;
@property(nonatomic,retain)UILabel* logoLabel;
@property(nonatomic,retain)UILabel* logoDes;

@property(nonatomic,retain)LoginViewModel* loginViewModel;

@end

@implementation LoginViewController

-(LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}

-(UIImageView *)logoImg{
    if (!_logoImg) {
        UIImage* image = [UIImage imageNamed:@"splashLogo"];
        _logoImg = [[UIImageView alloc]initWithImage:image];
        _logoImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_logoImg];
    }
    return _logoImg;
}

-(UILabel *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [UICreationUtils createLabel:24 color:FlatBlack text:APPLICATION_NAME sizeToFit:YES superView:self.view];
    }
    return _logoLabel;
}

-(UILabel *)logoDes{
    if (!_logoDes) {
        _logoDes = [UICreationUtils createLabel:16 color:FlatBlack text:APPLICATION_NAME_EN sizeToFit:YES superView:self.view];
    }
    return _logoDes;
}

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
        _usernameIcon = [[UILabel alloc]init];
        _usernameIcon.font = [UIFont fontWithName:ICON_FONT_NAME size:24];
        _usernameIcon.text = ICON_WO_DE;
        _usernameIcon.textColor = COLOR_PRIMARY;
        [_usernameIcon sizeToFit];
        [self.inputArea addSubview:_usernameIcon];
    }
    return _usernameIcon;
}

-(UITextField *)usernameText{
    if (!_usernameText) {
        _usernameText = [[UITextField alloc]init];
        _usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _usernameText.font = [UIFont systemFontOfSize:16];
        _usernameText.textColor = FlatBlack;
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

-(UILabel *)authcodeIcon{
    if (!_authcodeIcon) {
        _authcodeIcon = [[UILabel alloc]init];
        _authcodeIcon.font = [UIFont fontWithName:ICON_FONT_NAME size:24];
        _authcodeIcon.text = ICON_YAN_ZHENG_MA;
        _authcodeIcon.textColor = COLOR_PRIMARY;
        [_authcodeIcon sizeToFit];
        [self.inputArea addSubview:_authcodeIcon];
    }
    return _authcodeIcon;
}

-(UITextField *)authcodeText{
    if (!_authcodeText) {
        _authcodeText = [[UITextField alloc]init];
        _authcodeText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _authcodeText.font = [UIFont systemFontOfSize:16];
        _authcodeText.textColor = FlatBlack;
        //        _authcodeText.delegate = self; //文本交互代理
        _authcodeText.placeholder = @"请输入验证码";
        _authcodeText.keyboardType = UIKeyboardTypeNumberPad;
        _authcodeText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        [self.inputArea addSubview:_authcodeText];
    }
    return _authcodeText;
}

-(UIButton *)authcodeButton{
    if (!_authcodeButton) {
        _authcodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _authcodeButton.backgroundColor = COLOR_PRIMARY;
        [_authcodeButton setTitle:@"验证码" forState:UIControlStateNormal];
        [_authcodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _authcodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        _authcodeButton.underlineNone = YES;
        [self.inputArea addSubview:_authcodeButton];
        [_authcodeButton setShowTouch:YES];
        
        _authcodeButton.layer.cornerRadius = 3;
        _authcodeButton.layer.masksToBounds = YES;
        [_authcodeButton addTarget:self action:@selector(clickAuthcodeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authcodeButton;
}

-(UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = COLOR_PRIMARY;
        [_submitButton setTitle:@"登   录" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _submitButton.underlineNone = YES;
        [self.view addSubview:_submitButton];
        
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        
        [_submitButton setShowTouch:YES];
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;

    [self initLogoArea];
    [self initInputArea:100];
    
    [self initData];
}

-(void)initData{
//    id userObj = [UserDefaultsUtils getObject:USER_KEY];
//    if (userObj) {
//        [self analyzeLoginResult:userObj canSave:NO];
//    }else{
        [self.usernameText setText:[UserDefaultsUtils getObject:PHONE_KEY]];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLogoArea{
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    
    CGFloat logoMargin = 75;
    
    CGFloat logoHeight = self.view.center.y - logoMargin * 2;
    
    self.logoImg.frame = CGRectMake(0, logoMargin, viewWidth, logoHeight);
    
    CGFloat logoLabelHeight = CGRectGetHeight(self.logoLabel.bounds);
    CGFloat logoLabelWidth = CGRectGetWidth(self.logoLabel.bounds);
    
    CGFloat logoLabelY = logoMargin + logoHeight + 10;
    
    self.logoLabel.frame = CGRectMake((viewWidth - logoLabelWidth) / 2., logoLabelY, logoLabelWidth, logoLabelHeight);
    
    CGFloat logoDesHeight = CGRectGetHeight(self.logoDes.bounds);
    CGFloat logoDesWidth = CGRectGetWidth(self.logoDes.bounds);
    
    self.logoDes.frame = CGRectMake((viewWidth - logoDesWidth) / 2., logoLabelY + logoLabelHeight, logoDesWidth, logoDesHeight);
}

-(void)initInputArea:(CGFloat)areaHeight{
    CGFloat padding = 10;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat iconWidth = 50;
    CGFloat inputHeight = areaHeight / 2.;
    
    self.inputArea.frame = CGRectMake(0, self.view.center.y, viewWidth, areaHeight);
    
    CGFloat usernameIconHeight = CGRectGetHeight(self.usernameIcon.bounds);
    CGFloat usernameIconWidth = CGRectGetWidth(self.usernameIcon.bounds);
    
    self.usernameIcon.frame = CGRectMake((iconWidth - usernameIconWidth) / 2., (inputHeight - usernameIconHeight) / 2., usernameIconWidth, usernameIconHeight);
    
    self.usernameText.frame = CGRectMake(iconWidth + padding, 0, viewWidth - iconWidth - padding * 2, inputHeight);
    
    self.inputLineCenterY.frame = CGRectMake(0, inputHeight, viewWidth, LINE_WIDTH);
    
    
    CGFloat authcodeIconHeight = CGRectGetHeight(self.authcodeIcon.bounds);
    CGFloat authcodeIconWidth = CGRectGetWidth(self.authcodeIcon.bounds);
    
    self.authcodeIcon.frame = CGRectMake((iconWidth - authcodeIconWidth) / 2., inputHeight + (inputHeight - authcodeIconHeight) / 2., authcodeIconWidth, authcodeIconHeight);
    
    CGFloat authcodeButtonHeight = inputHeight - padding * 2;
    
    self.authcodeButton.frame = CGRectMake(viewWidth - iconWidth - padding, inputHeight + (inputHeight - authcodeButtonHeight) / 2., iconWidth, authcodeButtonHeight);
    self.authcodeText.frame = CGRectMake(iconWidth + padding, inputHeight, viewWidth - iconWidth * 2 - padding * 3, inputHeight);
    
    self.submitButton.frame = CGRectMake(padding, CGRectGetMaxY(self.inputArea.frame) + inputHeight, viewWidth - padding * 2, inputHeight);
}

-(void)clickSubmitButton:(UIView*)sender{
//    [[PopAnimateManager sharedInstance]startClickAnimation:sender];
    
    NSString* phone = self.usernameText.text;
    NSString* authcode = self.authcodeText.text;
    
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    if (!authcode || authcode.length != 4) {
        [HudManager showToast:@"请输入4位的验证码!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"登陆中" maskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    __weak __typeof(self) weakSelf = self;
//    [weakSelf dismissViewControllerAnimated:YES completion:nil];
//    [SVProgressHUD dismiss];
//    return;
    [self.loginViewModel logon:phone authcode:authcode returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf analyzeLoginResult:returnValue canSave:YES];
        [SVProgressHUD dismiss];
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        [HudManager showToast:errorMsg];
        
        [PopAnimateManager startShakeAnimation:sender];
    }];
}

-(void)analyzeLoginResult:(id)returnValue canSave:(BOOL)canSave{
    User *user = [User yy_modelWithJSON:returnValue];//记录userInfo
    DDLog(@"user:%@", user);
    
    [Config setUser:user];
    if (canSave) {
        [UserDefaultsUtils setObject:user.telphone forKey:PHONE_KEY];
        if ([user hasAudited]) {
            [UserDefaultsUtils setObject:returnValue forKey:USER_KEY];
        }else{
            [UserDefaultsUtils removeObject:USER_KEY];//审核未通过清除残留
        }
    }
}

-(void)clickAuthcodeButton:(UIView*)sender{
    NSString* phone = self.usernameText.text;
    if (!phone || phone.length != 11) {
        [HudManager showToast:@"请输入11位的手机号!"];
        [PopAnimateManager startShakeAnimation:sender];
        return;
    }else{
        [PopAnimateManager startClickAnimation:sender];
    }
    
    [self startCountDown];
    
    [self.loginViewModel getAuthCode:phone returnBlock:^(id returnValue) {
        DDLog(@"%@", returnValue);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        
    }];
}

-(void)startCountDown{
    self.authcodeButton.backgroundColor = FlatGray;//置灰
    self.authcodeButton.userInteractionEnabled = NO;//无法交互
    countDownSecond = MAX_COUNT_DOWN;
    [self.authcodeButton setTitle:[[NSNumber numberWithInteger:countDownSecond] stringValue] forState:UIControlStateNormal];
    
    [self timerCancel];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 countDownAction
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)timerCancel{
    if (timer) {
        [timer invalidate];//取消原来的计时器
        timer = nil;
    }
}

-(void)countDownAction{
    countDownSecond --;
    [self.authcodeButton setTitle:[[NSNumber numberWithInteger:countDownSecond] stringValue] forState:UIControlStateNormal];
    if (countDownSecond <= 0) {
        [self endCountDown];
    }
}

-(void)endCountDown{
    [self timerCancel];
    [self.authcodeButton setTitle:@"验证码" forState:UIControlStateNormal];
    self.authcodeButton.backgroundColor = COLOR_PRIMARY;//置灰
    self.authcodeButton.userInteractionEnabled = YES;//无法交互
}

@end
