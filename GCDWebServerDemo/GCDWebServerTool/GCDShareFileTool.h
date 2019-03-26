//
//  GCDShareSystemVideoTool.h
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/22.
//  Copyright © 2019 hht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>
NS_ASSUME_NONNULL_BEGIN

@interface GCDShareFileTool : NSObject

//从相册分享视频文件
-(void)shareVideoWithSourceAssets:(PHAsset *)asset
                            block:(void(^)(BOOL success,NSString *msg))block;

//从itunes分享音频文件
-(void)shareAudioWithMediaItem:(MPMediaItem *)mediaItem
                            block:(void(^)(BOOL success,NSString *msg))block;


//直接分享文件路径
-(void)sharefileWithFilePath:(NSString *)filePath
                    block:(void(^)(BOOL success,NSString *msg))block;




//停止分享
-(void)stopShare;

@end

NS_ASSUME_NONNULL_END
