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
#import "FlatButton.h"
#import "CustomPopListView.h"
#import "AuthCodeBean.h"

@interface LoginViewController()<CustomPopListViewDelegate>{
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
@property(nonatomic,retain)UILabel* versionLabel;

@property(nonatomic,retain)UILabel* flyTagLabel;

@property(nonatomic,retain)UILabel* operateLabeL;

@property(nonatomic,retain)FlatButton* operateButton;

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
        _logoLabel = [UICreationUtils createLabel:24 color:COLOR_BLACK_ORIGINAL text:APPLICATION_NAME sizeToFit:YES superView:self.view];
    }
    return _logoLabel;
}

-(UILabel *)logoDes{
    if (!_logoDes) {
        _logoDes = [UICreationUtils createLabel:16 color:COLOR_BLACK_ORIGINAL text:APPLICATION_NAME_EN sizeToFit:YES superView:self.view];
    }
    return _logoDes;
}

-(UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [UICreationUtils createLabel:14 color:FlatGray];
        [self.view addSubview:_versionLabel];
    }
    return _versionLabel;
}

-(UILabel *)flyTagLabel{
    if (!_flyTagLabel) {
        _flyTagLabel = [UICreationUtils createLabel:14 color:COLOR_BLACK_ORIGINAL text:@"语音技术由科大讯飞提供" sizeToFit:YES superView:self.view];
    }
    return _flyTagLabel;
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

-(UILabel *)authcodeIcon{
    if (!_authcodeIcon) {
        _authcodeIcon = [UICreationUtils createLabel:ICON_FONT_NAME size:24 color:COLOR_PRIMARY text:ICON_YAN_ZHENG_MA sizeToFit:YES superView:self.inputArea];
    }
    return _authcodeIcon;
}

-(UITextField *)authcodeText{
    if (!_authcodeText) {
        _authcodeText = [[UITextField alloc]init];
        _authcodeText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _authcodeText.font = [UIFont systemFontOfSize:16];
        _authcodeText.textColor = COLOR_BLACK_ORIGINAL;
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

-(UILabel *)operateLabeL{
    if (!_operateLabeL) {
        _operateLabeL = [UICreationUtils createLabel:14 color:FlatGray text:@"切换线路" sizeToFit:YES superView:self.view];
    }
    return _operateLabeL;
}

-(FlatButton *)operateButton{
    if(!_operateButton){
        _operateButton = [[FlatButton alloc]init];
        _operateButton.strokeWidth = 1;
        _operateButton.strokeColor = COLOR_PRIMARY;
        _operateButton.titleSize = 14;
        _operateButton.titleColor = COLOR_PRIMARY;
        _operateButton.fillColor = [UIColor whiteColor];
        [_operateButton addTarget:self action:@selector(clickOperateButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_operateButton];
    }
    return _operateButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;

    [self initLogoArea];
    [self initInputArea:100];
    
    if (DEBUG_MODE) {
        [self initOperateArea];
    }else{
        [self showVersionLabel];
    }
    
    [self initData];
}

-(void)initOperateArea{
    NSNumber* modeValue = [UserDefaultsUtils getObject:NET_MODE_KEY];
    if (modeValue) {
        [NetConfig setCurrentNetMode:[modeValue integerValue]];
        [self showVersionLabel];
    }
    
    CGFloat const gap = 20;
    self.operateLabeL.x = self.submitButton.x;
    CGFloat labelY = self.submitButton.maxY + gap;
    if (labelY + self.operateLabeL.height > self.view.height - 10) {
        self.operateLabeL.maxY = self.view.height - gap;
        self.submitButton.maxY = self.operateLabeL.y - gap;
    }else{
        self.operateLabeL.y = labelY;
    }
    
    self.operateButton.title = [Config getNetModelName:NET_MODE];
    
    self.operateButton.size = CGSizeMake(100, 25);
    self.operateButton.x = self.operateLabeL.maxX + 10;
    self.operateButton.centerY = self.operateLabeL.centerY;
}

-(void)clickOperateButton{
    CustomPopListView* popListView = [[CustomPopListView alloc]init];
    
    NSArray* netModes = [NetConfig getNetModes];
    NSMutableArray* dataArray = [NSMutableArray array];
    for (NSNumber* modeValue in netModes) {
        [dataArray addObject:[Config getNetModelName:[modeValue integerValue]]];
    }
    popListView.dataArray = dataArray;
    popListView.delegate = self;
    
    [popListView show];
}

-(void)onSelectedIndex:(CustomPopListView *)listView index:(NSInteger)index{
    NSArray* netModes = [NetConfig getNetModes];
    
    NetModeType mode = [netModes[index] integerValue];
    [NetConfig setCurrentNetMode:mode];
    
    [UserDefaultsUtils setObject:[NSNumber numberWithInteger:mode] forKey:NET_MODE_KEY];
    
    [self showVersionLabel];
    
    self.operateButton.title = [Config getNetModelName:NET_MODE];
    [self endCountDown];
}

-(void)initData{
//    id userObj = [UserDefaultsUtils getObject:USER_KEY];
//    if (userObj) {
//        [self analyzeLoginResult:userObj canSave:NO];
//    }else{
        [self.usernameText setText:[UserDefaultsUtils getObject:PHONE_KEY]];
//    }
//    NSString *deviceUDID = [[UIDevice currentDevice] identifierForVendor].debugDescription;
//    
//    [self.authcodeText setText:deviceUDID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLogoArea{
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat logoMarginTop = 50;
//    CGFloat logoMarginBottom = 95;
    
    CGFloat logoHeight = SYSTEM_SCALE_FACTOR * 120;//self.view.center.y - logoMarginTop - logoMarginBottom;
    
    CGFloat logoMarginTop = (self.view.centerY - logoHeight - self.logoLabel.height - self.logoDes.height) / 2.;
    
    self.logoImg.frame = CGRectMake(0, logoMarginTop, viewWidth, logoHeight);
    
//    CGFloat logoLabelHeight = CGRectGetHeight(self.logoLabel.bounds);
//    CGFloat logoLabelWidth = CGRectGetWidth(self.logoLabel.bounds);
    
    CGFloat logoLabelY = CGRectGetMaxY(self.logoImg.frame) + 10;
    
//    self.logoLabel.frame = CGRectMake((viewWidth - logoLabelWidth) / 2., logoLabelY, logoLabelWidth, logoLabelHeight);
    self.logoLabel.centerX = self.logoDes.centerX = self.view.centerX;
    self.logoLabel.y = logoLabelY;
    self.logoDes.y = self.logoLabel.maxY;
//    CGFloat logoDesHeight = CGRectGetHeight(self.logoDes.bounds);
//    CGFloat logoDesWidth = CGRectGetWidth(self.logoDes.bounds);
    
//    self.logoDes.frame = CGRectMake((viewWidth - logoDesWidth) / 2., logoLabelY + logoLabelHeight, logoDesWidth, logoDesHeight);
    
    [self showVersionLabel];
    
//    self.flyTagLabel.y = self.versionLabel.maxY + 15;
//    self.flyTagLabel.centerX = self.view.centerX;
}

-(void)showVersionLabel{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    
    self.versionLabel.text = [Config getVersionDescription];
    [self.versionLabel sizeToFit];
    
    CGSize versionSize = self.versionLabel.frame.size;
    
    self.versionLabel.frame = (CGRect){CGPointMake((viewWidth - versionSize.width) / 2., CGRectGetMaxY(self.logoDes.frame)),versionSize};
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
        User *user = [strongSelf analyzeLoginResult:returnValue canSave:YES];
        [SVProgressHUD dismiss];
        
        if (![user hasAudited]) {
            [HudManager showToast:@"该用户暂未通过审核，请先到系统中录入用户信息!"];
            return;
        }
        if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(loginWillDismiss:)]){
            [strongSelf.delegate loginWillDismiss:user];
        }
        [strongSelf dismissViewControllerAnimated:YES completion:^{
            if(strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(loginDidDismiss:)]){
                [strongSelf.delegate loginDidDismiss:user];
            }
        }];
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        [HudManager showToast:errorMsg];
        
        [PopAnimateManager startShakeAnimation:sender];
    }];
}

-(User*)analyzeLoginResult:(id)returnValue canSave:(BOOL)canSave{
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
    return user;
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
//        DDLog(@"%@", returnValue);
        if(DEBUG_MODE){
            AuthCodeBean* authCode = [AuthCodeBean yy_modelWithJSON:returnValue];//记录userInfo
            [HudManager showToast:[authCode description]];
        }
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
