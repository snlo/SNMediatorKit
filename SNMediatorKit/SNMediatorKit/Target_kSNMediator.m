//
//  Target_kSNMediator.m
//  SNMediatorKit
//
//  Created by snlo on 2019/6/3.
//  Copyright © 2019 snlo. All rights reserved.
//

#import "Target_kSNMediator.h"

@implementation Target_kSNMediator

- (id)Action_nativeNotFound:(NSDictionary *)param {
    return [self errorWith:param[@"msg"]];
}

- (BOOL)Avtion_nativeSafeMediatorUrl:(NSDictionary *)param {
    NSLog(@" -- -- - safe - -- - - %@",param);
    return NO;
}

#pragma mark -- exception handling
- (UIViewController *)errorWith:(NSString *)msg {
    __block UIViewController * errorViewController = [[UIViewController alloc] init];
    errorViewController.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 400, 400);
    label.text = @"404";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:24];
    label.center = errorViewController.view.center;
    [errorViewController.view addSubview:label];
#if DEBUG
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg?:@"相关功能敬请期待，感谢您的支持" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        
    }];
#endif
    return errorViewController;
}

@end
