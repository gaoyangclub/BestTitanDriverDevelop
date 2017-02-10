//
//  UIColor+HexExchange.h
//  BestDriverTitan
//
//  Created by admin on 17/2/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexExchange)

-(NSString *) hexFromUIColor;

+(UIColor *) colorWithHexString: (NSString *) hexString;

@end
