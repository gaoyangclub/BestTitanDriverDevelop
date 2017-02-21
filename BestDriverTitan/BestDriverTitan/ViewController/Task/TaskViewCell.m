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

@property (nonatomic,retain) ASTextNode* codeText;//运单号
@property (nonatomic,retain) ASTextNode* licencePlateText;//车牌号
@property (nonatomic,retain) DiyLicensePlateNode* licencePlateView;//车牌背景图
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


-(DiyLicensePlateNode *)licencePlateView{
    if(!_licencePlateView){
        _licencePlateView = [[DiyLicensePlateNode alloc]init];
        _licencePlateView.layerBacked = YES;
        [self.contentView.layer addSublayer:_licencePlateView.layer];
    }
    return _licencePlateView;
}

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

-(ASTextNode *)soCountText{
    if(!_soCountText){
        _soCountText = [[ASTextNode alloc]init];
        _soCountText.layerBacked = YES;
        [self.contentView.layer addSublayer:_soCountText.layer];
    }
    return _soCountText;
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
        _licencePlateText = [[ASTextNode alloc]init];
        _licencePlateText.layerBacked = YES;
//        [self.contentView.layer addSublayer:_licencePlateText.layer];
        [self.licencePlateView addSubnode:_licencePlateText];
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
    CGFloat gap = 1;
//    CGFloat gap2 = 0;
    CGFloat cellWidth = self.contentView.bounds.size.width;
    CGFloat cellHeight = self.contentView.bounds.size.height;
//    CGFloat textWidth = cellWidth - leftpadding * 2;
    
//    NSLog(@"颜色 %@",[TaskViewCell hexFromUIColor:[UIColor greenColor]]);
    
    UIColor* iconColor;
    NSString* iconName;
    
    int count = (arc4random() % 3); //生成0-2范围的随机数
    if (count > 0) {
//    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
        iconName = ICON_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
        iconName = ICON_DAI_WAN_CHENG;
    }
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:46 context:iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(cellHeight - iconSize.height) / 2.),iconSize};
    
    self.codeText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 context:@"TO1251616161"];
    CGSize codeSize = [self.codeText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.licencePlateText.attributedString = [NSString simpleAttributedString:[UIColor flatWhiteColor] size:14 context:@"浙A8888888"];
    CGSize liceneSize = [self.licencePlateText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.shipUintCountText.attributedString = [NSString simpleAttributedString:[UIColor flatCoffeeColorDark] size:14 context:@"货量50箱"];
    CGSize countSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.soCountText.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:14 context:@"SO100个"];
    
    CGSize soSize = [self.soCountText measure:CGSizeMake(cellWidth, cellHeight)];
    
    CGFloat textLeftpadding = leftpadding + iconSize.width + 5;
    CGFloat textToppadding = (cellHeight - codeSize.height - countSize.height - soSize.height  - gap * 2) / 2.;
    
    self.codeText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding), codeSize };
    
    self.shipUintCountText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding + codeSize.height + gap), countSize };
    self.soCountText.frame = (CGRect){ CGPointMake(textLeftpadding, self.shipUintCountText.frame.origin.y + countSize.height + gap), soSize };
    
    CGFloat plateWidth = liceneSize.width + 25;
    CGFloat plateHeight = liceneSize.height + 10;
    
    self.licencePlateView.frame = CGRectMake(cellWidth - leftpadding - plateWidth, textToppadding, plateWidth, plateHeight);
    self.licencePlateView.fillColor = [UIColor flatSkyBlueColor];
    
    self.licencePlateText.frame = (CGRect){
        CGPointMake((self.licencePlateView.frame.size.width - liceneSize.width) / 2., (self.licencePlateView.frame.size.height - liceneSize.height) / 2.),
        liceneSize
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSAttributedString* iconString = SimpleHtmlTextFace(ICON_FONT_NAME,iconColor,@"14",iconName);
//        NSAttributedString* codeString = SimpleHtmlText([UIColor flatBlackColor], @"4", @"TO1251616161");
//        NSAttributedString* liceneString = SimpleHtmlText([UIColor flatWhiteColor],@"4",@"浙A8888888");
//        NSAttributedString* countString = SimpleHtmlText([UIColor flatCoffeeColorDark],@"4",@"货量50箱");
//        NSAttributedString* soString = SimpleHtmlText([UIColor flatGrayColorDark],@"4",@"SO100个");
        NSAttributedString * costString = [self generateCostString:@"18" hour:@"2.5" expense:@"320"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.costHourText.attributedString = costString;
            CGSize costSize = [self.costHourText measure:CGSizeMake(cellWidth, cellHeight)];
            
            
            self.costHourText.frame = (CGRect){CGPointMake(cellWidth - leftpadding - costSize.width, self.soCountText.frame.origin.y + countSize.height - costSize.height), costSize };
        });
    });
    
    if (!self.isFirst) {//顶部加一根线
        self.lineNode.frame = CGRectMake(leftpadding, 0, cellWidth - leftpadding * 2, LINE_WIDTH);
    }
}

-(NSAttributedString *)generateCostString:(NSString*)distance hour:(NSString*)hour expense:(NSString*)expense{
    return HtmlToText(ConcatStrings(@"<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JU_LI,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",distance,@"</font><font size='4' color='black'>Km</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",hour,@"</font><font size='4' color='black'>h</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JIN_QIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",expense,@"</font>"));
}

@end
