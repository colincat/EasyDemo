//
//  CButton.h
//  BRButtonDemo
//
//  Created by 陈可青 on 2019/6/20.
//  Copyright © 2019 BokkkRottt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <CoreGraphics/CoreGraphics.h>

IB_DESIGNABLE

@interface CButton : NSButton

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;               // Default:0.0  - Button's border corner radius
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;                // Default:0.0  - Button's border width

@property (nonatomic, strong) IBInspectable NSColor *borderNormalColor;         // Default:nil  - Button's border color when state off
@property (nonatomic, strong) IBInspectable NSColor *borderHighlightColor;      // Default:nil  - Button's border color when state on
@property (nonatomic, strong) IBInspectable NSColor *backgroundNormalColor;     // Default:nil  - Button's background color when state off
@property (nonatomic, strong) IBInspectable NSColor *backgroundHighlightColor;  // Default:nil  - Button's background color when state on
@property (nonatomic, strong) IBInspectable NSColor *titleNormalColor;          // Default:nil  - Button's title color when state off
@property (nonatomic, strong) IBInspectable NSColor *titleHighlightColor;       // Default:nil  - Button's title color when state on

@end


