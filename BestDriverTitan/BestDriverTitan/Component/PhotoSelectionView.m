//
//  PhotoSelectionView.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PhotoSelectionView.h"
#import "QBImagePickerController.h"
#import "FlatButton.h"
#import "RoundRectNode.h"

#define CELL_IDENTIFIER @"photoCellID"

@interface PhotoAlbumVo : NSObject

@end

@implementation PhotoAlbumVo
@end

@interface PhotoCollectionCell : UICollectionViewCell

@property (nonatomic,retain) NSIndexPath* indexPath;
@property (nonatomic,retain) PhotoSelectionView* collectionView;
@property (nonatomic,retain) PhotoAlbumVo* data;

//@property(nonatomic,retain)FlatButton* operateButton;
@property(nonatomic,retain) RoundRectNode* backArea;
@property(nonatomic,retain) ASTextNode* titleLabel;//去这里
@property(nonatomic,retain) ASTextNode* tagLabel;//去这里

@property(nonatomic,retain) UIView* normalView;
@property(nonatomic,retain) UIView* selectedView;

@end
@implementation PhotoCollectionCell

-(RoundRectNode *)backArea{
    if (!_backArea) {
        _backArea = [[RoundRectNode alloc]init];
        _backArea.fillColor = [UIColor whiteColor];
        _backArea.strokeColor = FlatGray;
        _backArea.strokeWidth = 1;
        _backArea.cornerRadius = 5;
        [self.layer addSublayer:_backArea.layer];
    }
    return _backArea;
}

-(ASTextNode *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.backArea addSubnode:_titleLabel];
    }
    return _titleLabel;
}

-(ASTextNode *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[ASTextNode alloc]init];
        _tagLabel.layerBacked = YES;
        [self.backArea addSubnode:_tagLabel];
    }
    return _tagLabel;
}

//-(FlatButton *)operateButton{
//    if (!_operateButton) {
//        _operateButton = [[FlatButton alloc]init];
//        _operateButton.fillColor = [UIColor whiteColor];
////        _operateButton.titleFontName = ICON_FONT_NAME;
//        _operateButton.titleSize = 80;
//        _operateButton.titleColor = FlatGray;
//        _operateButton.title = self.collectionView.title;
//        _operateButton.strokeColor = FlatGray;
//        _operateButton.strokeWidth = 1;
//        _operateButton.userInteractionEnabled = NO;
////        [_operateButton addTarget:self action:@selector(operateButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_operateButton];
//    }
//    return _operateButton;
//}

-(UIView *)normalView{
    if (!_normalView) {
        _normalView = [[UIView alloc]init];
        _normalView.backgroundColor = [UIColor clearColor];
    }
    return _normalView;
}

-(UIView *)selectedView{
    if (!_selectedView) {
        _selectedView = [[UIView alloc]init];
        _selectedView.backgroundColor = [UIColor lightGrayColor];
    }
    return _selectedView;
}

-(void)layoutSubviews{
//    self.operateButton.frame = self.bounds;
    if (self.indexPath.row == 0) {
        [self initBackArea];
    }
    self.backgroundView = self.normalView;
    self.selectedBackgroundView = self.selectedView;
}

-(void)initBackArea{
    UIColor* color = FlatGray;
    self.backArea.userInteractionEnabled = NO;
    self.backArea.frame = self.bounds;
    self.tagLabel.attributedString = [NSString simpleAttributedString:color size:60 content:@"+"];
    self.tagLabel.size = [self.tagLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.tagLabel.centerX = self.backArea.centerX;
//    self.tagLabel.backgroundColor = FlatBrownDark;
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:color size:14 content:self.collectionView.title];
    self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.centerX = self.backArea.centerX;
//    self.titleLabel.backgroundColor = FlatSkyBlue;
    
    CGFloat baseY = (self.height - self.tagLabel.height - self.titleLabel.height) / 2.;
    self.tagLabel.y = baseY;
    self.titleLabel.y = self.tagLabel.maxY;
}

@end

@interface PhotoSelectionView()<UIActionSheetDelegate,QBImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

//@property(nonatomic,retain)FlatButton* operateButton;
//@property(nonatomic,retain)UICollectionView* scrollView;

@property(nonatomic,retain)NSMutableArray<PhotoAlbumVo*>* dataArray;

@property(nonatomic,retain)UICollectionViewFlowLayout *collectionLayout;

@end

@implementation PhotoSelectionView

- (instancetype)init
{
    self = [super initWithFrame:CGRectNull collectionViewLayout:[[UICollectionViewLayout alloc]init]];
    if (self) {
        [self prepare];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    PhotoSelectionView* selfInstance = [self init];
    selfInstance.frame = frame;
    return selfInstance;
}

//-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
//    return [self initWithFrame:frame];
//}

-(void)prepare{
    //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    self.hGap = 5;
    self.title = @"添加凭证";
    self.delegate = self;
    
    [self registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    self.backgroundColor = [UIColor clearColor];
    
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    self.delegate = self;
    self.dataSource = self;
    
    [self clearAll];
}

-(void)setItemSize:(CGSize)itemSize{
    self.collectionLayout.itemSize = itemSize;
    self.collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滑动
    [self setCollectionViewLayout:self.collectionLayout];
}

-(UICollectionViewFlowLayout *)collectionLayout{
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionLayout.minimumLineSpacing = 2;
    }
    return _collectionLayout;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray<PhotoAlbumVo*> alloc]init];
    }
    return _dataArray;
}

-(void)setHGap:(CGFloat)hGap{
//    _hGap = hGap;
//    [self setNeedsLayout];
}

-(void)clearAll{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:[[PhotoAlbumVo alloc]init]];//创建一个空的表示添加按钮
    
    [self reloadData];
}

//-(FlatButton *)operateButton{
//    if (!_operateButton) {
//        _operateButton = [[FlatButton alloc]init];
//        _operateButton.fillColor = [UIColor clearColor];
////        _operateButton.titleFontName = ICON_FONT_NAME;
//        _operateButton.titleSize = 80;
//        _operateButton.titleColor = FlatGray;
//        _operateButton.title = @"+";
//        _operateButton.strokeColor = FlatGray;
//        _operateButton.strokeWidth = 1;
//        [_operateButton addTarget:self action:@selector(operateButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_operateButton];
//    }
//    return _operateButton;
//}

//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc]init];
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        [self addSubview:_scrollView];
//    }
//    return _scrollView;
//}

//-(void)operateButtonClick{
//    
//}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self showCamera];
    }else if(buttonIndex == 1){
        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.allowsMultipleSelection = YES;
        //        imagePickerController.maximumNumberOfSelection = 6;
        [self.parentController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)showCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
    //    picker.allowsEditing = YES;
    // 监测权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.parentController presentViewController:picker animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设备不支持相机！" message:@"请从相册中选取照片。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

//-(void)layoutSubviews{
//    CGFloat operateWidth = self.height;
//    self.operateButton.frame = CGRectMake(0, 0, operateWidth, operateWidth);
//    
//    CGFloat leftMargin = self.operateButton.maxX + self.hGap;
//    self.scrollView.frame = CGRectMake(leftMargin, 0, self.width - leftMargin, self.height);
//}

//- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath{
//    ImageVo* imageVo = self.cellInfoArr[indexPath.row];
//    return imageVo.cellHeight;
//}

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath: indexPath];
    PhotoAlbumVo* data = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.collectionView = self;
    cell.data = data;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self showActionSheet];
    }
    [self deselectItemAtIndexPath:indexPath animated:false];
}

-(void)showActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"选择相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self];
}

@end
