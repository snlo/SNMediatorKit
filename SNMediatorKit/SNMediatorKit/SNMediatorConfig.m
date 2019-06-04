//
//  SNMediatorConfig.m
//  SNMediatorKit
//
//  Created by snlo on 2019/6/3.
//  Copyright © 2019 snlo. All rights reserved.
//

#import "SNMediatorConfig.h"
#import <objc/runtime.h>

static NSString * kSNMediatorConfigErrorController = @"kSNMediatorConfigErrorController";

@implementation SNMediatorConfig

- (id _Nullable)notFound:(NSDictionary * _Nullable)param {
#if DEBUG
    NSLog(@"not found:%@",param);
#endif
    return [self errorWith:param[@"msg"]];
}

- (BOOL)safeLogicUrl:(NSDictionary * _Nullable)param {
#if DEBUG
    NSLog(@"safe logic url:%@",param);
#endif
    return YES;
}

#pragma mark -- exception handling
- (UIViewController * _Nullable)errorWith:(NSString * _Nullable)msg {
    __block UIViewController * errorViewController = [[UIViewController alloc] init];
    errorViewController.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height / 2);
    label.text = [NSString stringWithFormat:@"404\n\n%@",msg];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:24];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText = [self sn_404_fromString:label.text];
    CGPoint center = errorViewController.view.center;
    center.y = center.y - 48;
    label.center = center;
    [errorViewController.view addSubview:label];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), label.bounds.size.width, 48);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [errorViewController.view addSubview:button];
    
    objc_setAssociatedObject(button, &kSNMediatorConfigErrorController, errorViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
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
- (void)handleBackButton:(UIButton *)sender {
    UIViewController * vc = objc_getAssociatedObject(sender, &kSNMediatorConfigErrorController);
    if (vc.navigationController) {
        [vc.navigationController popViewControllerAnimated:YES];
    } else {
        [vc dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (NSMutableAttributedString *)sn_404_fromString:(NSString *)fromString {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:fromString];
    
    NSRange range = [fromString rangeOfString:@"404" options:NSBackwardsSearch];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:48] range:range];
    
    return attributedStr;
}

@end
