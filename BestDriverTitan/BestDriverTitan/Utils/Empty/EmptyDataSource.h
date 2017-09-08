//
//  EmptyDataSource.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
/** 结束刷新后的回调 */
typedef void (^DidTapButtonBlock)();

@interface EmptyDataSource : NSObject <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic,assign)BOOL netError;
@property(nonatomic,copy)NSString* noDataIconName;
@property(nonatomic,copy)NSString* noDataDescription;
@property(nonatomic,copy)NSString* netErrorDescription;
@property(nonatomic,copy)NSString* buttonTitle;
@property(nonatomic,copy)NSString* netErrorTitle;

/** 点击刷新的回调 */
@property(nonatomic,copy)DidTapButtonBlock didTapButtonBlock;

@end
