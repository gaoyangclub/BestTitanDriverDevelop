//
//  ShipmentActivityShipUnitBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentActivityShipUnitBean.h"

@interface ShipmentActivityShipUnitBean(){
    NSInteger sourcePacakageUnitCount;
    NSString* sourceActualReceivedWeight;//重量 精确6位小数
    NSString* sourceActualReceivedVolume;//体积 精确6位小数
    NSInteger sourceItemCount;//内件数量
}

@end

@implementation ShipmentActivityShipUnitBean

- (id)copyWithZone:(NSZone *)zone {
    
    ShipmentActivityShipUnitBean *bean = [[[self class] allocWithZone:zone] init];
    bean.itemName = self.itemName;
    bean.pacakageUnitCount = self.pacakageUnitCount;
    bean.actualReceivedWeight = self.actualReceivedWeight;
    bean.actualReceivedVolume = self.actualReceivedVolume;
    bean.packageStandard = self.packageStandard;
    bean.itemCount = self.itemCount;
    
    return bean;
}

-(void)setPacakageUnitCount:(NSInteger)pacakageUnitCount{
    self->_pacakageUnitCount = self->sourcePacakageUnitCount = pacakageUnitCount;
}

-(void)setActualReceivedWeight:(NSString *)actualReceivedWeight{
    self->_actualReceivedWeight = self->sourceActualReceivedWeight = actualReceivedWeight;
}

-(void)setActualReceivedVolume:(NSString *)actualReceivedVolume{
    self->_actualReceivedVolume = self->sourceActualReceivedVolume = actualReceivedVolume;
}

-(void)setItemCount:(NSInteger)itemCount{
    self->_itemCount = self->sourceItemCount = itemCount;
}

-(void)changeEditValue:(NSInteger)pacakageUnitCount actualReceivedWeight:(NSString *)actualReceivedWeight actualReceivedVolume:(NSString *)actualReceivedVolume itemCount:(NSInteger)itemCount{
    self->_pacakageUnitCount = pacakageUnitCount;
    self->_actualReceivedWeight = actualReceivedWeight;
    self->_actualReceivedVolume = actualReceivedVolume;
    self->_itemCount = itemCount;
}

-(BOOL)isEdited{
    return self->_pacakageUnitCount != self->sourcePacakageUnitCount || self->_itemCount != self->sourceItemCount ||
        ![self->_actualReceivedWeight isEqual:self->sourceActualReceivedWeight] ||
    ![self->_actualReceivedVolume isEqual:self->sourceActualReceivedVolume];
}

@end
