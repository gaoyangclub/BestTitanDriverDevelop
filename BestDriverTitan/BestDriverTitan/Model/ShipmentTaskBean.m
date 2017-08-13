//
//  ShipmentTaskBean.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentTaskBean.h"

@implementation ShipmentTaskBean


-(NSMutableArray<PhotoAlbumVo*> *)assetsArray{
    if (!_assetsArray) {
        _assetsArray = [[NSMutableArray<PhotoAlbumVo*> alloc]init];
    }
    return _assetsArray;
}


@end
