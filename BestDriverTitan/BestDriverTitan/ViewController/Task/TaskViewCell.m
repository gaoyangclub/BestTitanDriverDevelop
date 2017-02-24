//
//  TaskViewCell.m
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewCell.h"
#import "UIArrowView.h"
#import "RoundRectNode.h"
#import "DiyLicensePlateNode.h"

@interface TaskViewCell()

@property (nonatomic,retain)RoundRectNode* backView;

@property (nonatomic,retain) ASTextNode* codeText;//运单号
@property (nonatomic,retain) ASTextNode* licencePlateText;//车牌号
@property (nonatomic,retain) DiyLicensePlateNode* licencePlateView;//车牌背景图
@property (nonatomic,retain) ASTextNode* shipUintCountText;//货量
@property (nonatomic,retain) ASTextNode* shipUintCountLabel;//货量label
@property (nonatomic,retain) ASTextNode* soCountText;//so个数
@property (nonatomic,retain) ASTextNode* soCountLabel;//so个数label

//@property (nonatomic,retain) UIArrowView* rightArrow;
@property (nonatomic,retain) ASDisplayNode* lineTopY;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;
@property (nonatomic,retain) ASDisplayNode* lineCenterX;

@property (nonatomic,retain) ASTextNode* costHourText;//配送时间花费
@property (nonatomic,retain) ASTextNode* distanceText;//配送里程花费
@property (nonatomic,retain) ASTextNode* expenseText;//参考运费
@property (nonatomic,retain) ASTextNode* costHourLabel;//配送时间花费
@property (nonatomic,retain) ASTextNode* distanceLabel;//配送里程花费
@property (nonatomic,retain) ASTextNode* expenseLabel;//参考运费

@end


@implementation TaskViewCell


-(ASTextNode *)expenseLabel{
    if(!_expenseLabel){
        _expenseLabel = [[ASTextNode alloc]init];
        _expenseLabel.layerBacked = YES;
        [self.backView addSubnode:_expenseLabel];
    }
    return _expenseLabel;
}

-(ASTextNode *)expenseText{
    if(!_expenseText){
        _expenseText = [[ASTextNode alloc]init];
        _expenseText.layerBacked = YES;
        [self.backView addSubnode:_expenseText];
    }
    return _expenseText;
}

-(ASTextNode *)distanceLabel{
    if(!_distanceLabel){
        _distanceLabel = [[ASTextNode alloc]init];
        _distanceLabel.layerBacked = YES;
        [self.backView addSubnode:_distanceLabel];
    }
    return _distanceLabel;
}

-(ASTextNode *)distanceText{
    if(!_distanceText){
        _distanceText = [[ASTextNode alloc]init];
        _distanceText.layerBacked = YES;
        [self.backView addSubnode:_distanceText];
    }
    return _distanceText;
}

-(ASTextNode *)costHourLabel{
    if(!_costHourLabel){
        _costHourLabel = [[ASTextNode alloc]init];
        _costHourLabel.layerBacked = YES;
        [self.backView addSubnode:_costHourLabel];
    }
    return _costHourLabel;
}

-(ASTextNode *)costHourText{
    if(!_costHourText){
        _costHourText = [[ASTextNode alloc]init];
        _costHourText.layerBacked = YES;
        [self.backView addSubnode:_costHourText];
    }
    return _costHourText;
}

-(RoundRectNode *)backView{
    if (!_backView) {
        _backView = [[RoundRectNode alloc]init];
        _backView.fillColor = [UIColor whiteColor];
        _backView.cornerRadius = 5;
        _backView.layerBacked = YES;
        [self.contentView.layer addSublayer:_backView.layer];
    }
    return _backView;
}

-(DiyLicensePlateNode *)licencePlateView{
    if(!_licencePlateView){
        _licencePlateView = [[DiyLicensePlateNode alloc]init];
        _licencePlateView.layerBacked = YES;
        [self.contentView.layer addSublayer:_licencePlateView.layer];
    }
    return _licencePlateView;
}

//定义UI结构 利用AsyncDisplayKit的工具布局

-(ASDisplayNode *)lineTopY{
    if(!_lineTopY){
        _lineTopY = [[ASDisplayNode alloc]init];
        _lineTopY.backgroundColor = COLOR_LINE;
        _lineTopY.layerBacked = YES;
        [self.backView addSubnode:_lineTopY];
    }
    return _lineTopY;
}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.backView addSubnode:_lineBottomY];
    }
    return _lineBottomY;
}

-(ASDisplayNode *)lineCenterX{
    if(!_lineCenterX){
        _lineCenterX = [[ASDisplayNode alloc]init];
        _lineCenterX.backgroundColor = COLOR_LINE;
        _lineCenterX.layerBacked = YES;
        [self.backView addSubnode:_lineCenterX];
    }
    return _lineCenterX;
}

//-(UIArrowView *)rightArrow{
//    if(!_rightArrow){
//        _rightArrow = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
//        _rightArrow.direction = ArrowDirectRight;
//        _rightArrow.lineColor = COLOR_LINE;
//        _rightArrow.lineThinkness = 2;
//        [self.contentView addSubview:_rightArrow];
//    }
//    return _rightArrow;
//}

-(ASTextNode *)soCountText{
    if(!_soCountText){
        _soCountText = [[ASTextNode alloc]init];
        _soCountText.layerBacked = YES;
        [self.backView addSubnode:_soCountText];
    }
    return _soCountText;
}

-(ASTextNode *)soCountLabel{
    if(!_soCountLabel){
        _soCountLabel = [[ASTextNode alloc]init];
        _soCountLabel.layerBacked = YES;
        [self.backView addSubnode:_soCountLabel];
    }
    return _soCountLabel;
}

-(ASTextNode *)codeText{
    if(!_codeText){
        _codeText = [[ASTextNode alloc]init];
        _codeText.layerBacked = YES;
//                _codeText.textColor = [UIColor whiteColor];
        //        _titleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        //        _titleView.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubnode:_codeText];
    }
    return _codeText;
}

-(ASTextNode *)shipUintCountText{
    if(!_shipUintCountText){
        _shipUintCountText = [[ASTextNode alloc]init];
        _shipUintCountText.layerBacked = YES;
        [self.backView addSubnode:_shipUintCountText];
    }
    return _shipUintCountText;
}

-(ASTextNode *)shipUintCountLabel{
    if(!_shipUintCountLabel){
        _shipUintCountLabel = [[ASTextNode alloc]init];
        _shipUintCountLabel.layerBacked = YES;
        [self.backView addSubnode:_shipUintCountLabel];
    }
    return _shipUintCountLabel;
}

-(ASTextNode *)licencePlateText{
    if(!_licencePlateText){
        _licencePlateText = [[ASTextNode alloc]init];
        _licencePlateText.layerBacked = YES;
//        [self.contentView.layer addSublayer:_licencePlateText.layer];
        [self.licencePlateView addSubnode:_licencePlateText];
    }
    return _licencePlateText;
}

-(void)initTopArea:(CGFloat)topY topWidth:(CGFloat)topWidth topHeight:(CGFloat)topHeight{
    CGFloat topCenterY = topY + topHeight / 2.;
    CGFloat labelOffset = -20;
    CGFloat textOffset = 0;
    CGFloat areaWith = topWidth / 3.;
    
    CGFloat areaX1 = 0;
    self.expenseLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark] size:12 context:ConcatStrings(ICON_JIN_QIAN,@"预计收入")];
    CGSize expenseSize = [self.expenseLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.expenseLabel.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - expenseSize.width) / 2., topCenterY + labelOffset),expenseSize
    };
    self.expenseText.attributedString = [NSString simpleAttributedString:[UIColor flatOrangeColor] size:14 context:@"15元"];
    expenseSize = [self.expenseText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.expenseText.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - expenseSize.width) / 2., topCenterY + textOffset),expenseSize
    };
    
    CGFloat areaX2 = areaWith;
    self.distanceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark]     size:12 context:ConcatStrings(ICON_JU_LI,@"预计距离")];
    CGSize distanceSize = [self.distanceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.distanceLabel.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - distanceSize.width) / 2., topCenterY + labelOffset),distanceSize
    };
    self.distanceText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 context:@"1.7公里"];
    distanceSize = [self.distanceText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.distanceText.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - distanceSize.width) / 2., topCenterY + textOffset),distanceSize
    };
    
    CGFloat areaX3 = areaWith * 2;
    self.costHourLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark]     size:12 context:ConcatStrings(ICON_SHI_JIAN,@"预计时间")];
    CGSize hourSize = [self.costHourLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.costHourLabel.frame = (CGRect){
        CGPointMake(areaX3 + (areaWith - hourSize.width) / 2., topCenterY + labelOffset),hourSize
    };
    self.costHourText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 context:@"2.5小时"];
    hourSize = [self.costHourText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.costHourText.frame = (CGRect){
        CGPointMake(areaX3 + (areaWith - hourSize.width) / 2., topCenterY + textOffset),hourSize
    };
}

-(void)initCenterArea:(CGFloat)centerY centerWidth:(CGFloat)centerWidth centerHeight:(CGFloat)centerHeight{
    CGFloat topCenterY = centerY + centerHeight / 2.;
    CGFloat areaWith = centerWidth / 2.;
    CGFloat labelOffset = 10;
    CGFloat textOffset = -30;
    
    CGFloat areaX1 = 0;
    
    UIColor* iconColor;
    int count = (arc4random() % 3); //生成0-2范围的随机数
    if (count > 0) {
        //    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    
    self.soCountText.attributedString = [NSString simpleAttributedString:iconColor size:30 context:@"8"];
    CGSize soSize = [self.soCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.soCountText.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - soSize.width) / 2., topCenterY + textOffset),soSize
    };
    self.soCountLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:12 context:@"订单个数"];
    soSize = [self.soCountLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.soCountLabel.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - soSize.width) / 2., topCenterY + labelOffset),soSize
    };
    
    CGFloat areaX2 = areaWith;
    self.shipUintCountText.attributedString = [NSString simpleAttributedString:iconColor size:30 context:@"50"];
    CGSize shipSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.shipUintCountText.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - shipSize.width) / 2., topCenterY + textOffset),shipSize
    };
    self.shipUintCountLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:12 context:@"提送货量(箱)"];
    shipSize = [self.shipUintCountLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.shipUintCountLabel.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - shipSize.width) / 2., topCenterY + labelOffset),shipSize
    };
}

-(void)showSubviews{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
//    CGFloat gap = 1;
    
    CGFloat leftMargin = 10;
    CGFloat topMargin = 5;
    
    CGFloat backWidth = cellWidth - leftMargin * 2;
    CGFloat backHeight = cellHeight - topMargin * 2;
    
    CGFloat padding = 5;//内边距10
    
    CGFloat topHeight = 50;
    CGFloat bottomHeight = 30;
    
    CGFloat topY = 25;
    CGFloat centerY = topY + topHeight;
    
    CGFloat centerHeight = backHeight - topY - topHeight - bottomHeight;
    
    self.backView.frame = CGRectMake(leftMargin, topMargin, backWidth, backHeight);
    
    self.lineTopY.frame = CGRectMake(padding, topY + topHeight, backWidth - padding * 2, LINE_WIDTH);
    self.lineBottomY.frame = CGRectMake(padding, topY + topHeight + centerHeight, backWidth - padding * 2, LINE_WIDTH);
    
    
    self.lineCenterX.frame = CGRectMake((backWidth - LINE_WIDTH) / 2., centerY + padding, LINE_WIDTH, centerHeight - padding * 2);
    
    [self initTopArea:topY topWidth:backWidth topHeight:topHeight];
    [self initCenterArea:centerY centerWidth:backWidth centerHeight:centerHeight];
    
    self.codeText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:16 context:@"TO1251616161"];
    CGSize codeSize = [self.codeText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.codeText.frame = (CGRect){ CGPointMake(padding * 2, padding), codeSize };
    
    self.licencePlateText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 context:@"浙A8888888"];
    CGSize liceneSize = [self.licencePlateText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat plateWidth = liceneSize.width + 25;
    CGFloat plateHeight = liceneSize.height + 10;
    self.licencePlateView.frame = CGRectMake(cellWidth - leftMargin - plateWidth, 0, plateWidth, plateHeight);
    self.licencePlateView.fillColor = [UIColor flatYellowColorDark];
//    self.licencePlateView.compleColor = [UIColor flatBlackColor];
    
    self.licencePlateText.frame = (CGRect){
        CGPointMake((self.licencePlateView.frame.size.width - liceneSize.width) / 2., (self.licencePlateView.frame.size.height - liceneSize.height) / 2.),
        liceneSize
    };
    
////    NSLog(@"颜色 %@",[TaskViewCell hexFromUIColor:[UIColor greenColor]]);
//    

//    

//    
//    self.shipUintCountText.attributedString = [NSString simpleAttributedString:[UIColor flatCoffeeColorDark] size:14 context:@"货量50箱"];
//    CGSize countSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    self.soCountText.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:14 context:@"SO100个"];
//    
//    CGSize soSize = [self.soCountText measure:CGSizeMake(cellWidth, cellHeight)];
//    
//    CGFloat textLeftpadding = leftpadding + 5;// + iconSize.width
//    CGFloat textToppadding = (cellHeight - codeSize.height - countSize.height - soSize.height  - gap * 2) / 2.;
//    

//    
//    self.shipUintCountText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding + codeSize.height + gap), countSize };
//    self.soCountText.frame = (CGRect){ CGPointMake(textLeftpadding, self.shipUintCountText.frame.origin.y + countSize.height + gap), soSize };
//
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        NSAttributedString* iconString = SimpleHtmlTextFace(ICON_FONT_NAME,iconColor,@"14",iconName);
////        NSAttributedString* codeString = SimpleHtmlText([UIColor flatBlackColor], @"4", @"TO1251616161");
////        NSAttributedString* liceneString = SimpleHtmlText([UIColor flatWhiteColor],@"4",@"浙A8888888");
////        NSAttributedString* countString = SimpleHtmlText([UIColor flatCoffeeColorDark],@"4",@"货量50箱");
////        NSAttributedString* soString = SimpleHtmlText([UIColor flatGrayColorDark],@"4",@"SO100个");
//        NSAttributedString * costString = [self generateCostString:@"18" hour:@"2.5" expense:@"320"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.costHourText.attributedString = costString;
//            CGSize costSize = [self.costHourText measure:CGSizeMake(cellWidth, cellHeight)];
//            
//            
//            self.costHourText.frame = (CGRect){CGPointMake(cellWidth - leftpadding - costSize.width, self.soCountText.frame.origin.y + countSize.height - costSize.height), costSize };
//        });
//    });
//    
////    if (!self.isFirst) {//顶部加一根线
//        self.lineNode.frame = CGRectMake(leftpadding, cellHeight - LINE_WIDTH, cellWidth - leftpadding * 2, LINE_WIDTH);
////    }
}

-(NSAttributedString *)generateCostString:(NSString*)distance hour:(NSString*)hour expense:(NSString*)expense{
    return HtmlToText(ConcatStrings(@"<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JU_LI,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",distance,@"</font><font size='4' color='black'>Km</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",hour,@"</font><font size='4' color='black'>h</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JIN_QIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",expense,@"</font>"));
}

@end
