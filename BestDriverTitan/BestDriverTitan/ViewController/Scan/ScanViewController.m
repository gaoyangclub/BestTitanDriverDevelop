//
//  ScanViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanViewModel.h"
#import "HudManager.h"
#import "FlatButton.h"
#import "SystemFunctions.h"
#import "ScanResultViewController.h"
#import "ScanOrderEditController.h"

#define SCAN_RESULT_PLACEHOLDER @"这里显示扫描结果哦"

@interface ScanViewController()<ScanOrderEditDelegate>{
    BOOL notHideNavigationBar;
}

//@property(nonatomic,retain) UILabel* titleLabel;//大标题栏
@property(nonatomic,retain) NSMutableArray<NSString*>* sourceCodeList;
@property(nonatomic,retain) ScanTaskPickUpBean* taskPickUpBean;
@property(nonatomic,retain) ScanViewModel* viewModel;
@property(nonatomic,retain) FlatButton* submitButton;
@property(nonatomic,retain) FlatButton* returnButton;
@property(nonatomic,retain) FlatButton* photoButton;
@property(nonatomic,retain) FlatButton* lightButton;

@property(nonatomic,retain) ASTextNode* resultNode;//显示扫描结果
@property(nonatomic,retain) ASTextNode* resultIcon;

@end

@implementation ScanViewController

-(ScanViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ScanViewModel alloc]init];
    }
    return _viewModel;
}

-(NSMutableArray<NSString *> *)sourceCodeList{
    if (!_sourceCodeList) {
        _sourceCodeList = [NSMutableArray array];
    }
    return _sourceCodeList;
}

-(ScanTaskPickUpBean *)taskPickUpBean{
    if (!_taskPickUpBean) {
        _taskPickUpBean = [[ScanTaskPickUpBean alloc]init];
    }
    return _taskPickUpBean;
}

//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
//    }
//    return _titleLabel;
//}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.titleColor = COLOR_BLACK_ORIGINAL;
        _submitButton.fillColor = [UIColor whiteColor];;
        _submitButton.titleSize = 18;
        _submitButton.title = @"上报";
        _submitButton.cornerRadius = 35;
        _submitButton.width = _submitButton.height = _submitButton.cornerRadius * 2;
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(FlatButton *)returnButton{
    if (!_returnButton) {
        _returnButton = [[FlatButton alloc]init];
        _returnButton.titleFontName = ICON_FONT_NAME;
        _returnButton.titleColor = [UIColor whiteColor];
        _returnButton.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        _returnButton.titleSize = 18;
        _returnButton.title = ICON_FAN_HUI;
        _returnButton.cornerRadius = 25;
        _returnButton.width = _returnButton.height = _returnButton.cornerRadius * 2;
        [_returnButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_returnButton];
    }
    return _returnButton;
}

-(FlatButton *)photoButton{
    if (!_photoButton) {
        _photoButton = [[FlatButton alloc]init];
        _photoButton.titleFontName = ICON_FONT_NAME;
        _photoButton.titleColor = [UIColor whiteColor];
        _photoButton.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        _photoButton.titleSize = 20;
        _photoButton.title = ICON_XIANG_CHE;
        _photoButton.cornerRadius = 25;
        _photoButton.width = _photoButton.height = _photoButton.cornerRadius * 2;
        [_photoButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_photoButton];
    }
    return _photoButton;
}

-(FlatButton *)lightButton{
    if (!_lightButton) {
        _lightButton = [[FlatButton alloc]init];
        _lightButton.titleFontName = ICON_FONT_NAME;
        _lightButton.titleColor = [UIColor whiteColor];
        _lightButton.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
        _lightButton.titleSize = 20;
        _lightButton.title = ICON_DIAN_SHI;
        _lightButton.cornerRadius = 25;
        _lightButton.width = _lightButton.height = _lightButton.cornerRadius * 2;
        [_lightButton addTarget:self action:@selector(clickLamp:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_lightButton];
    }
    return _lightButton;
}

- (ASTextNode *)resultNode{
    if (!_resultNode) {
        _resultNode = [[ASTextNode alloc]init];
        _resultNode.layerBacked = YES;
        _resultNode.attributedString = [NSString simpleAttributedString:FlatYellow size:16 content:SCAN_RESULT_PLACEHOLDER];
        _resultNode.size = [_resultNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        _resultNode.y = kBgImgY - _resultNode.height - 20;
        [self.view.layer addSublayer:_resultNode.layer];
    }
    return _resultNode;
}

-(ASTextNode *)resultIcon{
    if (!_resultIcon) {
        _resultIcon = [[ASTextNode alloc]init];
        _resultIcon.layerBacked = YES;
        _resultIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatYellow size:30 content:ICON_TIAO_MA];
        _resultIcon.size = [_resultIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        _resultIcon.hidden = YES;
        [self.view.layer addSublayer:_resultIcon.layer];
    }
    return _resultIcon;
}

- (void)clickLamp:(id)sender {
    if (self.lightButton.selected == YES) {
//        self.lightButton.title = ICON_DIAN_KUANG;
        self.lightButton.titleColor = [UIColor whiteColor];
        self.lightButton.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    }else{
//        self.lightButton.title = ICON_DIAN_SHI;
        self.lightButton.titleColor = COLOR_BLACK_ORIGINAL;
        self.lightButton.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    self.lightButton.selected = !self.lightButton.selected;
    [SystemFunctions openLight:self.lightButton.selected];
}

-(void)openPhoto{
    [super openPhoto];
    self->notHideNavigationBar = YES;
}

-(void)initNavigationItem{
//    self.titleLabel.text = self.navigationTitle;//self.taskBean.orderBaseCode;//标题显示SO号
//    [self.titleLabel sizeToFit];
//    self.navigationItem.titleView = self.titleLabel;
//    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
//                                 initWithTitle:@"相册"
//                                 style:UIBarButtonItemStylePlain
//                                 target:self
//                                 action:@selector(openPhoto)];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//        self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
}

-(void)leftClick{
    if (_sourceCodeList || _taskPickUpBean) {
        __weak __typeof(self) weakSelf = self;
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有已扫描的数据，退出后将不会保存，确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alertCtrl animated:YES completion:nil];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat const marginBottom = 20;
    CGFloat const marginTop = 35;
    CGFloat const marginLeft = 15;
    
    self.returnButton.x = marginLeft;
    self.returnButton.y = self.photoButton.y = self.lightButton.y = marginTop;
    
    self.photoButton.centerX = self.view.width / 2;
    self.lightButton.maxX = self.view.width - marginLeft;
    
    self.submitButton.centerX = self.view.width / 2;
    self.submitButton.maxY = self.view.height - marginBottom;
//    self.submitButton.frame = CGRectMake(margin, self.view.height - buttonAreaHeight + margin, self.view.width - margin * 2, buttonAreaHeight - margin * 2);
}

-(void)showQRCodeResult:(NSString*)qrCodeInfo{
    self.resultNode.attributedString = [NSString simpleAttributedString:FlatYellow size:16 content:qrCodeInfo];;
    self.resultNode.size = [self.resultNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.resultIcon.hidden = NO;
    self.resultIcon.centerY = self.resultNode.centerY;
    
    CGFloat const hGap = 10;
    CGFloat const baseX = (self.view.width - self.resultIcon.width - self.resultNode.width - hGap) / 2.;
    
    self.resultIcon.x = baseX;
    self.resultNode.x = self.resultIcon.maxX + hGap;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self->notHideNavigationBar) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        self->notHideNavigationBar = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultNode.centerX = self.view.width / 2;
    
    __weak __typeof(self) weakSelf = self;
    [self successfulGetQRCodeInfo:^(NSString *qrCodeInfo) {//扫描结束后回调
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf showQRCodeResult:qrCodeInfo];
        [strongSelf.viewModel checkScanRepeat:qrCodeInfo code:strongSelf.activityCode sourceCodeList:strongSelf.sourceCodeList returnBlock:^(id returnValue) {
            
            if (!returnValue) {
//                [HudManager showToast:@"数据返回为空"];
                [strongSelf scanStartRunning];//继续扫描 考虑延迟执行
                return;
            }
            ScanCodePickUpBean* itemBean = [ScanCodePickUpBean yy_modelWithJSON:returnValue];
            if(itemBean){//跳转货量保存界面
                
                ScanOrderEditController* scanOrderEditController = [[ScanOrderEditController alloc]init];
                scanOrderEditController.scanCodeBean = itemBean;
                scanOrderEditController.delegate = self;
                [self.navigationController pushViewController:scanOrderEditController animated:YES];
                
            }else{
                [strongSelf scanStartRunning];//继续扫描 考虑延迟执行
                return;
            }
//            if (itemBean.needPickupReport) {//needPickupReport字段抛弃 跳转活动上报界面
//                
//            }else{
//                [strongSelf.sourceCodeList addObject:itemBean.sourceCode];
//                [strongSelf scanStartRunning];//继续扫描 考虑延迟执行
//            }
            
        } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
//            NSLog(@"%@",errorMsg);
            [HudManager showToast:errorMsg];//验证失败
            [strongSelf scanStartRunning];//继续扫描 考虑延迟执行
        }];
    }];
}

-(void)orderEdited:(ScanOrderEditController *)controller{
    [self.taskPickUpBean addScanCodeBean:controller.scanCodeBean];//将编辑好的内容保存
}

-(void)clickSubmitButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    if (_sourceCodeList || _taskPickUpBean) {
        ScanResultViewController* resultController = [[ScanResultViewController alloc]init];
        resultController.activityCode = self.activityCode;
        resultController.sourceCodeList = _sourceCodeList;
        resultController.taskPickUpBean = _taskPickUpBean;
        resultController.viewModel = self.viewModel;
        
        [self.navigationController pushViewController:resultController animated:YES];
    }else{
        [HudManager showToast:@"无扫码数据，请先进行扫码!"];
    }
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
