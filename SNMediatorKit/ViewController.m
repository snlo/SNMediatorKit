//
//  ViewController.m
//  SNMediator
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNMediatorKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)handleTestActionButton:(UIButton *)sender {
	
    __block UIViewController * vc = [SNMediator sn_Module:@"kTest" url:nil action:@"nativeTestViewControler" params:nil cacheTarget:NO];
    __block UIViewController * vc_swift = [SNMediator sn_Module:@"kTestSwift" url:nil action:@"nativeFetchSwiftViewController" params:@{} cacheTarget:NO];

    [self presentViewController:vc animated:YES completion:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:^{

            }];
        });

    }];
	
	NSLog(@"%@",[SNMediator class]);
}


@end
