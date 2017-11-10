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
#import "PhotoBroswerController.h"
#import "HudManager.h"

#define CELL_IDENTIFIER @"photoCellID"

@interface PhotoCollectionCell : UICollectionViewCell

@property(nonatomic,retain) NSIndexPath* indexPath;
@property(nonatomic,retain) PhotoSelectionView* collectionView;
@property(nonatomic,retain) UIControl* photoButton;
@property(nonatomic,retain) PhotoAlbumVo *data;

@property(nonatomic,retain) UIControl* operateButton;
@property(nonatomic,retain) RoundRectNode* backArea;
@property(nonatomic,retain) ASTextNode* titleLabel;//去这里
//@property(nonatomic,retain) ASTextNode* tagLabel;//去这里
@property(nonatomic,retain) CAShapeLayer* tagLayer;//+

@property(nonatomic,retain) UIImageView* imageView;

//@property(nonatomic,retain) UIView* normalView;
//@property(nonatomic,retain) UIView* selectedView;

@end
@implementation PhotoCollectionCell

-(void)setData:(PhotoAlbumVo *)data{
    _data = data;
    [self setNeedsLayout];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self setNeedsLayout];
}

-(RoundRectNode *)backArea{
    if (!_backArea) {
        _backArea = [[RoundRectNode alloc]init];
        _backArea.fillColor = [UIColor whiteColor];
        _backArea.strokeColor = FlatGray;
        _backArea.strokeWidth = 1;
        _backArea.cornerRadius = 5;
        [self.operateButton.layer addSublayer:_backArea.layer];
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

//-(ASTextNode *)tagLabel{
//    if (!_tagLabel) {
//        _tagLabel = [[ASTextNode alloc]init];
//        _tagLabel.layerBacked = YES;
//        [self.backArea addSubnode:_tagLabel];
//    }
//    return _tagLabel;
//}

-(CAShapeLayer *)tagLayer{
    if (!_tagLayer) {
        _tagLayer = [UICreationUtils createPlusLayer:self.contentView.width / 2. color:FlatGray strokeWidth:6 isAdd:YES];
        [self.operateButton.layer addSublayer:_tagLayer];
    }
    return _tagLayer;
}

-(UIControl *)operateButton{
    if (!_operateButton) {
        _operateButton = [[UIControl alloc]init];
        [_operateButton setShowTouch:YES];
//        _operateButton.fillColor = [UIColor clearColor];
//        _operateButton.titleFontName = ICON_FONT_NAME;
//        _operateButton.titleSize = 80;
//        _operateButton.titleColor = FlatGray;
//        _operateButton.title = @"+";//self.collectionView.title;
//        _operateButton.strokeColor = FlatGray;
//        _operateButton.strokeWidth = 1;
//        _operateButton.userInteractionEnabled = NO;
        [_operateButton addTarget:self action:@selector(operateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_operateButton];
    }
    return _operateButton;
}

-(void)operateButtonClick{
    [self.collectionView showActionSheet];
}

-(UIControl *)photoButton{
    if (!_photoButton) {
        _photoButton = [[UIControl alloc]init];
        [_photoButton setShowTouch:YES];
        [_photoButton addTarget:self action:@selector(photoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_photoButton];
    }
    return _photoButton;
}

-(void)photoButtonClick{
    [self.collectionView showPhotoByIndexPath:self.indexPath];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.photoButton addSubview:_imageView];
    }
    return _imageView;
}

//-(UIView *)normalView{
//    if (!_normalView) {
//        _normalView = [[UIView alloc]init];
//        _normalView.backgroundColor = [UIColor clearColor];
//    }
//    return _normalView;
//}
//
//-(UIView *)selectedView{
//    if (!_selectedView) {
//        _selectedView = [[UIView alloc]init];
//        _selectedView.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _selectedView;
//}

-(void)layoutSubviews{
    if (self.indexPath.row == 0) {
        [self initBackArea];
    }else{
        [self initPhotoArea];
    }
//    self.backgroundView = self.normalView;
//    self.selectedBackgroundView = self.selectedView;
}

-(void)initBackArea{
    self.operateButton.frame = self.contentView.bounds;
    
    UIColor* color = FlatGray;
    self.backArea.userInteractionEnabled = NO;
    self.backArea.frame = self.bounds;
//    self.tagLabel.attributedString = [NSString simpleAttributedString:color size:60 content:@"+"];
//    self.tagLabel.size = [self.tagLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.tagLabel.centerX = self.backArea.centerX;
//    self.tagLabel.backgroundColor = FlatBrownDark;
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:color size:14 content:self.collectionView.title];
    self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.centerX = self.backArea.centerX;
    self.titleLabel.y = self.backArea.centerY + 20;
//    self.titleLabel.backgroundColor = FlatSkyBlue;

    self.tagLayer.frame = CGRectMake(0, -10, self.operateButton.width, self.operateButton.height);
    
    self.operateButton.hidden = NO;
    self.photoButton.hidden = YES;
}

-(void)initPhotoArea{
    self.photoButton.frame = self.imageView.frame = self.contentView.bounds;
    
    CGSize itemSize = self.contentView.size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize targetSize = CGSizeMake(itemSize.width * scale,itemSize.height * scale);
    
    self.imageView.image = nil;//先清空
    if(self.data.picture){
        self.imageView.image = self.data.picture;//直接显示拍照数据
    }else{
        NSIndexPath* nowPath = self.indexPath;
        __weak __typeof(self) weakSelf = self;
        [[PHCachingImageManager defaultManager] requestImageForAsset:self.data.phAsset
                                                          targetSize:targetSize
                                                         contentMode:PHImageContentModeAspectFill
                                                             options:nil
                                                       resultHandler:^(UIImage *result, NSDictionary *info) {
                                                           __strong typeof(weakSelf) strongSelf = weakSelf;
                                                           if (nowPath == strongSelf.indexPath) {
                                                               strongSelf.imageView.image = result;
                                                           }
                                                       }];
    }
//    if (self.data) {
//        if (self.data.imageData) {
//            self.imageView.image = [UIImage imageWithData:self.data.imageData];//self.data.image;
//        }else{
//            self.imageView.image = nil;//先清空掉
//            __weak __typeof(self) weakSelf = self;
//            [PhotoTranslateUtils translateImageByAsset:self.data completeHandler:^{
//                __strong typeof(weakSelf) strongSelf = weakSelf;
//                strongSelf.imageView.image = [UIImage imageWithData:strongSelf.data.imageData];//weakSelf.data.image;
//            }];
////            [PhotoTranslateUtils translateImageByAsset:self.data completeHandler:^{
////                NSLog(@"测试转换完成");
////            }];
//        }
//    }
    self.operateButton.hidden = YES;
    self.photoButton.hidden = NO;
}

@end

@interface PhotoSelectionView()<UIActionSheetDelegate,QBImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PhotoBroswerDelegate>

//@property(nonatomic,retain)FlatButton* operateButton;
//@property(nonatomic,retain)UICollectionView* scrollView;

@property(nonatomic,retain)NSMutableArray<PhotoAlbumVo*>* dataArray;

@property(nonatomic,retain)UICollectionViewFlowLayout *collectionLayout;

@end

@implementation PhotoSelectionView

- (instancetype)init
{
    self = [super initWithFrame:CGRectNull collectionViewLayout:self.collectionLayout];
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

//-(NSInteger)maxSelectCount{
//    if (!_maxSelectCount) {
//        _maxSelectCount = 50;
//    }
//    return _maxSelectCount;//最多50
//}

-(void)setContentSize:(CGSize)contentSize{
    [super setContentSize:contentSize];
    if (self.selectionDelegate && [self.selectionDelegate respondsToSelector:@selector(contentSizeChanged:contentSize:)]) {
        [self.selectionDelegate contentSizeChanged:self contentSize:contentSize];
    }
}

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
    [self setCollectionViewLayout:self.collectionLayout];
}

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    self.collectionLayout.scrollDirection = scrollDirection;
    [self setCollectionViewLayout:self.collectionLayout];
}

-(UICollectionViewFlowLayout *)collectionLayout{
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionLayout.minimumLineSpacing = 0;
        _collectionLayout.minimumInteritemSpacing = 0;
        _collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//默认横向 水平滑动
    }
    return _collectionLayout;
}

-(NSMutableArray<PhotoAlbumVo*> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray<PhotoAlbumVo*> alloc]init];
    }
    return _dataArray;
}

-(void)setAssetsArray:(NSMutableArray<PhotoAlbumVo*> *)assetsArray{
    _assetsArray = assetsArray;
    [self clearAll];
    [self.dataArray addObjectsFromArray:assetsArray];
}

-(void)setHGap:(CGFloat)hGap{
    _hGap = hGap;
    self.collectionLayout.minimumLineSpacing = hGap;
    self.collectionLayout.minimumInteritemSpacing = hGap;
    [self setCollectionViewLayout:self.collectionLayout];
}

-(void)clearAll{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:[[PhotoAlbumVo alloc]init]];//创建一个空的表示添加按钮
    
    [self reloadData];
    
    self.contentOffset = CGPointMake(0, 0);//恢复原位
    
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
        imagePickerController.showsNumberOfSelectedAssets = YES;
        //        imagePickerController.maximumNumberOfSelection = 6;
        [self.parentController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    [self addPickingAssets:assets];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addPickingAssets:(NSArray *)assets{
    NSInteger addCount = assets.count;
    if (self.maxSelectCount > 0 && self.dataArray.count - 1 + addCount > self.maxSelectCount) {
        addCount = self.maxSelectCount - (self.dataArray.count - 1);
        [HudManager showToast:ConcatStrings(@"图片只能添加到",@(self.maxSelectCount),@"个为止!")];
    }
    for (PHAsset* asset in assets) {
        PhotoAlbumVo* vo = [[PhotoAlbumVo alloc]init];
        vo.phAsset = asset;
        [self.assetsArray addObject:vo];
        [self.dataArray addObject:vo];
        addCount --;
        if (addCount <= 0) {
            break;//最多就只添加这些
        }
    }
    [self reloadData];
    if (self.selectionDelegate && [self.selectionDelegate respondsToSelector:@selector(photoAdded:)]) {
        [self.selectionDelegate photoAdded:self];
    }
}

- (void)showCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.allowsEditing = YES;
    // 监测权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.delegate = self;
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self addCameraAssets:image];
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//    {
//        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相册中
//    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)addCameraAssets:(UIImage*)image{
    PhotoAlbumVo* vo = [[PhotoAlbumVo alloc]init];
    vo.picture = image;
//    vo.imageData = UIImageJPEGRepresentation(image, 1);//UIImagePNGRepresentation(image);
    [self.assetsArray addObject:vo];
    [self.dataArray addObject:vo];
    [self reloadData];
    
    if (self.selectionDelegate && [self.selectionDelegate respondsToSelector:@selector(photoAdded:)]) {
        [self.selectionDelegate photoAdded:self];
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
    cell.indexPath = indexPath;
    cell.collectionView = self;
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        [self showActionSheet];
//    }
//    [self deselectItemAtIndexPath:indexPath animated:false];
//}

-(void)showActionSheet{
    if (self.maxSelectCount > 0 && self.dataArray.count - 1 >= self.maxSelectCount) {
        [HudManager showToast:ConcatStrings(@"图片最多只能添加",@(self.maxSelectCount),@"个")];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"选择相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self];
}

-(void)showPhotoByIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray* copyArray = [self.dataArray copy];
    
    [PhotoTranslateUtils translateImagesByAssets:self.dataArray completeHandler:^{
        NSMutableArray* imageArr = [NSMutableArray array];
        for (PhotoAlbumVo* vo in self.dataArray) {
            if (vo.picture) {
                [imageArr addObject:vo.picture];
            }else if (vo.imageData) {
                [imageArr addObject:vo.imageData];//直接传二进制数据
            }
        }
        PhotoBroswerController* broswerController = [[PhotoBroswerController alloc]init];
        broswerController.imageArray = imageArr;
        broswerController.selectedIndex = indexPath.row - 1;
        broswerController.delegate = self;
        [self.parentController pushViewController:broswerController animated:YES];
    }];
}

-(void)photoBroswerDelete:(PhotoBroswerController *)broswerController index:(NSInteger)index{
    if (index < self.assetsArray.count) {
        [self.assetsArray removeObjectAtIndex:index];
    }
    if (index + 1 < self.dataArray.count) {
        [self.dataArray removeObjectAtIndex:index + 1];
    }
    [self reloadData];
    if (self.selectionDelegate && [self.selectionDelegate respondsToSelector:@selector(photoDeleted:)]) {
        [self.selectionDelegate photoDeleted:self];
    }
}

//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
//        UIPanGestureRecognizer* gesture = (UIPanGestureRecognizer*)gestureRecognizer;
//        CGPoint translation = [gesture translationInView:self];
////        if (gesture.state == UIGestureRecognizerStateChanged){
//            if (translation.y < 0.0 && self.contentOffset.y >= self.contentSize.height - self.height){//向下移动到底部
//                return YES;
//            }else if(translation.y > 0 && self.contentOffset.y <= 0){//已经到顶部了
//                return YES;
//            }
////        }
//    }
////    [UIScrollViewDelayedTouchesBeganGestureRecognizer]
////
////    return self.contentOffset.y > self.contentSize.height - self.height
////    || self.contentOffset.y < 0;
//    return NO;
//}

@end
