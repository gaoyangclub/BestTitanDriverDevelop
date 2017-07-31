//
//  AppVersion.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersion : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* version;//版本号
@property(nonatomic,copy)NSString* code;//编码
@property(nonatomic,copy)NSString* downloadUrl;//下载地址
@property(nonatomic,assign)CGFloat gpsIntervalTime;//GPS定位间隔时间 单位(秒) 默认5秒
@property(nonatomic,assign)CGFloat gpsIgnoreRadius;//司机app获取经纬度忽略半径 单位(米) 默认0.5

//@JsonProperty("bankVersionCode")
//public int bankVersionCode;//交行的版本号
//@JsonProperty("bankDownloadUrl")
//public String bankDownloadUrl;//交行的app地址
//@JsonProperty("apkPatchUrl")
//public String apkPatchUrl;  //补丁下载地址
//@JsonProperty("logoutPassword")
//public String logoutPassword;//退出pos机密码

@end
