//
//  SNMediatorconfig_01.m
//  SNMediatorKit
//
//  Created by snlo on 2019/6/4.
//  Copyright © 2019 snlo. All rights reserved.
//

#import "SNMediatorconfig_01.h"

@implementation SNMediatorconfig_01

- (BOOL)safeLogicUrl:(NSDictionary *)param {
    NSLog(@"安全通过参数：%@",param);
    return YES;
}

@end
