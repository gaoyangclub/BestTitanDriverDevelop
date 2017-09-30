//
//  TaskViewSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewSection.h"
#import "DateUtils.h"

@implementation TaskViewSectionVo

@end

@interface TaskViewSection(){
    
}

@property(nonatomic,retain)ASDisplayNode* square;

@property(nonatomic,retain)ASTextNode* title;

//@property (nonatomic,retain) ASDisplayNode* lineTopY;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;

//@property(nonatomic,retain)ASTextNode* desLabel;

//@property (nonatomic,retain)ASTextNode* iconText;//未完成已完成状态图标

@end

@implementation TaskViewSection

-(ASDisplayNode *)square{
    if (!_square) {
        _square = [[ASDisplayNode alloc]init];
        _square.backgroundColor = FlatOrange;
        _square.layerBacked = YES;
        [self.layer addSublayer:_square.layer];
    }
    return _square;
}

//-(ASTextNode *)desLabel{
//    if (!_desLabel) {
//        _desLabel = [[ASTextNode alloc]init];
//        _desLabel.layerBacked = YES;
//        [self.square addSubnode:_desLabel];
//    }
//    return _desLabel;
//}

-(ASTextNode *)title{
    if (!_title) {
        _title = [[ASTextNode alloc]init];
        _title.layerBacked = YES;
        [self.layer addSublayer:_title.layer];
    }
    return _title;
}

//-(ASTextNode *)iconText{
//    if(!_iconText){
//        _iconText = [[ASTextNode alloc]init];
//        _iconText.layerBacked = YES;
//        //        _iconText.backgroundColor = [UIColor flatBrownColor];
//        [self.square addSubnode:_iconText];
//    }
//    return _iconText;
//}

//-(ASDisplayNode *)lineTopY{
//    if(!_lineTopY){
//        _lineTopY = [[ASDisplayNode alloc]init];
//        _lineTopY.backgroundColor = COLOR_LINE;
//        _lineTopY.layerBacked = YES;
//        [self.layer addSublayer:_lineTopY.layer];
//    }
//    return _lineTopY;
//}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.layer addSublayer:_lineBottomY.layer];
    }
    return _lineBottomY;
}

-(void)layoutSubviews{
    TaskViewSectionVo* hvo = self.data;
    if(!hvo){
        return;
    }
    
    self.backgroundColor = COLOR_BACKGROUND;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
//    CGFloat topMargin = 5;
//    CGFloat squareHeight = sectionHeight - topMargin;
    
    CGFloat leftpadding = 10;
    
    UIColor* iconColor;
    NSString* iconName;
    
//    int count = (arc4random() % 3); //生成0-2范围的随机数
    if (hvo.isComplete) {
        //    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
        iconName = ICON_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
        iconName = ICON_DAI_WAN_CHENG;
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//"yyyy-MM-dd HH:mm:ss"
    NSString* timeContent = [dateFormatter stringFromDate:hvo.dateTime];
    NSString* timeUTCName = [DateUtils getUTCFormateName:hvo.dateTime];
    if (timeUTCName) {
        timeContent = ConcatStrings(timeUTCName,@"(",timeContent,@")");
    }
    
    CGFloat squareHeight = sectionHeight - 8;
    self.square.frame = CGRectMake(0,(sectionHeight - squareHeight) / 2., 2, squareHeight);
//    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:24 content:iconName];
//    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconSize.height) / 2. + 2),iconSize};
    
    self.title.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:timeContent];
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(10, (sectionHeight - titleSize.height) / 2.),titleSize};
    
//    self.desLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:ConcatStrings(@"运单",[NSString stringWithFormat:@"%lu",(unsigned long)hvo.toCount],@"个")];
//    CGSize desSize = [self.desLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.desLabel.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 5, sectionHeight / 2. + 2),desSize};
    
    
//    self.lineTopY.frame = CGRectMake(0, 0, sectionWidth, LINE_WIDTH);
    self.lineBottomY.frame = CGRectMake(0, sectionHeight - LINE_WIDTH, sectionWidth, LINE_WIDTH);
    
}

@end
