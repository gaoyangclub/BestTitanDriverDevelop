//
//  TaskViewCell.m
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewCell.h"
#import "UIArrowView.h"

#define HTML_TO_TEXT(htmlString) [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

@interface TaskViewCell()

@property (nonatomic,retain) ASTextNode* codeText;//运单号
@property (nonatomic,retain) ASTextNode* licencePlateText;//车牌号
@property (nonatomic,retain) ASTextNode* shipUintCountText;//货量
@property (nonatomic,retain) ASTextNode* soCountText;//so个数
@property (nonatomic,retain) ASTextNode* costHourText;//配送时间花费
@property (nonatomic,retain) ASTextNode* distanceText;//配送里程花费
@property (nonatomic,retain) ASTextNode* expenseText;//参考运费
@property (nonatomic,retain) UIArrowView* rightArrow;
@property (nonatomic,retain) ASDisplayNode* lineNode;

@property (nonatomic,retain) ASTextNode* iconText;//未完成已完成状态图标

@end


@implementation TaskViewCell


-(ASTextNode *)iconText{
    if(!_iconText){
        _iconText = [[ASTextNode alloc]init];
        _iconText.layerBacked = YES;
//        _iconText.backgroundColor = [UIColor flatBrownColor];
        [self.contentView.layer addSublayer:_iconText.layer];
    }
    return _iconText;
}

//定义UI结构 利用AsyncDisplayKit的工具布局

-(ASDisplayNode *)lineNode{
    if(!_lineNode){
        _lineNode = [[ASDisplayNode alloc]init];
        _lineNode.backgroundColor = COLOR_LINE;
        [self.contentView.layer addSublayer:_lineNode.layer];
    }
    return _lineNode;
}

-(UIArrowView *)rightArrow{
    if(!_rightArrow){
        _rightArrow = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
        _rightArrow.direction = ArrowDirectRight;
        _rightArrow.lineColor = COLOR_LINE;
        _rightArrow.lineThinkness = 2;
        [self.contentView addSubview:_rightArrow];
    }
    return _rightArrow;
}

-(ASTextNode *)codeText{
    if(!_codeText){
        _codeText = [[ASTextNode alloc]init];
        _codeText.layerBacked = YES;
//                _codeText.textColor = [UIColor whiteColor];
        //        _titleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        //        _titleView.textAlignment = NSTextAlignmentCenter;
        [self.contentView.layer addSublayer:_codeText.layer];
    }
    return _codeText;
}

-(ASTextNode *)shipUintCountText{
    if(!_shipUintCountText){
        _shipUintCountText = [[ASTextNode alloc]init];
        _shipUintCountText.layerBacked = YES;
        [self.contentView.layer addSublayer:_shipUintCountText.layer];
    }
    return _shipUintCountText;
}

-(ASTextNode *)licencePlateText{
    if(!_licencePlateText){
        _licencePlateText.layerBacked = YES;
        [self.contentView.layer addSublayer:_licencePlateText.layer];
    }
    return _licencePlateText;
}


-(ASTextNode *)costHourText{
    if(!_costHourText){
        _costHourText = [[ASTextNode alloc]init];
        _costHourText.layerBacked = YES;
        [self.contentView.layer addSublayer:_costHourText.layer];
    }
    return _costHourText;
}


-(void)showSubviews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat leftpadding = 10;
    CGFloat gap1 = 5;
//    CGFloat gap2 = 0;
    CGFloat cellWidth = self.contentView.bounds.size.width;
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat textWidth = cellWidth - leftpadding * 2;
    
//    NSLog(@"颜色 %@",[TaskViewCell hexFromUIColor:[UIColor greenColor]]);
    
    UIColor* iconColor;
    NSString* iconName;
    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
        iconName = ICON_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
        iconName = ICON_DAI_WAN_CHENG;
    }
    
    self.iconText.attributedText = HTML_TO_TEXT(ConcatStrings(@"<font size='14' color='",[iconColor hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",iconName,@"</font>"));
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    NSString* codeInfo = @"TO1251616161       浙A199T19";
    NSMutableAttributedString* codeString =[[NSMutableAttributedString alloc]initWithString:codeInfo];
    [codeString addAttribute:NSForegroundColorAttributeName value:[UIColor flatBlackColor] range:NSMakeRange(0, codeInfo.length)];
    [codeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, codeInfo.length)];
    
    self.codeText.attributedText = codeString;
    
    CGSize codeSize = [self.codeText measure:CGSizeMake(textWidth, FLT_MAX)];
//    CGFloat desHeight = codeSize.height;
    
    NSString* countInfo = @"货量50箱       SO13个";
    NSMutableAttributedString* countString =[[NSMutableAttributedString alloc]initWithString:countInfo];
    [countString addAttribute:NSForegroundColorAttributeName value:[UIColor flatBlackColor] range:NSMakeRange(0, countInfo.length)];
    [countString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, countInfo.length)];
    
    self.shipUintCountText.attributedText = countString;
    CGSize countSize = [self.shipUintCountText measure:CGSizeMake(textWidth, FLT_MAX)];
    
    
//    NSString * htmlString = ConcatStrings(@"<font size='6' color='black' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='blue' size='4'>1h</font>");
    NSAttributedString * costString = [self generateCostString:@"18" hour:@"2.5" expense:@"320"];//HTML_TO_TEXT(htmlString);
    
//    NSString* costInfo = @"'图标'18km '图标'2.5h '图标'320";
//    NSMutableAttributedString* costString =[[NSMutableAttributedString alloc]initWithString:costInfo];
//    [costString addAttribute:NSForegroundColorAttributeName value:[UIColor flatBlackColor] range:NSMakeRange(0, costInfo.length)];
//    [costString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, costInfo.length)];
    self.costHourText.attributedText = costString;
//    self.costHourText.backgroundColor = [UIColor flatBrownColor];
    CGSize costSize = [self.costHourText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(cellHeight - iconSize.height) / 2.),iconSize};
    
    CGFloat textLeftpadding = leftpadding + iconSize.width + gap1;
    CGFloat textToppadding = (cellHeight - codeSize.height - gap1 - countSize.height) / 2.;
    
    self.codeText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding), codeSize };
    self.shipUintCountText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding + codeSize.height + gap1), countSize };
    
    self.costHourText.frame = (CGRect){CGPointMake(cellWidth - leftpadding - costSize.width, (cellHeight - costSize.height) / 2.), costSize };
    
//    self.rightArrow.frame = (CGRect){
//        CGPointMake(cellWidth - leftpadding - self.rightArrow.bounds.size.width,(cellHeight - self.rightArrow.bounds.size.height) / 2.),self.rightArrow.frame.size
//    };
    
    if (!self.isFirst) {//顶部加一根线
        self.lineNode.frame = CGRectMake(leftpadding, 0, cellWidth - leftpadding * 2, LINE_WIDTH);
    }
}

-(NSAttributedString *)generateCostString:(NSString*)distance hour:(NSString*)hour expense:(NSString*)expense{
    return HTML_TO_TEXT(ConcatStrings(@"<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JU_LI,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",distance,@"</font><font size='4' color='black'>Km</font></br><font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",hour,@"</font><font size='4' color='black'>h</font></br><font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JIN_QIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",expense,@"</font>"));
}

@end
