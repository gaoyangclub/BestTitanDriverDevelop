//
//  Config.h
//  Copyright (c) 2016年 admin. All rights reserved.
//
#import "NetConfig.h"
#import "User.h"

#define COLOR_PRIMARY [UIColor flatSkyBlueColor]//COLOR_YI_WAN_CHENG//[UIColor flatMintColor]//rgba(23,182,46,1)
#define COLOR_BACKGROUND rgba(226,226,226,1)
#define COLOR_LINE rgba(218,218,218,1)
#define COLOR_YI_WAN_CHENG rgb(67,152,216)//rgba(21,178,168,1)
#define COLOR_DAI_WAN_CHENG FlatWatermelon//[UIColor flatSandColorDark]//rgb(250,83,44)//rgba(240,129,69,1)
#define LINE_WIDTH 0.5

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define DRAWER_WIDTH 200
#define ICON_FONT_NAME @"iconfont"

#define BOOL_TO_STRING(bool) bool ? @"true" : @"false"

#define AUTH_CODE_PREV @"abdfl23lklasdjfklflkasjf"

#define ICON_SHE_ZHI @"\U0000e628"

//#define ICON_LOGO_SPLASH @"\U0000e7a9"

#define ICON_NODE @"\U0000e64e"

#define ICON_DING_DAN @"\U0000e60b"
#define ICON_DING_DAN_SELECTED @"\U0000e63d"
#define ICON_DAI_FU_KUAN @"\U0000e744"
#define ICON_DAI_FU_KUAN_SELECTED @"\U0000e619"
#define ICON_XIAO_XI @"\U0000e6c8"
#define ICON_XIAO_XI_SELECTED @"\U0000e853"
#define ICON_WO_DE @"\U0000e646"
#define ICON_WO_DE_SELECTED @"\U0000e629"

#define ICON_YI_WAN_CHENG @"\U0000e69a"
#define ICON_DAI_WAN_CHENG @"\U0000e699"
#define ICON_SHI_JIAN @"\U0000e610"
#define ICON_JU_LI @"\U0000e63c"
#define ICON_JIN_QIAN @"\U0000e642"
#define ICON_QI_DIAN @"\U0000e674"
#define ICON_ZHONG_DIAN @"\U0000e673"

#define ICON_TI_HUO @"\U0000e653"
#define ICON_ZHUANG_CHE @"\U0000e662"
#define ICON_XIE_HUO @"\U0000e62b"
#define ICON_QIAN_SHOU @"\U0000e67e"
#define ICON_HUI_DAN @"\U0000e623"
#define ICON_SHOU_KUAN @"\U0000e624"

#define ICON_DAI_SHANG_BAO @"\U0000e613"
#define ICON_YI_SHANG_BAO @"\U0000e63b"
#define ICON_JING_GAO @"\U0000e6d4"

#define ICON_KA_CHE @"\U0000e606"

#define ICON_BAO_ZHUANG @"\U0000e60f"
#define ICON_ZHONG_LIANG @"\U0000e61b"
#define ICON_TI_JI @"\U0000e633"
#define ICON_JIAN_SHU @"\U0000e654"

#define ICON_STAR @"\U0000e6e2"

#define ICON_QI_DIAN @"\U0000e674"
#define ICON_ZHONG_DIAN @"\U0000e673"

#define ICON_DIAN_HUA @"\U0000e61c"
#define ICON_DAO_HANG @"\U0000e600"

#define ICON_CLOSE @"\U0000e6a0"

#define ICON_GUI_HUA @"\U0000e601"

#define ICON_YAN_ZHENG_MA @"\U0000e60c"

#define ICON_HUO_LIANG @"\U0000e644"
#define ICON_SHOU_ZHI @"\U0000e63a"
#define ICON_QIAN_DAO @"\U0000e608"
#define ICON_LI_CHENG @"\U0000e687"
#define ICON_FEN_XIANG @"\U0000e602"
#define ICON_FAN_KUI @"\U0000e635"
#define ICON_BAN_BEN @"\U0000e60e"

#define APPLICATION_NAME @"百世通"
#define APPLICATION_NAME_EN @"BestTitan"


#define TABBAR_TITLE_TI_HUO @"揽收"
#define TABBAR_TITLE_ZHUANG_CHE @"装车"
#define TABBAR_TITLE_XIE_HUO @"卸货"
#define TABBAR_TITLE_QIAN_SHOU @"签收"
#define TABBAR_TITLE_HUI_DAN @"回单"
#define TABBAR_TITLE_SHOU_KUAN @"收款"

#define TABBAR_TITLE_REN_WU @"任务"
#define TABBAR_TITLE_DAI_FU_KUAN @"待付款"
#define TABBAR_TITLE_XIAO_XI @"消息"
#define TABBAR_TITLE_WO @"我"


#define NAVIGATION_TITLE_HOME @"主页"
#define NAVIGATION_TITLE_TASK_HOME @"我的任务"
#define NAVIGATION_TITLE_TASK_TRIP @"我的行程"

#define NAVIGATION_TITLE_USER @"我的"

#define SYSTEM_SCALE ([UIApplication sharedApplication].delegate).window.screen.scale

#define SYSTEM_SCALE_FACTOR (SYSTEM_SCALE > 2 ? SYSTEM_SCALE / 2.5 : SYSTEM_SCALE / 2)

#define PAGE_MENU_HEIGHT 45

#define MORE_BUTTON_RADIUS 20

#define SUBMIT_BUTTON_HEIGHT 50

#define TASK_VIEW_CELL_HEIGHT 145 //240
#define TASK_VIEW_SECTION_HEIGHT 50

#define TASK_TRIP_AREA_HEIGHT 140

#define TASK_TRIP_CELL_HEIGHT 460 - TASK_TRIP_AREA_HEIGHT
#define TASK_TRIP_SECTION_TOP_HEIGHT 65
#define TASK_TRIP_SECTION_HEIGHT TASK_TRIP_SECTION_TOP_HEIGHT + TASK_TRIP_AREA_HEIGHT

#define ORDER_TAB_WIDTH 80
#define ORDER_VIEW_CELL_HEIGHT 150

#define EVENT_ADDRESS_SELECT @"EVENT_ADDRESS_SELECT"
#define EVENT_LOGIN_COMPLETE @"EVENT_LOGIN_COMPLETE"

#define ACTIVITY_CODE_PICKUP_HANDOVER @"PICKUP_HANDOVER" //揽收
#define ACTIVITY_CODE_LOAD @"LOAD" //装车
#define ACTIVITY_CODE_UNLOAD @"UNLOAD" //卸货
#define ACTIVITY_CODE_SIGN_FOR_RECEIPT @"SIGN_FOR_RECEIPT" //签收
#define ACTIVITY_CODE_DELIVERY_RECEIPT @"DELIVERY_RECEIPT" //回单
#define ACTIVITY_CODE_COD @"COD" //收款

#define AUDIT_DENIED @"DENIED"//未通过审核
#define AUDIT_ADMIT @"ADMIT"//通过审核
#define AUDIT_NO_DATA @"NO_DATA"//还未提交
#define AUDIT_PENDING @"PENDING_AUDIT"//审核中

#define USER_KEY @"user_key"
#define PHONE_KEY @"phone_key"

static BOOL isUserProxyMode = NO;//是否监控模式
static BOOL hasPermission = YES;//在监控模式(isUserProxyMode = YES)下 不设置此值为YES无权提交和上传数据
static NetModeType netMode = NetModeTypeDemo;//默认T8生产环境

static User* userProxy;//被观察的用户临时信息

@interface Config : NSObject


+(NSString*)getActivityIconByCode:(NSString*)code;
+(NSString*)getActivityLabelByCode:(NSString*)code;


+(void)setUser:(User*)value;
+(User*)getUser;

+(NSString*)getToken;

@end



