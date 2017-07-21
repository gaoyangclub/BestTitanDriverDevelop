//
//  GYTabBarController.m
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "GYTabBarController.h"

@interface GYTabBarController ()<GYTabBarDelegate>{
    BOOL changeData;
}

@property(nonatomic,retain) GYTabBarView* tabBarView;
@property(nonatomic,retain) UIView* lineView;

@end

@implementation GYTabBarController

-(CGFloat)tabBarHeight{
    if(!_tabBarHeight){
        _tabBarHeight = 50;//默认
    }
    return _tabBarHeight;
}

-(void)setItemClass:(Class)itemClass{
    _itemClass = itemClass;
    changeData = YES;
    [self.view setNeedsLayout];
}

-(void)setDataArray:(NSArray<TabData *> *)dataArray{
    _dataArray = dataArray;
    changeData = YES;
    [self.view setNeedsLayout];
}

-(void)setItemBadge:(NSInteger)badge atIndex:(NSInteger)index {
    if (index < _dataArray.count) {
        _dataArray[index].badge = badge;
    }
}

-(GYTabBarView *)tabBarView{
    if (!_tabBarView) {
        _tabBarView = [[GYTabBarView alloc]init];
        _tabBarView.delegate = self;
//        [self.view addSubview:_tabBarView];
    }
    return _tabBarView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [self prepare];
//    });
    
    UIView* tw = [self.view.subviews objectAtIndex:0];;//UITransitionView
//    tw.backgroundColor = [UIColor blueColor];
    tw.frame = CGRectMake(0,0,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds) - self.tabBarHeight);
//
    CGRect tabBarFrame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - self.tabBarHeight, CGRectGetWidth(self.view.bounds), self.tabBarHeight);
//    tabBarFrame.size = CGSizeMake(CGRectGetWidth(self.view.bounds), self.tabBarHeight);
    self.tabBar.frame = tabBarFrame;
    
    self.tabBarView.frame = self.tabBar.frame;//CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    self.tabBarView.backgroundColor = [UIColor blueColor];
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - self.tabBarHeight, CGRectGetWidth(self.view.bounds), 1);
    
    self.tabBarView.itemClass = _itemClass;
    
    if (changeData) {
        changeData = NO;
        self.tabBarView.dataArray = _dataArray;
        [self ensureControllers:tw.frame];
    }
}

-(void)prepare{
    [self.view addSubview:self.tabBarView];
    [self.view addSubview:self.lineView];//TODO 添加横线
}

-(void)ensureControllers:(CGRect)bounds{
    NSMutableArray<UIViewController *> *ctrls = [[NSMutableArray alloc] init];
    for (TabData* tabData in _dataArray) {
        [ctrls addObject:tabData.controller];
        tabData.controller.view.frame = bounds;
//        [tabData.controller viewDidLoad];
    }
    [self setViewControllers:ctrls animated:YES];
}

-(void)didSelectItem:(GYTabBarView *)tabBar tabData:(TabData *)tabData index:(NSInteger)index{
    self.selectedIndex = index;
}

-(void)valueCommit:(NSInteger)selectedIndex{
    [self.tabBarView setSelectedIndex:selectedIndex];
}

//-(void)setSelectedIndex:(NSUInteger)selectedIndex{
//    [super setSelectedIndex:selectedIndex];
////    [self setNeedsStatusBarAppearanceUpdate];
//}

- (void)viewDidLoad {
//    [self aaa];
    
    [super viewDidLoad];
    self.tabBar.hidden = YES; //直接忽略原先的
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
