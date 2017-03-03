//
//  TaskTripController.m
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TaskTripController.h"
#import "TaskTripSection.h"
#import "TaskTripCell.h"

@interface TestTableViewCell2 : MJTableViewCell

@end

@implementation TestTableViewCell2

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface TaskTripController (){
    UILabel* titleLabel;
}
@property(nonatomic,retain)UIView* titleView;

@end

@implementation TaskTripController

-(BOOL)getShowFooter{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}


-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_TRIP superView:_titleView];
    }
    return _titleView;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
//    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.navigationItem.titleView = self.titleView;
    
    titleLabel.text = @"TO12451516161";//标题显示TO号
    [titleLabel sizeToFit];
    titleLabel.center = self.titleView.center;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        [self.tableView clearSource];
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
        int count = 1;//(arc4random() % 18) + 30; //生成3-10范围的随机数
        for (NSUInteger i = 0; i < count; i++) {
            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
            
            [sourceData addObject:
             [CellVo initWithParams:TASK_TRIP_CELL_HEIGHT cellClass:[TaskTripCell class] cellData:[NSString stringWithFormat:@"测试数据: %lu",i]]];
        }
        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:TASK_TRIP_SECTION_HEIGHT headerClass:[TaskTripSection class] headerData:NULL]];
        handler(sourceData.count > 0);
    });
//    handler(NO);
}

//-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
//    int64_t delay = 1.0 * NSEC_PER_SEC;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
//        int count = (arc4random() % 3); //生成0-2范围的随机数
//        if (count <= 0) {
//            handler(NO);
//            return;
//        }
//        SourceVo* svo = self.tableView.getLastSource;
//        NSMutableArray<CellVo*>* sourceData = svo.data;
//        NSUInteger startIndex = [svo getRealDataCount];
//        for (NSUInteger i = 0; i < count; i++) {
//            [sourceData addObject:
//             [CellVo initWithParams:50 cellClass:[TestTableViewCell2 class] cellData:[NSString stringWithFormat:@"测试数据: %lu",startIndex + i]]];
//        }
//        handler(YES);
//    });
//}

@end
