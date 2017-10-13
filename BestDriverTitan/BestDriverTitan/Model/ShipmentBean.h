//
//  ShipmentBean.h
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipmentBean : NSObject

//@property(nonatomic,assign)int factor1;
//@property(nonatomic,assign)int factor2;
//@property(nonatomic,assign)int factor3;
//@property(nonatomic,assign)int pickupCount;
//@property(nonatomic,assign)int deliverCount;
//@property(nonatomic,assign)BOOL isComplete;
@property(nonatomic,assign)BOOL isFollow;
//@property(nonatomic,retain)NSDate* dateTime;

@property(nonatomic,assign)long id;
@property(nonatomic,copy)NSString* code;
@property(nonatomic,copy)NSString* licencePlate;

//@property(nonatomic,copy)NSString* costHour;// 运单规划行驶时间
//@property(nonatomic,copy)NSString* distance;// 运单规划行驶距离
//@property(nonatomic,copy)NSString* expense;// 参考运费
@property(nonatomic,assign)double costHour;// 运单规划行驶时间
@property(nonatomic,assign)double distance;// 运单规划行驶距离
@property(nonatomic,assign)long expense;// 参考运费
@property(nonatomic,copy)NSString* accountDriverType;// 对账主体类型
@property(nonatomic,copy)NSString* status;
@property(nonatomic,assign)CGFloat ordermovementCt;//订单数
@property(nonatomic,copy)NSString* sourceLocationAddress;//起点地点
@property(nonatomic,copy)NSString* destLocationAddress;//终点地点

//@JsonProperty("dateTime")
@property(nonatomic,assign)double dateTime; //最后更新时间时间戳 坑!!! 4s是32位的long 5以后是64位的 所以取double
@property(nonatomic,retain)NSDate* date; //dateTime 转换的时间

-(BOOL)isComplete;
-(BOOL)canShowMoney;//显示 行驶时间 里程数 运费

@end
