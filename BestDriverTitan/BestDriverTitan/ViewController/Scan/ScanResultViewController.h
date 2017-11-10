//
//  ScanResultViewController.h
//  BestDriverTitan
//
//  Created by admin on 2017/11/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MJTableViewController.h"
#import "ScanViewModel.h"

@interface ScanResultViewController : MJTableViewController

@property(nonatomic,retain) NSArray<NSString*>* sourceCodeList;
@property(nonatomic,copy) NSString* activityCode;
@property(nonatomic,retain) ScanViewModel* viewModel;
@property(nonatomic,retain) ScanTaskPickUpBean* taskPickUpBean;

@end
