//
//  Target_kTest.m
//  SNMediator
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "Target_kTest.h"

@implementation Target_kTest

- (UIViewController *)Action_nativeTestViewController:(NSDictionary *)params {
	UIViewController * vc = [[UIViewController alloc] init];
	vc.view.backgroundColor = [UIColor yellowColor];
    vc.title = @"test viewController";
	return vc;
}

- (void)Action_nativeTest:(NSDictionary *)param {
    NSLog(@"action! action! action!");
}

- (UIViewController *)Action_balabala:(NSDictionary *)param {
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"安全 URL";
    return vc;
}



@end
