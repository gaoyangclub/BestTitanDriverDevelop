//
//
//  CustomComboboxView.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopModelView.h"


@class CustomPopListView;

@protocol CustomPopListViewDelegate<NSObject>

@optional
-(void)onSelectedIndex:(CustomPopListView*)listView index:(NSInteger)index;
@optional
-(void)onSelectedItem:(CustomPopListView*)listView item:(NSObject*)item;

@end

@interface CustomPopListView : CustomPopModelView

@property(nonatomic, weak) id<CustomPopListViewDelegate> delegate;

@property(nonatomic,assign) BOOL clickItemDismiss;//选中某个条目自动关闭选项

@property(nonatomic,retain) NSArray* dataArray;
@property(nonatomic,copy) NSString* dataField;

@property(nonatomic,retain) Class cellClass;

-(CGRect)getTableViewFrame;

@end
