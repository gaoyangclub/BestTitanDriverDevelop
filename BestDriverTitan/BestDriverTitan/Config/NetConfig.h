//
//  NetConfig.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

@class NetConfig;

#define SERVER_REST_POSTFIX @"/ti-rest-war/api/"
#define SERVER_DOWNLOAD_HTML @"/download/downloadApp.html"

#define SERVER_URL_PERSON_YAN @"http://10.45.25.227:8080"//IP 颜wj
#define SERVER_URL_PERSON_ZHOU @"http://10.45.24.104:80"//IP 周q
#define SERVER_URL_PERSON_LIU @"http://bg229565.800best.net:8081"//IP 刘z
#define SERVER_URL_PERSON_ZHU @"http://bl02777.800best.net:8089"//IP 朱jd
#define SERVER_URL_PERSON_WANG @"http://bg246069.800best.net:8080"//IP 王sj
#define SERVER_URL_PERSON_GAO @"http://bl04696.800best.net"//IP 高y
#define SERVER_URL_PERSON_GUO @"http://bg309729.800best.net"//IP 郭lq
#define SERVER_URL_PERSON_ZHENG @"http://10.45.16.83:8080"//IP 郑xx
#define SERVER_URL_DEMO @"http://t8demo.800best.com"//demo
#define SERVER_URL_TEST @"https://t8test.800best.com"//测试环境
#define SERVER_URL_UAT @"http://t8uat.800best.com"//外网访问 UAT
#define SERVER_URL_RELEASE @"http://t8.800best.com"//生产环境
#define SERVER_URL_RELEASE_T9 @"http://t9.800best.com"//T9生产环境

#define NET_MODE [NetConfig getCurrentNetMode]

#define SERVER_DRIVER_URL [NetConfig getDriverNetUrl:NET_MODE]

//#define SERVER_DOWNLOAD_URL [NetConfig getDownloadHtmlUrl:NET_MODE]

#define AUTH_CODE_URL(phone,isadmin) ConcatStrings(SERVER_DRIVER_URL,@"token/driver/authcode/",phone,@"/",isadmin)
#define CHECK_VERSION_URL ConcatStrings(SERVER_DRIVER_URL,@"version/detail/ios")
#define LOGIN_URL(phone,authcode) ConcatStrings(SERVER_DRIVER_URL,@"token/driver/",phone,@"/",authcode)
#define HEART_BEAT_URL ConcatStrings(SERVER_DRIVER_URL,@"shipment/heartbeat")

//获取运单列表
#define SHIPMENT_RECENT_URL ConcatStrings(SERVER_DRIVER_URL,@"shipment/list/recent")
//获取停靠站列表
#define SHIPMENT_STOP_URL(shipmentId) ConcatStrings(SERVER_DRIVER_URL,@"shipment/list/stop/",@(shipmentId))
//单独获取运费
#define SHIPMENT_RATE_URL(shipmentId) ConcatStrings(SERVER_DRIVER_URL,@"shipment/list/rate/",@(shipmentId))
//获取活动任务详情
#define TASK_ACTIVITY_URL(shipmentActivityId) ConcatStrings(SERVER_DRIVER_URL,@"shipment/task/",@(shipmentActivityId))
//上报货量活动
#define TASK_SUBMIT_URL ConcatStrings(SERVER_DRIVER_URL,@"shipment/task")
//上传回单(图片)
#define TASK_RECEIPT_URL(shipmentActivityTaskId) ConcatStrings(SERVER_DRIVER_URL,@"shipment/receipt/",@(shipmentActivityTaskId))

#define PGY_VERSION_GROUP_URL @"http://www.pgyer.com/apiv1/app/viewGroup"


typedef NS_ENUM(NSInteger,NetModeType) {
    NetModeTypePersonYan = 1,
    NetModeTypePersonZhou = 7,
    NetModeTypePersonLiu = 8,
    NetModeTypePersonWang = 9,
    NetModeTypePersonZhu = 10,
    NetModeTypePersonZheng = 11,
    NetModeTypePersonGuo = 12,
    NetModeTypePersonGao = 13,
    NetModeTypeDemo = 6,
    NetModeTypeUat = 3,
    NetModeTypeTest = 2,
    NetModeTypeRelease = 5,
    NetModeTypeReleaseT9 = 101
};

@interface NetConfig : NSObject

+(NSString*)getDriverNetUrl:(NetModeType)mode;
+(NSString*)getDownloadHtmlUrl:(NetModeType)mode;

+(NSArray*)getNetModes;

+(NetModeType)getCurrentNetMode;
+(void)setCurrentNetMode:(NetModeType)mode;

@end
