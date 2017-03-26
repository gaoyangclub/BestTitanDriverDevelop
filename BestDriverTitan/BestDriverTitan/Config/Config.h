//
//  Config.h
//  Copyright (c) 2016年 admin. All rights reserved.
//

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
//typedef void (^NetWorkBlock)(BOOL netConnetState);


#define COLOR_PRIMARY [UIColor flatMintColor]//rgba(23,182,46,1)
#define COLOR_BACKGROUND rgba(246,246,246,1)
#define COLOR_LINE rgba(218,218,218,1)
#define COLOR_YI_WAN_CHENG rgb(67,152,216)//rgba(21,178,168,1)
#define COLOR_DAI_WAN_CHENG rgb(250,83,44)//rgba(240,129,69,1)
#define LINE_WIDTH 0.5

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


#define DRIVER_URL @"http://t8.800best.com/ti-rest-war/api/"


#define AUTH_CODE_URL(phone) ConcatStrings(DRIVER_URL,@"token/driver/",phone)
#define CHECK_VERSION_URL ConcatStrings(DRIVER_URL,@"version/detail/ios")
//[DRIVER_URL stringByAppendingString:[NSString stringWithFormat:@"token/driver/%@",phone]]


#define DRAWER_WIDTH 200
#define ICON_FONT_NAME @"iconfont"


#define ICON_SHE_ZHI @"\U0000e628"
#define ICON_DING_DAN @"\U0000e652"
#define ICON_DAI_FU_KUAN @"\U0000e6a8"
#define ICON_XIAO_XI @"\U0000e634"
#define ICON_WO_DE @"\U0000e611"

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



#define TABBAR_TITLE_TI_HUO @"提货"
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

#define SYSTEM_SCALE ([UIApplication sharedApplication].delegate).window.screen.scale

#define SYSTEM_SCALE_FACTOR (SYSTEM_SCALE > 2 ? SYSTEM_SCALE / 2.5 : SYSTEM_SCALE / 2)

#define TASK_VIEW_CELL_HEIGHT 200
#define TASK_VIEW_SECTION_HEIGHT 50

#define TASK_TRIP_CELL_HEIGHT 600 - 175
#define TASK_TRIP_SECTION_TOP_HEIGHT 65
#define TASK_TRIP_SECTION_HEIGHT TASK_TRIP_SECTION_TOP_HEIGHT + SYSTEM_SCALE_FACTOR * 175

#define ORDER_TAB_WIDTH 80

#define EVENT_ADDRESS_SELECT @"EVENT_ADDRESS_SELECT"


