//
//  ASDisplayNode+GY.m
//  BestDriverTitan
//
//  Created by admin on 17/2/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ASDisplayNode+GY.h"

@implementation ASDisplayNode (GY)

-(void)removeAllSubNodes{
    for (ASDisplayNode* subNode in self.subnodes) {//子对象全部移除干净
        [subNode removeFromSupernode];
    }
}

@end
