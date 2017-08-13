//
//  ShipmentTaskBean.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoTranslateUtils.h"

@interface ShipmentTaskBean : NSObject

@property(nonatomic,assign)long id;
@property(nonatomic,retain) NSMutableArray<PhotoAlbumVo*>* assetsArray;

@end
