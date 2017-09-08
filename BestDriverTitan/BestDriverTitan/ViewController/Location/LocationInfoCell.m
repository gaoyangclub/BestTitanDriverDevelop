//
//  LocationInfoCell.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LocationInfoCell.h"
#import "AmapLocationService.h"

@interface LocationInfoCell()

@property(nonatomic,retain)ASTextNode* dateNode;
@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)ASDisplayNode* bottomLine;

@end


@implementation LocationInfoCell


-(ASTextNode *)dateNode{
    if (!_dateNode) {
        _dateNode = [[ASTextNode alloc]init];
        _dateNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_dateNode.layer];
    }
    return _dateNode;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
//        _titleNode.maximumNumberOfLines = 1;//最多一行
//        _titleNode.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASDisplayNode *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[ASDisplayNode alloc]init];
        _bottomLine.layerBacked = YES;
        _bottomLine.backgroundColor = COLOR_LINE;
        [self.contentView.layer addSublayer:_bottomLine.layer];
    }
    return _bottomLine;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    LocationInfo* info = self.data;
    
    CGFloat leftMargin = 10;
    
    if (info.dateString) {
        self.dateNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:info.dateString];
        self.dateNode.size = [self.dateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize timeSize =
        self.dateNode.x = leftMargin;
        self.dateNode.maxY = self.contentView.centerY;
    }else{
        self.dateNode.attributedString = nil;
    }
    
    CLLocationCoordinate2D locationPoint = info.locationPoint.MKCoordinateValue;
    
    NSString* titleString;
    UIColor* color;
    if (info.markType == LocationMarkTypePoint) {
        titleString = ConcatStrings(@"纬度:",@(locationPoint.latitude),@"  经度:",@(locationPoint.longitude));
        color = FlatGrayDark;
    }else if(info.markType == LocationMarkTypeInfo){
        titleString = info.markInfo;
        color = COLOR_BLACK_ORIGINAL;
    }else if(info.markType == LocationMarkTypeDebug){
        titleString = info.markInfo;
        color = FlatGreen;
    }else if(info.markType == LocationMarkTypeWarn){
        titleString = info.markInfo;
        color = FlatYellowDark;
    }else if(info.markType == LocationMarkTypeError){
        titleString = info.markInfo;
        color = FlatWatermelon;
    }
    self.titleNode.attributedString = [NSString simpleAttributedString:color size:12 content:titleString];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize timeSize =
    self.titleNode.x = leftMargin;
    self.titleNode.y = self.contentView.centerY;
    
    self.bottomLine.frame = CGRectMake(leftMargin, self.contentView.height - LINE_WIDTH, self.contentView.width - leftMargin * 2, LINE_WIDTH);
    
    
}


@end
