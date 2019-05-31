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
	vc.view.backgroundColor = [UIColor redColor];
	return vc;
}

- (void)Action_nativeTest:(NSDictionary *)param {
    NSLog(@"bala bala bala!");
}

@end
