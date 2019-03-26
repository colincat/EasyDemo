//
//  GCDWebServerTool.h
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/20.
//  Copyright © 2019 hht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDWebServerTool : NSObject

//开启web服务
-(void)startWebSeverWithRootDirectoryPath:(NSString *)path
                       block:(void(^)(BOOL success,NSString *msg))block;

//关闭web服务
-(void)stopWebSever;







@end


