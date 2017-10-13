//
//  MessageViewSection.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MJTableViewSection.h"

@interface MessageViewSectionVo : NSObject

//@property(nonatomic,assign)BOOL isRead;//消息已读 默认未读
@property(nonatomic,retain)NSDate* dateTime;

@end

@interface MessageViewSection : MJTableViewSection

@end
