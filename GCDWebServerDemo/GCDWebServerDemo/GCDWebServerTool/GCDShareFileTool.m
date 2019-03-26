//
//  GCDShareSystemVideoTool.m
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/22.
//  Copyright © 2019 hht. All rights reserved.
//

#import "GCDShareFileTool.h"
#import "GCDWebServerTool.h"
@interface GCDShareFileTool ()

@property (nonatomic ,strong) GCDWebServerTool *webServerTool;

///临时沙盒
@property (nonatomic ,strong) NSString *sandboxPath;

@end

@implementation GCDShareFileTool


-(NSString *)sandboxPath{
    if (!_sandboxPath) {
        _sandboxPath = [NSString stringWithFormat:@"%@/HHTWebShare",NSTemporaryDirectory()];
    }
    
    return _sandboxPath;
}


-(GCDWebServerTool *)webServerTool{
    if (!_webServerTool) {
        _webServerTool = [[GCDWebServerTool alloc] init];
    }
    
    return _webServerTool;
}


//从相册分享视频文件
-(void)shareVideoWithSourceAssets:(PHAsset *)asset
                            block:(void(^)(BOOL success,NSString *msg))block{
    
    PHAssetResource *assetRescource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    //创建保存到沙盒的路径
    NSString *fileName = assetRescource.originalFilename;
    NSString *filePath=[self.sandboxPath stringByAppendingPathComponent:fileName];
    
    //先尝试删除文件夹
    [self delFileWithPath:self.sandboxPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:self.sandboxPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //保存到沙盒
    PHAssetResourceManager *manager = [PHAssetResourceManager defaultManager];

    __weak typeof(self) weakSelf = self;
    
    [manager writeDataForAssetResource:assetRescource toFile:[NSURL fileURLWithPath:filePath] options:nil completionHandler:^(NSError * _Nullable error) {
        if (error==nil) {
            
            NSLog(@"保存沙盒成功%@",filePath);
 
            [weakSelf startWebSeverWithSourceFilePath:filePath block:block];
            
        }else{
            
            block(NO,@"保存沙盒失败,重新尝试");
            
            NSLog(@"保存沙盒失败,重新尝试");
        }
    }];
    
}

//从itunes分享音频文件
-(void)shareAudioWithMediaItem:(MPMediaItem *)mediaItem
                   block:(void(^)(BOOL success,NSString *msg))block{
    
    
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:mediaItem.assetURL options:nil];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc]
                                      initWithAsset: songAsset
                                      presetName: AVAssetExportPresetAppleM4A];
    NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
    exporter.outputFileType = AVFileTypeAppleM4A;
    
    NSString *fileName =  [mediaItem.title stringByAppendingString:@".m4a"];
  
    NSString *filePath = [self.sandboxPath
                            stringByAppendingPathComponent:fileName];
   
    //先尝试删除文件夹
    [self delFileWithPath:self.sandboxPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:self.sandboxPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    exporter.outputURL = [NSURL fileURLWithPath:filePath];
 
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        //Code for completion Handler
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (exporter.error) {
                
                block(NO,@"文件提取失败");
                
            }else{
                
                [self sharefileWithFilePath:filePath block:block];
                
            }
  
        });

    }];
    
    
    
    
}



//直接分享文件路径
-(void)sharefileWithFilePath:(NSString *)filePath
                    block:(void(^)(BOOL success,NSString *msg))block{
    
    [self startWebSeverWithSourceFilePath:filePath block:block];
  
}

//停止分享服务
-(void)stopShare{
    
    [self.webServerTool stopWebSever];
    
    self.webServerTool = nil;
    
    //清空临时沙盒
    if (_sandboxPath) {
        [self delFileWithPath:_sandboxPath];
    }
    
}


#pragma mark 私有方法

//创建服务器路径
-(void)startWebSeverWithSourceFilePath:(NSString *)sourceFilePath
                                 block:(void(^)(BOOL success,NSString *msg))block{
    
    if ([GCDShareFileTool isDirectory:sourceFilePath]) {
        
        block(NO,@"不是文件路径");
        
        return;
    }
    
    
    NSString *fileName = [sourceFilePath lastPathComponent];
    
    NSString * rootDirectoryPath = [sourceFilePath stringByDeletingLastPathComponent];
    
    [self.webServerTool startWebSeverWithRootDirectoryPath:rootDirectoryPath block:^(BOOL success, NSString *msg) {
        
        if (success) {
            
            NSString *url = [msg stringByAppendingString:fileName];
            
            NSCharacterSet *encode_set = [NSCharacterSet URLQueryAllowedCharacterSet];
            
            NSString *url_encode = [url stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
            
            
            NSLog(@"服务器文件地址%@",url_encode);
            
            block(YES,url_encode);
            
        }else{
            
            block(NO,@"服务器文件地址出错");
        }
        
    }];
    
}


//删除文件
-(void)delFileWithPath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:path];
    
    //存在,就先删除
    if (existed) {
        BOOL success = [fileManager removeItemAtPath:path error:nil];
        
        if (success) {
            NSLog(@"文件删除成功");
        }else{
            
            NSLog(@"文件删除失败");
        }
        
    }
}

//判断是否是文件夹
+ (BOOL)isDirectory:(NSString *)filePath
{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}






@end
