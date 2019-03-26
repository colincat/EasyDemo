//
//  ViewController.m
//  GCDWebServerDemo
//
//  Created by colincat on 2019/3/19.
//  Copyright © 2019 hht. All rights reserved.
//

#import "ViewController.h"
#import "FileSelectViewController.h"
@interface ViewController ()
- (IBAction)buttonClickAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//按钮点击事件
- (IBAction)buttonClickAction:(UIButton *)sender {
    
    FileSelectViewController *fileVC = [[FileSelectViewController alloc] init];
    
    [self.navigationController pushViewController:fileVC animated:YES];
    
}
@end
