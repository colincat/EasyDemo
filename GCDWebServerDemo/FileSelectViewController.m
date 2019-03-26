//
//  FileSelectViewController.m
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/22.
//  Copyright © 2019 hht. All rights reserved.
//

#import "FileSelectViewController.h"
#import "TZImagePickerController.h"
#import "GCDShareFileTool.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FileSelectViewController ()<TZImagePickerControllerDelegate,MPMediaPickerControllerDelegate>
- (IBAction)videoBtnAction:(UIButton *)sender;
- (IBAction)audioBtnAction:(UIButton *)sender;
- (IBAction)closeBtnAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextView *videoPath;

///<#注释#>
@property (nonatomic ,strong) GCDShareFileTool *shareFileTool;



@end

@implementation FileSelectViewController



-(GCDShareFileTool *)shareFileTool{
    if (!_shareFileTool) {
        _shareFileTool = [[GCDShareFileTool alloc] init];
    }
    
    return _shareFileTool;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}


//选择视频
- (IBAction)videoBtnAction:(UIButton *)sender {
    
    if (_shareFileTool) {
        _shareFileTool = nil;
    }
    
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

//选择音频
- (IBAction)audioBtnAction:(UIButton *)sender {
    
    if (_shareFileTool) {
        _shareFileTool = nil;
    }
    
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    
    picker.prompt = @"添加本地音乐";
    
    picker.showsCloudItems = NO;
    
    picker.allowsPickingMultipleItems = NO;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (IBAction)closeBtnAction:(UIButton *)sender {
    
    if (_shareFileTool) {
        
        [self.shareFileTool stopShare];
        self.shareFileTool = nil;
    }
    
  
    
    self.videoPath.text = @"";
}


#pragma mark 相册选择代理
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    __weak typeof(self) weakSelf = self;
    
    [self.shareFileTool shareVideoWithSourceAssets:asset block:^(BOOL success, NSString * _Nonnull msg) {
        
        if (success) {
            
            NSLog(@"%@",msg);
            
            weakSelf.videoPath.text = msg;
            
        }else{
            
            NSLog(@"%@",msg);
            
            weakSelf.videoPath.text = msg;
        }
        
    }];
}

#pragma mark 媒体库选择代理
//取消或者没选回调函数
- (void)mediaPickerDidCancel:(MPMediaPickerController*)mediaPicker

{
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    
}



//选中选项之后代理回调

-(void)mediaPicker:(MPMediaPickerController*)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection

{
        
    MPMediaItem* item = [mediaItemCollection items].firstObject;
    
    if (!item) {
        
        [mediaPicker dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.shareFileTool shareAudioWithMediaItem:item block:^(BOOL success, NSString * _Nonnull msg) {
        
        if (success) {
            
            NSLog(@"%@",msg);
            
            weakSelf.videoPath.text = msg;
            
        }else{
            
            NSLog(@"%@",msg);
            
            weakSelf.videoPath.text = msg;
        }
        
    }];
    
    
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    
    
}



@end
