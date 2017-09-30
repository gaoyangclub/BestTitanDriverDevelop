//
//  ShipmentTaskBean.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoTranslateUtils.h"
#import "ContactBean.h"
#import "ShipmentActivityShipUnitBean.h"

@interface ShipmentTaskBean : NSObject

@property(nonatomic,assign) long id;
@property(nonatomic,retain) NSMutableArray<PhotoAlbumVo*>* assetsArray; // 图片信息//暂时保存

@property(nonatomic,copy) NSString* activityDefinitionCode;//活动编码 'PICKUP_HANDOVER', ' LOAD', ' UNLOAD', ' SIGN_FOR_RECEIPT', ' DELIVERY_RECEIPT'

@property(nonatomic,copy) NSString* status;//完成未完成等 'PENDING_REPORT', ' REPORTING', ' REPORTED', ' CANCELED'

@property(nonatomic,copy) NSString* remark;//备注 临时暂存
@property(nonatomic,copy) NSString* orderBaseId;//订单Id
@property(nonatomic,copy) NSString* orderBaseCode;//订单号
@property(nonatomic,copy) NSString* customCode;//客户单号
@property(nonatomic,copy) NSString* expectedPackageCount;//预计提(送)货量

@property(nonatomic,retain) NSMutableArray<ShipmentActivityShipUnitBean*>* shipUnits;//运输单元列表

//@property(nonatomic,retain)NSMutableArray<ShipmentActivityParameter*>* shipmentActivityParameterList;//金额等相关信息

@property(nonatomic,assign) BOOL isCashPaid;//是否现金已结
@property(nonatomic,copy) NSString* taskOrderTime;//运单创建时间
@property(nonatomic,copy) NSString* address;//详细地址

@property(nonatomic,retain) NSMutableArray<ContactBean*>* contactList;//联系人列表

@property(nonatomic,copy) NSString* shipmentArriveTime;//到达时间

@property(nonatomic,assign) NSInteger actualPackageCount;//实际填入包装数

-(NSString*)getStatusName;

-(BOOL)hasReport;

-(NSInteger)getActualTotalPackageCount;

@end
