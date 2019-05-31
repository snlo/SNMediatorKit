//
//  SNMediator.m
//  AiteCube
//
//  Created by snlo on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "SNMediator.h"
#import <objc/runtime.h>

#import "SNMediatorTool.h"

@interface SNMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

#pragma mark -- singleton

@implementation SNMediator

static id instanse;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onesToken;
    dispatch_once(&onesToken, ^{
        instanse = [super allocWithZone:zone];
    });
    return instanse;
}
+ (instancetype)shared {
    static dispatch_once_t onestoken;
    dispatch_once(&onestoken, ^{
        instanse = [[self alloc] init];
    });
    return instanse;
}
- (id)copyWithZone:(NSZone *)zone {
    return instanse;
};

#pragma mark -- public method

- (id _Nullable)sn_mediatorForUrl:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion {
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    NSString * urlString = [url query];
    
    for (NSString * param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray * components = [param componentsSeparatedByString:@"="];
        if ([components count] < 2) {
            continue;
        }
        [parameters setObject:[components lastObject] forKey:[components firstObject]];
    }
    NSString * actionMethodString = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    /*
     safety logic
     */
    if ([actionMethodString hasPrefix:@"native"]) {
        return @(NO);
    }
    
    /*
     rational logic : target-action
     */
    id responseObject = [self sn_mediatorForAction:actionMethodString param:parameters target:url.host cache:NO];
    
    if (completion) {
        if (responseObject) {
            completion(@{@"result":responseObject});
        } else {
            completion(nil);
        }
    }
    return responseObject;
}

- (id _Nullable)sn_mediatorForAction:(nonnull NSString *)actionName param:(nullable NSDictionary *)param target:(nonnull NSString *)targetName cache:(BOOL)cache {
    
    NSString * targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    NSString * actionMethodString = [NSString stringWithFormat:@"Action_%@:", actionName];
    Class targetClass;
    
    NSObject * target = SNMediator.shared.cachedTarget[targetClassString];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    if (target == nil) {
        NSString * swiftModuleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
        
        targetClassString = [NSString stringWithFormat:@"%@.Target_%@", swiftModuleName, targetName];
        
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    if (target == nil) {
        /*
         exception handling
         */
        return nil;
    }
    
    SEL action = NSSelectorFromString(actionMethodString);
    
    if (cache) {
        SNMediator.shared.cachedTarget[targetClassString] = target;
    }
    
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:param];
    } else {
        /*
         compatible with swift
         */
        actionMethodString = [NSString stringWithFormat:@"Action_%@WithParams:", actionName];
        action = NSSelectorFromString(actionMethodString);
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target params:param];
        } else {
            SEL action = NSSelectorFromString(@"notFound:");
            if ([target respondsToSelector:action]) {
                return [self safePerformAction:action target:target params:param];
            } else {
                /*
                 exception handling
                 */
                [self.cachedTarget removeObjectForKey:targetClassString];
                return [SNMediator mediatErrorViewController];
                return nil;
            }
        }
    }
}

- (void)releaseCachedTarget:(NSString *)name {
    NSString * targetClassString = [NSString stringWithFormat:@"Target_%@", name];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - private methods
- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    NSMethodSignature * methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char * retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

+ (UIViewController *)mediatErrorViewController {
    __block UIViewController * errorViewController = [[UIViewController alloc] init];
    errorViewController.view.backgroundColor = [UIColor redColor];
//    [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:@"相关功能敬请期待，感谢您的支持" chooseBlock:^(NSInteger actionIndx) {
//        [errorViewController dismissViewControllerAnimated:YES completion:^{
//
//        }];
//    } actionsStatement:@"确认", nil];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"hsdsfsdf" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:cancelAction];
    
    
    return errorViewController;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget {
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end


