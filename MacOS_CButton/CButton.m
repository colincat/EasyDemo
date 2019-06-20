//
//  CButton.m
//  BRButtonDemo
//
//  Created by 陈可青 on 2019/6/20.
//  Copyright © 2019 BokkkRottt. All rights reserved.
//

#import "CButton.h"

@interface CButton ()<CALayerDelegate>

///<#注释#>
@property(nonatomic,assign)BOOL mouseDown;
@property (nonatomic, strong) CATextLayer *titleLayer;

@end

@implementation CButton

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    NSColor *color = self.titleNormalColor;
    NSMutableAttributedString *colorTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
    [self setAttributedTitle:colorTitle];
    
}

-(void)setup{
    
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.bordered = NO;
    [self setBezelStyle:NSBezelStyleRegularSquare];
    self.state = YES;
}

-(void)setTitleNormalColor:(NSColor *)titleNormalColor{
    _titleNormalColor = titleNormalColor;
    self.needsDisplay = YES;
}

-(void)setTitleHighlightColor:(NSColor *)titleHighlightColor{
    _titleHighlightColor = titleHighlightColor;
    self.needsDisplay = YES;
}


-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
     self.needsDisplay = YES;
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
     self.needsDisplay = YES;
}

-(void)setBorderNormalColor:(NSColor *)borderNormalColor{
    _borderNormalColor = borderNormalColor;
     self.needsDisplay = YES;
}

-(void)setBorderHighlightColor:(NSColor *)borderHighlightColor{
    _borderHighlightColor = borderHighlightColor;
     self.needsDisplay = YES;
}

-(void)setBackgroundNormalColor:(NSColor *)backgroundNormalColor{
    _backgroundNormalColor = backgroundNormalColor;
     self.needsDisplay = YES;
}

-(void)setBackgroundHighlightColor:(NSColor *)backgroundHighlightColor{
    _backgroundHighlightColor = backgroundHighlightColor;
     self.needsDisplay = YES;
}



- (void)mouseDown:(NSEvent *)theEvent
{
    _mouseDown = YES;
    self.needsDisplay = YES;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    if (_mouseDown) {
        _mouseDown = NO;
        self.needsDisplay = YES;
    }
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if (_mouseDown) {
        [self hightlightState];
    }else{
        
           [self normalState];
    }
    
    
}

-(void)hightlightState{
    
    self.layer.backgroundColor = self.backgroundHighlightColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderHighlightColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    
    [self setBtnTitleColor:self.titleNormalColor];

}

-(void)normalState{
    
    self.layer.backgroundColor = self.backgroundNormalColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderNormalColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    
   [self setBtnTitleColor:self.titleHighlightColor];
    
}

- (CATextLayer *)titleLayer {
    if (_titleLayer == nil) {
        _titleLayer = [[CATextLayer alloc] init];
        _titleLayer.delegate = self;
    }
    return _titleLayer;
}



-(void)setBtnTitleColor:(NSColor *)titleColor{
    NSColor *color = titleColor;
    NSMutableAttributedString *colorTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
    [self setAttributedTitle:colorTitle];
    
}

@end
