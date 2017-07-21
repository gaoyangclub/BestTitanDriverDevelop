//
//  NetConfig.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

@class NetConfig;

#define SERVER_URL_PERSON_YAN @"http://10.45.25.227:8080/ti-rest-war/api/"//IP 颜wj
#define SERVER_URL_PERSON_ZHOU @"http://10.45.24.104:80/ti-rest-war/api/"//IP 周q
#define SERVER_URL_PERSON_LIU @"http://bg229565.800best.net:8081/ti-rest-war/api/"//IP 刘z
#define SERVER_URL_PERSON_ZHU @"http://bl02777.800best.net:8089/ti-rest-war/api/"//IP 朱jd
#define SERVER_URL_PERSON_WANG @"http://bg246069.800best.net:8080/ti-rest-war/api/"//IP 王sj
#define SERVER_URL_PERSON_ZHENG @"http://10.45.16.83:8080/ti-rest-war/api/"//IP 郑xx
#define SERVER_URL_DEMO @"http://t8demo.800best.com/ti-rest-war/api/"//demo
#define SERVER_URL_TEST @"http://t8test.800best.com/ti-rest-war/api/"//测试环境
#define SERVER_URL_UAT @"http://t8uat.800best.com/ti-rest-war/api/"//外网访问 UAT
#define SERVER_URL_RELEASE @"http://t8.800best.com/ti-rest-war/api/"//生产环境
#define SERVER_URL_RELEASE_T9 @"http://t9.800best.com/ti-rest-war/api/"//T9生产环境

#define SERVER_DRIVER_URL [NetConfig getDriverNetUrl:netMode]

#define AUTH_CODE_URL(phone,isadmin) ConcatStrings(SERVER_DRIVER_URL,@"token/driver/authcode/",phone,@"/",isadmin)
#define CHECK_VERSION_URL ConcatStrings(SERVER_DRIVER_URL,@"version/detail/ios")
#define LOGIN_URL(phone,authcode) ConcatStrings(SERVER_DRIVER_URL,@"token/driver/",phone,@"/",authcode)

typedef NS_ENUM(NSInteger,NetModeType) {
    NetModeTypePersonYan = 1,
    NetModeTypePersonZhou = 7,
    NetModeTypePersonLiu = 8,
    NetModeTypePersonWang = 9,
    NetModeTypePersonZhu = 10,
    NetModeTypePersonZheng = 11,
    NetModeTypeDemo = 6,
    NetModeTypeUat = 3,
    NetModeTypeTest = 2,
    NetModeTypeRelease = 5,
    NetModeTypeReleaseT9 = 101
};

@interface NetConfig : NSObject

+(NSString*)getDriverNetUrl:(NetModeType)mode;

@end
