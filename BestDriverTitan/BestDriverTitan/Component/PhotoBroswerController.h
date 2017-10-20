//
//  PhotoBroswerController.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoBroswerController;

@protocol PhotoBroswerDelegate <NSObject>
@optional
-(void)photoBroswerDelete:(PhotoBroswerController*)broswerController index:(NSInteger)index;//界面将要消失
@end

@interface PhotoBroswerController : UIViewController

@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<PhotoBroswerDelegate> delegate;

@end
