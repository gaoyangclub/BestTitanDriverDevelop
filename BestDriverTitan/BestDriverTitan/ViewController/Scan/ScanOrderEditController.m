//
//  ScanCargoInfoController.m
//  BestDriverTitan
//
//  Created by admin on 2017/11/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanOrderEditController.h"
#import "FlatButton.h"
#import "RoundRectNode.h"
#import "HudManager.h"

@interface ScanOrderEditController (){
    BOOL isEdited;
}

@property(nonatomic,retain) UILabel* titleLabel;//大标题栏

@property(nonatomic,retain) ASDisplayNode* sourceCodeBack;
@property(nonatomic,retain) ASTextNode* sourceCodeNode;
@property(nonatomic,retain) ASTextNode* sourceCodeIcon;

@property(nonatomic,retain) ASTextNode* weightLabel;//重量
@property(nonatomic,retain) ASTextNode* volumeLabel;//体积

@property(nonatomic,retain) UITextField* weightText;//重量文本框
@property(nonatomic,retain) RoundRectNode* weightTextBack;//重量文本框背景
@property(nonatomic,retain) ASTextNode* weightUnitLabel;//重量单位
@property(nonatomic,retain) UITextField* volumeText;//体积文本框
@property(nonatomic,retain) RoundRectNode* volumeTextBack;//重量文本框背景
@property(nonatomic,retain) ASTextNode* volumeUnitLabel;//体积单位

@property(nonatomic,retain) FlatButton* submitButton;//保存

@end

@implementation ScanOrderEditController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(ASDisplayNode *)sourceCodeBack{
    if (!_sourceCodeBack) {
        _sourceCodeBack = [[ASDisplayNode alloc]init];
        _sourceCodeBack.backgroundColor = [UIColor whiteColor];
        _sourceCodeBack.layerBacked = YES;
        [self.view.layer addSublayer:_sourceCodeBack.layer];
    }
    return _sourceCodeBack;
}

-(ASTextNode *)sourceCodeNode{
    if (!_sourceCodeNode) {
        _sourceCodeNode = [[ASTextNode alloc]init];
        _sourceCodeNode.layerBacked = YES;
        [self.sourceCodeBack addSubnode:_sourceCodeNode];
    }
    return _sourceCodeNode;
}

-(ASTextNode *)sourceCodeIcon{
    if (!_sourceCodeIcon) {
        _sourceCodeIcon = [[ASTextNode alloc]init];
        _sourceCodeIcon.layerBacked = YES;
        _sourceCodeIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:30 content:ICON_TIAO_MA];
        _sourceCodeIcon.size = [_sourceCodeIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.sourceCodeBack addSubnode:_sourceCodeIcon];
    }
    return _sourceCodeIcon;
}

-(ASTextNode *)weightLabel{
    if(!_weightLabel){
        _weightLabel = [[ASTextNode alloc]init];
        _weightLabel.layerBacked = YES;
        _weightLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:@"重量"];
        _weightLabel.size = [_weightLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.view.layer addSublayer:_weightLabel.layer];
    }
    return _weightLabel;
}

-(ASTextNode *)volumeLabel{
    if(!_volumeLabel){
        _volumeLabel = [[ASTextNode alloc]init];
        _volumeLabel.layerBacked = YES;
        _volumeLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:@"体积"];
        _volumeLabel.size = [_volumeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.view.layer addSublayer:_volumeLabel.layer];
    }
    return _volumeLabel;
}

-(UITextField *)weightText{
    if (!_weightText) {
        _weightText = [[UITextField alloc]init];
        //        _weightText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _weightText.font = [UIFont systemFontOfSize:16];
        _weightText.textColor = COLOR_BLACK_ORIGINAL;
        //        _weightText.delegate = self; //文本交互代理
        _weightText.placeholder = @"请输入重量";
        _weightText.keyboardType = UIKeyboardTypeDecimalPad;
        _weightText.returnKeyType = UIReturnKeyDone; //键盘return键样式
//        _weightText.backgroundColor = [UIColor whiteColor];
//        _weightText.textAlignment = NSTextAlignmentCenter;
        //        _weightText
//        _weightText.layer.cornerRadius = 5;
//        _weightText.layer.borderColor = COLOR_LINE.CGColor;
//        _weightText.layer.borderWidth = 1;
//        _weightText.layer.masksToBounds = YES;
        
        [self.view addSubview:_weightText];
        [_weightText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _weightText;
}

-(RoundRectNode *)weightTextBack{
    if (!_weightTextBack) {
        _weightTextBack = [[RoundRectNode alloc]init];
        _weightTextBack.layerBacked = YES;
        _weightTextBack.fillColor = [UIColor whiteColor];
        _weightTextBack.cornerRadius = 5;
        _weightTextBack.strokeWidth = 1;
        _weightTextBack.strokeColor = COLOR_LINE;
        [self.view.layer addSublayer:_weightTextBack.layer];
    }
    return _weightTextBack;
}

-(ASTextNode *)weightUnitLabel{
    if (!_weightUnitLabel) {
        _weightUnitLabel = [[ASTextNode alloc]init];
        _weightUnitLabel.layerBacked = YES;
        _weightUnitLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:@"Kg"];
        _weightUnitLabel.size = [_weightUnitLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.view.layer addSublayer:_weightUnitLabel.layer];
    }
    return _weightUnitLabel;
}

-(UITextField *)volumeText{
    if (!_volumeText) {
        _volumeText = [[UITextField alloc]init];
        //        _volumeText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _volumeText.font = [UIFont systemFontOfSize:16];
        _volumeText.textColor = COLOR_BLACK_ORIGINAL;
        //        _volumeText.delegate = self; //文本交互代理
        _volumeText.placeholder = @"请输入体积";
        _volumeText.keyboardType = UIKeyboardTypeDecimalPad;
        _volumeText.returnKeyType = UIReturnKeyDone; //键盘return键样式
//        _volumeText.backgroundColor = FlatWhite;
//        _volumeText.textAlignment = NSTextAlignmentCenter;
        //        _weightText
        [self.view addSubview:_volumeText];
        [_volumeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _volumeText;
}

-(RoundRectNode *)volumeTextBack{
    if (!_volumeTextBack) {
        _volumeTextBack = [[RoundRectNode alloc]init];
        _volumeTextBack.layerBacked = YES;
        _volumeTextBack.fillColor = [UIColor whiteColor];
        _volumeTextBack.cornerRadius = 5;
        _volumeTextBack.strokeWidth = 1;
        _volumeTextBack.strokeColor = COLOR_LINE;
        [self.view.layer addSublayer:_volumeTextBack.layer];
    }
    return _volumeTextBack;
}

-(ASTextNode *)volumeUnitLabel{
    if (!_volumeUnitLabel) {
        _volumeUnitLabel = [[ASTextNode alloc]init];
        _volumeUnitLabel.layerBacked = YES;
        _volumeUnitLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:@"m³"];
        _volumeUnitLabel.size = [_volumeUnitLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.view.layer addSublayer:_volumeUnitLabel.layer];
    }
    return _volumeUnitLabel;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.title = @"保   存";
        _submitButton.titleSize = 20;
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger const maxLength = 12;
    //    if (textField == self.editText) {
    if (maxLength && textField.text.length > maxLength) {
        UITextRange *markedRange = [textField markedTextRange];
        if (markedRange) {
            return;
        }
        //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
        //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:maxLength];
        NSString* value = [textField.text substringToIndex:range.location];
        textField.text = value;
    }
    isEdited = YES;
    //    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationItem];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)initNavigationItem{
    self.titleLabel.text = NAVIGATION_TITLE_SCAN_CARGO;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
}

-(void)leftClick{
    NSString* alertMessage;
    if (isEdited) {
        alertMessage = @"您有编辑过的数据，确定要退出吗？退出数据将不会保存!";
    }else if(!self.weightText.text || !self.volumeText.text){
        alertMessage = @"您还未填入重量或体积数据，确定要退出吗？退出数据将不会保存!";
    }else{
        alertMessage = @"退出货量数据将不会保存,确定退出吗？";
    }
    if (alertMessage) {
        __weak __typeof(self) weakSelf = self;
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf dismiss];
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(orderCanceled:)]) {
                [strongSelf.delegate orderCanceled:strongSelf];
            }
        }]];
        [self presentViewController:alertCtrl animated:YES completion:nil];
    }
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat const leftMargin = 10;
    CGFloat const codeBackHeight = 50;
    CGFloat const gap = 10;
    
    self.sourceCodeBack.frame = CGRectMake(0, gap, self.view.width, codeBackHeight + gap);
    
    self.sourceCodeIcon.x = leftMargin;
    
    self.sourceCodeNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:self.scanCodeBean.sourceCode];
    self.sourceCodeNode.size = [self.sourceCodeNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.sourceCodeNode.x = self.sourceCodeIcon.maxX + leftMargin;
    self.sourceCodeNode.centerY = self.sourceCodeIcon.centerY = self.sourceCodeBack.height / 2.;
    
    self.weightLabel.x = leftMargin;
    self.weightLabel.y = self.sourceCodeBack.maxY + gap;
    
    CGFloat const textWidth = self.view.width - leftMargin * 2 - 20;
    CGFloat const textHeight = codeBackHeight;
    
    self.weightTextBack.frame = CGRectMake(leftMargin, self.weightLabel.maxY + gap, textWidth, textHeight);
    self.weightText.frame = CGRectMake(self.weightTextBack.x + leftMargin, self.weightTextBack.y, self.weightTextBack.width - leftMargin * 2, self.weightTextBack.height);
    self.weightText.text = self.scanCodeBean.weight;
    self.weightUnitLabel.centerY = self.weightTextBack.centerY;
    self.weightUnitLabel.x = self.weightTextBack.maxX + 5;
    
    self.volumeLabel.x = leftMargin;
    self.volumeLabel.y = self.weightText.maxY + gap;
    
    self.volumeTextBack.frame = CGRectMake(leftMargin, self.volumeLabel.maxY + gap, textWidth, textHeight);
    self.volumeText.frame = CGRectMake(self.volumeTextBack.x + leftMargin, self.volumeTextBack.y, self.volumeTextBack.width - leftMargin * 2, self.volumeTextBack.height);
    self.volumeText.text = self.scanCodeBean.volume;
    self.volumeUnitLabel.centerY = self.volumeTextBack.centerY;
    self.volumeUnitLabel.x = self.volumeTextBack.maxX + 5;
    
    self.submitButton.frame = CGRectMake(leftMargin, self.volumeTextBack.maxY + codeBackHeight, self.view.width - leftMargin * 2, SUBMIT_BUTTON_HEIGHT);
}

-(void)clickSubmitButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    if ([self checkCanSubmit]) {
        self.scanCodeBean.weight = self.weightText.text;
        self.scanCodeBean.volume = self.volumeText.text;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderEdited:)]) {
            [self.delegate orderEdited:self];
        }
        
        [self dismiss];
    }
}

-(BOOL)checkCanSubmit{
    if (!self.weightText.text) {
        [HudManager showToast:@"请先填入重量!"];
        [PopAnimateManager startShakeAnimation:self.weightText];
        return NO;
    }
    if (!self.volumeText.text) {
        [HudManager showToast:@"请先填入体积!"];
        [PopAnimateManager startShakeAnimation:self.volumeText];
        return NO;
    }
    NSArray<NSString *> * subStrings = [self.weightText.text componentsSeparatedByString:@"."];
    if (subStrings.count > 2) {//有多个小数点
        [HudManager showToast:@"重量中出现多个小数点，请确认输入格式!"];
        [PopAnimateManager startShakeAnimation:self.weightText];
        return NO;
    }
    subStrings = [self.volumeText.text componentsSeparatedByString:@"."];
    if (subStrings.count > 2) {//有多个小数点
        [HudManager showToast:@"体积中出现多个小数点，请确认输入格式!"];
        [PopAnimateManager startShakeAnimation:self.volumeText];
        return NO;
    }
    return YES;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
