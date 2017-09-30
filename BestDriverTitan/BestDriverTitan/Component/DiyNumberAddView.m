//
//  DiyNumberAddView.m
//  BestDriverTitan
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DiyNumberAddView.h"
#import "RoundRectNode.h"

@interface NumberOperateButton: UIControl

@property(nonatomic,retain)UIColor* strokeColor;
@property(nonatomic,assign)CGFloat strokeWidth;
@property(nonatomic,assign)BOOL isAdd;

@end

@implementation NumberOperateButton

-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat centerX = width / 2.;
    CGFloat centerY = height / 2.;
    
    CGFloat radius = MIN(width, height) / 4.;
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, self.strokeWidth);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    CGContextMoveToPoint(context, centerX - radius, centerY);
    CGContextAddLineToPoint(context, centerX + radius, centerY);
    
    if (self.isAdd) {
        CGContextMoveToPoint(context, centerX, centerY - radius);
        CGContextAddLineToPoint(context, centerX, centerY + radius);
    }
    
    CGContextStrokePath(context);
}

@end


@interface DiyNumberAddView()<UITextFieldDelegate>

@property(nonatomic,retain) RoundRectNode* backReduce;
@property(nonatomic,retain) RoundRectNode* backIncrease;
@property(nonatomic,retain) RoundRectNode* backCenter;

@property(nonatomic,retain) NumberOperateButton* btnReduce;
@property(nonatomic,retain) NumberOperateButton* btnIncrease;

@property(nonatomic,retain) UITextField* editText;

@end

@implementation DiyNumberAddView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(RoundRectNode *)backReduce{
    if (!_backReduce) {
        _backReduce = [[RoundRectNode alloc]init];
//        _backReduce.topLeftRadius = _backReduce.bottomLeftRadius
        [self.layer addSublayer:_backReduce.layer];
    }
    return _backReduce;
}
-(RoundRectNode *)backIncrease{
    if (!_backIncrease) {
        _backIncrease = [[RoundRectNode alloc]init];
        [self.layer addSublayer:_backIncrease.layer];
    }
    return _backIncrease;
}
-(RoundRectNode *)backCenter{
    if (!_backCenter) {
        _backCenter = [[RoundRectNode alloc]init];
        [self.layer addSublayer:_backCenter.layer];
    }
    return _backCenter;
}

-(NumberOperateButton *)btnReduce{
    if (!_btnReduce) {
        _btnReduce = [[NumberOperateButton alloc]init];
        [_btnReduce setShowTouch:YES];
        [self addSubview:_btnReduce];
        
        [_btnReduce addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_btnReduce addTarget:self action:@"btnClick" forControlEvents:UIControlEventTouchUpInside];//长按
    }
    return _btnReduce;
}

-(NumberOperateButton *)btnIncrease{
    if (!_btnIncrease) {
        _btnIncrease = [[NumberOperateButton alloc]init];
        [_btnIncrease setShowTouch:YES];
        _btnIncrease.isAdd = YES;
        [self addSubview:_btnIncrease];
        
        [_btnIncrease addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnIncrease;
}

-(UITextField *)editText{
    if (!_editText) {
        _editText = [[UITextField alloc]init];
//        _editText.font = [UIFont systemFontOfSize:12];
        _editText.keyboardType = UIKeyboardTypeNumberPad;
        _editText.returnKeyType = UIReturnKeyDone; //键盘return键样式
//        _editText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _editText.textAlignment = NSTextAlignmentCenter;
        _editText.adjustsFontSizeToFitWidth = YES;
        _editText.minimumFontSize = 6;
        _editText.delegate = self;
        [self addSubview:_editText];
        [_editText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _editText;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.editText) {
        if (self.maxLength && textField.text.length > self.maxLength) {
            UITextRange *markedRange = [textField markedTextRange];
            if (markedRange) {
                return;
            }
            //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
            //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
            NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:self.maxLength];
            NSString* value = [textField.text substringToIndex:range.location];
            textField.text = value;
            self.totalCount = [value integerValue];
        }else{
            self.totalCount = [textField.text integerValue];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnWidth = height;
    if (height > width) {//纵向排列
//        btnWidth =
    }
    
    self.backReduce.frame = self.btnReduce.frame = CGRectMake(0, 0, btnWidth, height);
    self.backIncrease.frame = self.btnIncrease.frame = CGRectMake(width - btnWidth, 0, btnWidth, height);
    CGFloat centerWidth = width - btnWidth * 2 + self.strokeWidth * 2;
    self.backCenter.frame = self.editText.frame = CGRectMake(btnWidth - self.strokeWidth, 0, centerWidth, height);
    
    
    self.btnReduce.strokeColor = self.btnIncrease.strokeColor = self.backIncrease.strokeColor = self.backReduce.strokeColor = self.backCenter.strokeColor = self.strokeColor;
    self.btnReduce.strokeWidth = self.btnIncrease.strokeWidth = self.backIncrease.strokeWidth = self.backReduce.strokeWidth = self.backCenter.strokeWidth = self.strokeWidth;
    
//    self.backCenter.strokeColor = FlatCoffeeDark;
    
    self.backReduce.fillColor = self.backIncrease.fillColor = self.backCenter.fillColor = [UIColor whiteColor];
    self.backReduce.topLeftRadius = self.backReduce.bottomLeftRadius = self.backIncrease.topRightRadius = self.backIncrease.bottomRightRadius = self.cornerRadius;
    
    [self showEditCount];
}

-(void)showEditCount{
    self.editText.text = ConcatStrings(@"",@(self.totalCount));
}

-(void)btnClick:(NumberOperateButton *)btn{
    [self.editText resignFirstResponder];
    if (btn == self.btnIncrease) {
        self.totalCount ++;
    }else{
        self.totalCount --;
        if (self.totalCount < self.minCount) {
            self.totalCount = self.minCount;
        }
    }
    [self showEditCount];
}




@end
