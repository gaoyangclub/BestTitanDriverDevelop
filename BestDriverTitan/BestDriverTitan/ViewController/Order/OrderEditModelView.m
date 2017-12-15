//
//  OrderEditModelView.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderEditModelView.h"
#import "DiyNumberAddView.h"
#import "AppDelegate.h"
#import "FlatButton.h"
#import "UICreationUtils.h"
#import "HudManager.h"

@interface OrderEditModelView()

@property(nonatomic,retain)ASTextNode* titleLabel;//标题

@property(nonatomic,retain)DiyNumberAddView* packageNumberView;//
@property(nonatomic,retain)ASTextNode* packageLabel;//包装数
@property(nonatomic,retain)ASTextNode* packageOriginal;//包装原始值

@property(nonatomic,retain)DiyNumberAddView* pieceNumberView;
@property(nonatomic,retain)ASTextNode* pieceLabel;//内件数

//@property(nonatomic,retain)FlatButton* editButton;//编辑 铅笔

@property(nonatomic,retain)ASTextNode* weightLabel;//重量

@property(nonatomic,retain)ASTextNode* volumeLabel;//体积

@property(nonatomic,retain)UITextField* weightText;//重量文本框
@property(nonatomic,retain)UITextField* volumeText;//体积文本框

@property(nonatomic,retain)FlatButton* submitButton;
@property(nonatomic,retain)FlatButton* returnButton;

@end

@implementation OrderEditModelView

-(instancetype)init{
    self = [super init];
    if (self) {
//        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
        self.leftMargin = rpx(20);
        self.minHeight = rpx(320);
    }
    return self;
}

-(ASTextNode *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleLabel.layer];
    }
    return _titleLabel;
}

-(ASTextNode *)packageLabel{
    if(!_packageLabel){
        _packageLabel = [[ASTextNode alloc]init];
        _packageLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_packageLabel.layer];
    }
    return _packageLabel;
}

-(DiyNumberAddView *)packageNumberView{
    if (!_packageNumberView) {
        _packageNumberView = [[DiyNumberAddView alloc]init];
        [self.contentView addSubview:_packageNumberView];
        _packageNumberView.cornerRadius = rpx(5);
        _packageNumberView.fillColor = [UIColor whiteColor];
        _packageNumberView.strokeWidth = 1;
        _packageNumberView.strokeColor = COLOR_LINE;
        _packageNumberView.maxLength = 9;
    }
    return _packageNumberView;
}

-(ASTextNode *)pieceLabel{
    if(!_pieceLabel){
        _pieceLabel = [[ASTextNode alloc]init];
        _pieceLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_pieceLabel.layer];
    }
    return _pieceLabel;
}

-(DiyNumberAddView *)pieceNumberView{
    if (!_pieceNumberView) {
        _pieceNumberView = [[DiyNumberAddView alloc]init];
        [self.contentView addSubview:_pieceNumberView];
        _pieceNumberView.cornerRadius = rpx(5);
        _pieceNumberView.fillColor = [UIColor whiteColor];
        _pieceNumberView.strokeWidth = 1;
        _pieceNumberView.strokeColor = COLOR_LINE;
        _pieceNumberView.maxLength = 9;
    }
    return _pieceNumberView;
}

-(ASTextNode *)weightLabel{
    if(!_weightLabel){
        _weightLabel = [[ASTextNode alloc]init];
        _weightLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_weightLabel.layer];
    }
    return _weightLabel;
}

-(ASTextNode *)volumeLabel{
    if(!_volumeLabel){
        _volumeLabel = [[ASTextNode alloc]init];
        _volumeLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_volumeLabel.layer];
    }
    return _volumeLabel;
}

-(UITextField *)weightText{
    if (!_weightText) {
        _weightText = [[UITextField alloc]init];
//        _weightText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _weightText.font = [UIFont systemFontOfSize:SIZE_TEXT_LARGE];
        _weightText.textColor = COLOR_TEXT_PRIMARY;
        //        _weightText.delegate = self; //文本交互代理
        _weightText.placeholder = @"请输入重量";
        _weightText.keyboardType = UIKeyboardTypeDecimalPad;
        _weightText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        _weightText.backgroundColor = FlatWhite;
        _weightText.textAlignment = NSTextAlignmentCenter;
//        _weightText
        [self.contentView addSubview:_weightText];
        [_weightText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _weightText;
}

-(UITextField *)volumeText{
    if (!_volumeText) {
        _volumeText = [[UITextField alloc]init];
        //        _volumeText.clearButtonMode = UITextFieldViewModeWhileEditing;//输入的时候显示close按钮
        _volumeText.font = [UIFont systemFontOfSize:SIZE_TEXT_LARGE];
        _volumeText.textColor = COLOR_TEXT_PRIMARY;
        //        _volumeText.delegate = self; //文本交互代理
        _volumeText.placeholder = @"请输入体积";
        _volumeText.keyboardType = UIKeyboardTypeDecimalPad;
        _volumeText.returnKeyType = UIReturnKeyDone; //键盘return键样式
        _volumeText.backgroundColor = FlatWhite;
        _volumeText.textAlignment = NSTextAlignmentCenter;
        //        _weightText
        [self.contentView addSubview:_volumeText];
        [_volumeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _volumeText;
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
//    }
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.title = @"确定修改";
        _submitButton.titleSize = SIZE_TEXT_LARGE;
        //        _loginButton.cornerRadius = 0;
        [self.contentView addSubview:_submitButton];
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(FlatButton *)returnButton{
    if (!_returnButton) {
        _returnButton = [[FlatButton alloc]init];
        _returnButton.fillColor = [UIColor whiteColor];
        _returnButton.titleColor = _returnButton.strokeColor = COLOR_PRIMARY;
        _returnButton.strokeWidth = 1;
        _returnButton.title = @"取消";
        _returnButton.titleSize = SIZE_TEXT_LARGE;
        //        _returnButton.cornerRadius = 0;
        [self.contentView addSubview:_returnButton];
        
        [_returnButton addTarget:self action:@selector(clickReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
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

-(void)clickSubmitButton:(UIView*)sender{
    if ([self checkCanSubmit]) {
        
//        if (self) {
//            <#statements#>
//        }
        
//        self.shipUnitBean.pacakageUnitCount = self.packageNumberView.totalCount;
//        self.shipUnitBean.itemCount = self.pieceNumberView.totalCount;
//        
//        self.shipUnitBean.actualReceivedWeight = self.weightText.text;
//        self.shipUnitBean.actualReceivedVolume = self.volumeText.text;
//        self.shipUnitBean.isEdited = YES;
        
        [self.shipUnitBean changeEditValue:self.packageNumberView.totalCount actualReceivedWeight:self.weightText.text actualReceivedVolume:self.volumeText.text itemCount:self.pieceNumberView.totalCount];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderEdited:)]) {
            [self.delegate orderEdited:self.shipUnitIndexPath];
        }
        [self dismiss];
    }
}

-(void)clickReturnButton:(UIView*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderCanceled:)]) {
        [self.delegate orderCanceled:self.shipUnitIndexPath];
    }
    [self dismiss];
}

-(void)viewDidLoad{
    //    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewWidth = self.contentView.width;// CGRectGetWidth(self.contentView.bounds);
    CGFloat viewHeight = self.contentView.height;//CGRectGetHeight(self.contentView.bounds);
    
    CGFloat lefftpadding = rpx(10);
    CGFloat titleHeight = rpx(30);
    
    CGFloat gapWidth = viewWidth / 2.;
//    CGFloat gapHeight = (viewHeight - titleHeight) / 2.;
    CGFloat numberWidth = rpx(120);
    CGFloat numberHeight = rpx(40);
    
    CGFloat viewCenterY = self.contentView.centerY;
    CGFloat offsetY = rpx(80);
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_TEXT_PRIMARY size:SIZE_NAVI_TITLE content:self.shipUnitBean.itemName];
    self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.x = lefftpadding;
    self.titleLabel.centerY = titleHeight / 2.;
    
    self.packageLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:SIZE_TEXT_SECONDARY content:@"包装数(箱)"];
    self.packageLabel.size = [self.packageLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.packageLabel.centerX = gapWidth / 2.;
    self.packageLabel.y = viewCenterY - offsetY;
    
    self.packageNumberView.frame = CGRectMake(self.packageLabel.centerX - numberWidth / 2., self.packageLabel.maxY, numberWidth, numberHeight);
    self.packageNumberView.totalCount = self.shipUnitBean.pacakageUnitCount;
    
    self.pieceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:SIZE_TEXT_SECONDARY content:@"内件数量"];
    self.pieceLabel.size = [self.pieceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.pieceLabel.centerX = gapWidth + gapWidth / 2.;
    self.pieceLabel.y = viewCenterY - offsetY;
    self.pieceNumberView.frame = CGRectMake(self.pieceLabel.centerX - numberWidth / 2., self.pieceLabel.maxY, numberWidth, numberHeight);
    self.pieceNumberView.totalCount = self.shipUnitBean.itemCount;
    
    self.weightLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:SIZE_TEXT_SECONDARY content:@"重量(kg)"];
    self.weightLabel.size = [self.weightLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.weightLabel.centerX = gapWidth / 2.;
    self.weightLabel.y = viewCenterY;// + offsetY / 2.;
    
    self.weightText.frame = CGRectMake(self.weightLabel.centerX - numberWidth / 2., self.weightLabel.maxY, numberWidth, numberHeight);
    self.weightText.text = self.shipUnitBean.actualReceivedWeight;
    //        self.packageNumberView.y = self.weightLabel.maxY;//临时添加...
    
    self.volumeLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:SIZE_TEXT_SECONDARY content:@"体积(m³)"];
    self.volumeLabel.size = [self.volumeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.volumeLabel.centerX = gapWidth + gapWidth / 2.;
    self.volumeLabel.centerY = self.weightLabel.centerY;
    
    self.volumeText.frame = CGRectMake(self.volumeLabel.centerX - numberWidth / 2., self.volumeLabel.maxY, numberWidth, numberHeight);
    self.volumeText.text = self.shipUnitBean.actualReceivedVolume;
    
//        self.bottomLine.hidden = self.isFirst;
//        if (!self.isFirst) {
//            self.bottomLine.frame = CGRectMake(lefftpadding, 0, viewWidth - lefftpadding * 2, LINE_WIDTH);
//        }
    CGFloat padding = rpx(20);
    
    self.submitButton.height = self.returnButton.height = numberHeight;
    self.submitButton.maxY = self.returnButton.maxY = viewHeight - padding;
    
    [UICreationUtils autoEnsureViewsWidth:0 totolWidth:viewWidth views:@[self.submitButton,self.returnButton] viewWidths:@[@"60%",@"40%"] padding:padding];
}

-(UIView*)getParentView{
    return ((UIViewController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController).view;
}

@end
