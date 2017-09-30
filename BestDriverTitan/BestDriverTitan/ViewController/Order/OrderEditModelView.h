//
//  OrderEditModelView.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopModelView.h"
#import "ShipmentActivityShipUnitBean.h"

@protocol OrderEditModelDelegate <NSObject>
@optional
-(void)orderEdited:(NSIndexPath*)indexPath;//确认编辑
@optional
-(void)orderCanceled:(NSIndexPath*)indexPath;//取消编辑
@end

@interface OrderEditModelView : CustomPopModelView

@property(nonatomic,retain) NSIndexPath* shipUnitIndexPath;
@property(nonatomic,retain) ShipmentActivityShipUnitBean* shipUnitBean;

@property(nonatomic, weak) id<OrderEditModelDelegate> delegate;

@end
