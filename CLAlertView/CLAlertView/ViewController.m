//
//  ViewController.m
//  CLAlertView
//
//  Created by zqwl001 on 15/11/15.
//  Copyright © 2015年 zqwl. All rights reserved.
//

#import "ViewController.h"
#import "CLAlterView.h"
@interface ViewController () <CLAlterViewDelegate>
@property (nonatomic, strong) CLAlterView  *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3", @"4" ,nil];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"---------------");
        return ;
//        NSLog(@"---------");

        
    }];


//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"quxiao" otherButtonTitles:@"kong", nil];
    
    UIButton *butotn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    butotn.frame = CGRectMake(100, 100, 100, 100);
    [butotn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butotn];
    
    self.alert = [[CLAlterView alloc] initWithTitle:@"提示" message:@"你好" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"中国"];
//    [self.alert hiddenTitleAndline];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)show{
    [self.alert show];
}






//- (void)alertView:(CLAlterView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        NSLog(@"取消");
//    }
//    if (buttonIndex == 1) {
//        NSLog(@"other");
//        
//    }
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
