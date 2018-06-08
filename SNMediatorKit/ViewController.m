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
//	pod trunk push SNMediatorKit.podspec --verbose --allow-warnings --use-libraries
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)handleTestActionButton:(UIButton *)sender {
	
//    RACSignal * signal = [SNMediator mediateModule:@"Test" url:nil signal:@"nativeTestSignal" params:nil shouldCacheTarget:NO];
//
//	[signal subscribeNext:^(id  _Nullable x) {
//		NSLog(@"valuesodfji - --  -- - - -- - -- %@",x);
//	}];
	
//	RACCommand * com = [SNMediator mediateModule:@"Test" url:nil signal:@"nativeTestSignal" params:nil shouldCacheTarget:NO];
//
//	[[com execute:nil] subscribeNext:^(id  _Nullable x) {
//		NSLog(@" - - -- = - - - %@",x);
//	}];
	
//	RACSubject * sub = [SNMediator mediateModule:@"Test" url:nil signal:@"nativeTestSignal" params:nil shouldCacheTarget:NO];
//
//	[sub subscribeNext:^(id  _Nullable x) {
//		NSLog(@" - -- - -- - --00 0 %@",x);
//	}];
//	[sub sendNext:@"ddddd"];
	
	
	
	
	
	
    __block UIViewController * vc = [SNMediator mediateModule:@"Test" url:nil action:@"nativeTestViewController" params:nil shouldCacheTarget:NO];

    [self presentViewController:vc animated:YES completion:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:^{

            }];
        });

    }];
	
	NSLog(@"%@",[SNMediator class]);
}


@end
