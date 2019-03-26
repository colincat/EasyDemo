//
//  GCDWebServerTool.m
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/20.
//  Copyright © 2019 hht. All rights reserved.
//

#import "GCDWebServerTool.h"
#import "GCDWebServer.h"

@interface GCDWebServerTool ()
{
    GCDWebServer* _webServer;
}

@end

@implementation GCDWebServerTool

//开启web服务
-(void)startWebSeverWithRootDirectoryPath:(NSString *)path
                       block:(void(^)(BOOL success,NSString *msg))block{
    
    _webServer = [[GCDWebServer alloc] init];
    
    NSString *rootDirectoryPath = path.length?path:NSTemporaryDirectory();
    
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:rootDirectoryPath indexFilename:@"" cacheAge:3600 allowRangeRequests:YES];
    
   
    NSError *error;
    [_webServer startWithOptions:@{GCDWebServerOption_AutomaticallySuspendInBackground:@(NO)} error:&error];
    
    if (error) {
        block(NO,@"服务开启失败");
    }else{
        
        block(YES,_webServer.serverURL.absoluteString);
    }
    
    NSLog(@"Visit %@ in your web browser", _webServer.serverURL);
}


//关闭web服务
-(void)stopWebSever{
    
    if (_webServer) {
        
        [_webServer stop];
        
        _webServer = nil;
    }
    
  
}

@end
