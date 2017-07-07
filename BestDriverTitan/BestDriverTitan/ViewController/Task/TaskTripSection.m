//
//  TaskTripSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskTripSection.h"
#import "RoundRectNode.h"
#import "DIYTabBarItem.h"
#import "OrderViewController.h"
#import "RootNavigationController.h"

@interface ActivityButton:UIControl

@property(nonatomic,retain)ASTextNode* iconNode;
@property(nonatomic,retain)ASTextNode* labelNode;
@property(nonatomic,retain)ASControlNode* alertNode;//警告货量差异
@property(nonatomic,retain)ASTextNode* stateNode;//完成情况状态
@property(nonatomic,retain)DIYBarData* data;//警告货量差异

-(void)showAlertNode;
-(void)hideAlertNode;

-(void)setComplete:(BOOL)isComplete;

//-(void)updateIconColor:(UIColor*)iconColor;

@end
@implementation ActivityButton

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
//    }
//    return self;
//}

-(ASControlNode *)alertNode{
    if (!_alertNode) {
        _alertNode = [[ASControlNode alloc]init];
        _alertNode.layerBacked = YES;
        _alertNode.userInteractionEnabled = NO;
        
        ASTextNode* alertIcon = [[ASTextNode alloc]init];
        alertIcon.layerBacked = YES;
        alertIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatYellow size:20 * SYSTEM_SCALE_FACTOR content:ICON_JING_GAO];
        CGSize alertSize = [alertIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;
        alertIcon.frame = (CGRect){
            CGPointMake(CGRectGetWidth(self.bounds) - alertSize.width - padding, CGRectGetHeight(self.bounds) - alertSize.height - padding),alertSize
        };
        [_alertNode addSubnode:alertIcon];
        
        [self.layer addSublayer:_alertNode.layer];
    }
    return _alertNode;
}

-(ASTextNode *)stateNode{
    if (!_stateNode) {
        _stateNode = [[ASTextNode alloc]init];
        _stateNode.layerBacked = YES;
        _stateNode.userInteractionEnabled = NO;
        [self.layer addSublayer:_stateNode.layer];
    }
    return _stateNode;
}

-(void)setComplete:(BOOL)isComplete{
    if (isComplete) {
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20 * SYSTEM_SCALE_FACTOR content:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20 * SYSTEM_SCALE_FACTOR content:ICON_DAI_SHANG_BAO];
    }
    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;
    self.stateNode.frame = (CGRect){
        CGPointMake(CGRectGetWidth(self.bounds) - stateSize.width - padding, padding),stateSize
    };
}

//-(void)updateIconColor:(UIColor*)iconColor{
//    self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:30                         context:self.data.image];
////    CGSize labelSize = [self.labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
////    self.labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
//}

-(void)showAlertNode{
    self.alertNode.hidden = NO;
    //加侦听器
    //点击展开货量差异提示
}

-(void)hideAlertNode{
    self.alertNode.hidden = YES;
    //    self.alertNode removeTarget:<#(nullable id)#> action:<#(nullable SEL)#> forControlEvents:<#(ASControlNodeEvent)#>
    //移除侦听器
}

@end

@interface TaskTripSection(){
    NSMutableDictionary* buttonDic;//活动上报按钮访问列表
}

@property(nonatomic,retain) RoundRectNode* topAreaBack;
@property(nonatomic,retain) UIView* topAreaView;

@property(nonatomic,retain) ASDisplayNode* backView;

@property (nonatomic,retain) ASTextNode* iconStart;//起点图标
//@property (nonatomic,retain) ASTextNode* iconEnd;//终点
@property (nonatomic,retain) ASTextNode* textStart;//起点图标
//@property (nonatomic,retain) ASTextNode* textEnd;//终点

@end


@implementation TaskTripSection

- (instancetype)init
{
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurred:)
                                                 name:EVENT_ADDRESS_SELECT
                                               object:nil];
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ADDRESS_SELECT object:nil];
//    [super dealloc];
}

-(ASDisplayNode *)backView{
    if (!_backView) {
        _backView = [[ASDisplayNode alloc]init];
        _backView.layerBacked = YES;
        _backView.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:_backView.layer];
    }
    return _backView;
}

-(ASTextNode *)iconStart{
    if (!_iconStart) {
        _iconStart = [[ASTextNode alloc]init];
        _iconStart.layerBacked = YES;
        [self.backView addSubnode:_iconStart];
    }
    return _iconStart;
}

//-(ASTextNode *)iconEnd{
//    if (!_iconEnd) {
//        _iconEnd = [[ASTextNode alloc]init];
//        _iconEnd.layerBacked = YES;
//        [self.backView addSubnode:_iconEnd];
//    }
//    return _iconEnd;
//}

-(ASTextNode *)textStart{
    if (!_textStart) {
        _textStart = [[ASTextNode alloc]init];
        _textStart.maximumNumberOfLines = 3;
        _textStart.truncationMode = NSLineBreakByTruncatingTail;
        _textStart.layerBacked = YES;
        [self.backView addSubnode:_textStart];
    }
    return _textStart;
}
//
//-(ASTextNode *)textEnd{
//    if (!_textEnd) {
//        _textEnd = [[ASTextNode alloc]init];
//        _textEnd.maximumNumberOfLines = 1;
//        _textEnd.truncationMode = NSLineBreakByTruncatingTail;
//        _textEnd.layerBacked = YES;
//        [self.backView addSubnode:_textEnd];
//    }
//    return _textEnd;
//}

-(UIView *)topAreaView{
    if (!_topAreaView) {
        _topAreaView = [[UIView alloc]init];
        _topAreaView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topAreaView];
    }
    return _topAreaView;
}

-(RoundRectNode *)topAreaBack{
    if (!_topAreaBack) {
        _topAreaBack = [[RoundRectNode alloc]init];
        _topAreaBack.fillColor = [UIColor whiteColor];
        _topAreaBack.cornerRadius = 5;
        _topAreaBack.layerBacked = YES;
        [self.topAreaView.layer addSublayer:_topAreaBack.layer];
    }
    return _topAreaBack;
}


//-(void)layoutSubviews{
//
//    CGFloat sectionWidth = self.bounds.size.width;
////    CGFloat sectionHeight = self.bounds.size.height;
//    
//    
//    
////    self.iconEnd.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:24 context:ICON_ZHONG_DIAN];
////    CGSize iconEndSize = [self.iconEnd measure:CGSizeMake(FLT_MAX, FLT_MAX)];
////    self.iconEnd.frame = (CGRect){ CGPointMake(leftpadding,squareHeight / 2. + (squareHeight / 2. - iconEndSize.height) / 2.),iconEndSize};
////    
////    self.textEnd.attributedString = [NSString simpleAttributedString:FlatBlack size:14 context:@"浙江省杭州市西湖区万塘路xxx号支付宝大楼百世店家"];
////    CGFloat maxEndWidth = sectionWidth - leftpadding * 2 - iconEndSize.width;
////    CGSize textEndSize = [self.textEnd measure:CGSizeMake(maxEndWidth, FLT_MAX)];
////    self.textEnd.frame = (CGRect){ CGPointMake(leftpadding + iconEndSize.width + leftpadding / 2.,squareHeight / 2. + (squareHeight / 2. - textEndSize.height) / 2.),textEndSize};
//}


- (void)eventOccurred:(NSNotification*)eventData{
    self.backgroundColor = COLOR_BACKGROUND;
    
    NSString* address = eventData.object;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    CGFloat leftpadding = 10;
    
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT - 5;
    
    self.backView.frame = CGRectMake(0, 0, sectionWidth, squareHeight);
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatBlack size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    self.iconStart.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:30 content:ICON_JU_LI];
    CGSize iconStartSize = [self.iconStart measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconStart.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconStartSize.height) / 2.),iconStartSize};
    
    self.textStart.attributedString = textString;
    CGFloat maxStartWidth = sectionWidth - leftpadding * 2 - iconStartSize.width;
    
    CGSize textStartSize = [self.textStart measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textStart.frame = (CGRect){ CGPointMake(leftpadding + iconStartSize.width + leftpadding / 2.,(squareHeight - textStartSize.height) / 2.),textStartSize};
    
    CGFloat leftMargin = 0;//10;
    CGFloat topMargin = 5;
    
    CGFloat backWidth = sectionWidth - leftMargin * 2;
    CGFloat backHeight = sectionHeight - squareHeight - topMargin * 2;
    
    self.topAreaView.frame = CGRectMake(leftMargin, squareHeight + topMargin, backWidth, backHeight);
//    self.topAreaBack.frame = self.topAreaView.bounds;
//    [self initTopArea:backWidth];
//    [self checkButtonStates];
}

-(void)initTopArea:(CGFloat)backWidth{
    if (!buttonDic) {
        CGFloat buttonWidth = backWidth / 3.;
        CGFloat buttonHeight = 65 * SYSTEM_SCALE_FACTOR;
        CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;//内边距
        CGFloat iconOffset = -25 * SYSTEM_SCALE_FACTOR;
        CGFloat labelOffset = 10 * SYSTEM_SCALE_FACTOR;
        
        buttonDic = [[NSMutableDictionary alloc]init];
        
        //6个活动上报按钮
        NSArray<DIYBarData *>* dataArray = @[[DIYBarData initWithParams:TABBAR_TITLE_TI_HUO image:ICON_TI_HUO],
                                             [DIYBarData initWithParams:TABBAR_TITLE_ZHUANG_CHE image:ICON_ZHUANG_CHE],
                                             [DIYBarData initWithParams:TABBAR_TITLE_XIE_HUO image:ICON_XIE_HUO],
                                             [DIYBarData initWithParams:TABBAR_TITLE_QIAN_SHOU image:ICON_QIAN_SHOU],
                                             [DIYBarData initWithParams:TABBAR_TITLE_HUI_DAN image:ICON_HUI_DAN],
                                             [DIYBarData initWithParams:TABBAR_TITLE_SHOU_KUAN image:ICON_SHOU_KUAN],
                                             ];
        //2行3列
        for(int i = 0 ; i < dataArray.count ; i ++){
            DIYBarData* data = dataArray[i];
            
            ActivityButton* btn = [[ActivityButton alloc]init];
            [btn setShowTouch:YES];
            btn.data = data;
            //            btn.layerBacked = YES;
            [self.topAreaView addSubview:btn];
            btn.frame = CGRectMake((i % 3) * buttonWidth, (i / 3) * buttonHeight, buttonWidth, buttonHeight);
            
            ASTextNode* iconNode = btn.iconNode = [[ASTextNode alloc]init];
            iconNode.layerBacked = YES;
            iconNode.userInteractionEnabled = NO;
            [btn.layer addSublayer:iconNode.layer];
            iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatPowderBlueDark size:30 * SYSTEM_SCALE_FACTOR content:data.image];
            CGSize iconSize = [iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
            iconNode.frame = (CGRect){CGPointMake((buttonWidth - iconSize.width) / 2., buttonHeight / 2. + iconOffset),iconSize};
            
            ASTextNode* labelNode = btn.labelNode = [[ASTextNode alloc]init];
            labelNode.layerBacked = YES;
            labelNode.userInteractionEnabled = NO;
            [btn.layer addSublayer:labelNode.layer];
            labelNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:12 * SYSTEM_SCALE_FACTOR  content:data.title];
            CGSize labelSize = [labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
            labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
            
            [btn addTarget:self action:@selector(clickActivityButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [buttonDic setValue:btn forKey:data.title];
            
            if (i % 3 == 0) {//横向的线
                ASDisplayNode* lineTopY = [[ASDisplayNode alloc]init];
                lineTopY.backgroundColor = COLOR_LINE;
                lineTopY.layerBacked = YES;
                lineTopY.frame = CGRectMake(padding, (i / 3 + 1) * buttonHeight - LINE_WIDTH / 2., backWidth - padding * 2, LINE_WIDTH);
                [self.topAreaBack addSubnode:lineTopY];
            }else{
                ASDisplayNode* lineTopX = [[ASDisplayNode alloc]init];
                lineTopX.backgroundColor = COLOR_LINE;
                lineTopX.layerBacked = YES;
                lineTopX.frame = CGRectMake((i % 3) * buttonWidth - LINE_WIDTH / 2., (i / 3) * buttonHeight + padding, LINE_WIDTH , buttonHeight - padding * 2);
                [self.topAreaBack addSubnode:lineTopX];
            }
        }
    }
}

-(void)clickActivityButton:(ActivityButton*)btn{
    UIViewController* controller = [[OrderViewController alloc]init];
    [[RootNavigationController sharedInstance] pushViewController:controller animated:YES];
}

-(void)checkButtonStates{
    for (NSString *key in buttonDic) {
        ActivityButton* btn = buttonDic[key];
        int count = (arc4random() % 4); //生成0-2范围的随机数
        if (count > 0) {
            if (count > 1) {
                //                [btn updateIconColor:COLOR_PRIMARY];
                [btn setComplete:YES];
                if (count > 2) {
                    [btn showAlertNode];
                }
            }else{
                //                [btn updateIconColor:COLOR_PRIMARY];
                [btn setComplete:NO];
            }
            btn.stateNode.hidden = NO;
            [btn setShowTouch:YES];
            //            btn.userInteractionEnabled = YES;
            btn.alpha = 1;
        }else{
            //            [btn updateIconColor:FlatGray];
            btn.stateNode.hidden = YES;
            [btn setShowTouch:NO];
            //            btn.userInteractionEnabled = NO;//无法交互
            btn.alpha = 0.3;
            [btn hideAlertNode];
        }
    }
}


@end
