//
//  ShipmentActivityShipUnitBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipmentActivityShipUnitBean : NSObject<NSCopying>

//@property(nonatomic,assign) BOOL isEdited;

@property(nonatomic,assign) long id;
@property(nonatomic,copy) NSString* itemName;//货物名称

@property(nonatomic,assign) NSInteger pacakageUnitCount;//包装数量
@property(nonatomic,copy) NSString* actualReceivedWeight;//重量 精确6位小数
@property(nonatomic,copy) NSString* actualReceivedVolume;//体积 精确6位小数
@property(nonatomic,assign) NSInteger itemCount;//内件数量

@property(nonatomic,assign) NSInteger orgPacakageUnitCount;//下单包装数量 ,
@property(nonatomic,copy) NSString* orgWeight;//下单重量 ,
@property(nonatomic,copy) NSString* orgVolume;//下单体积 ,
@property(nonatomic,assign) NSInteger orgItemCount;//下单内件数量 ,

@property(nonatomic,copy) NSString* packageStandard;//包装规格
@property(nonatomic,assign) double declaredPrice;//货物单价

@end
