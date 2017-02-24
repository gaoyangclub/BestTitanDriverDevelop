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

#define TABBAR_TITLE_REN_WU @"任务"
#define TABBAR_TITLE_DAI_FU_KUAN @"待付款"
#define TABBAR_TITLE_XIAO_XI @"消息"
#define TABBAR_TITLE_WO @"我"


#define NAVIGATION_TITLE_HOME @"主页"
#define NAVIGATION_TITLE_TASK_HOME @"我的任务"
#define NAVIGATION_TITLE_TASK_TRIP @"我的行程"


#define TASK_VIEW_CELL_HEIGHT 180
#define TASK_VIEW_SECTION_HEIGHT 50



