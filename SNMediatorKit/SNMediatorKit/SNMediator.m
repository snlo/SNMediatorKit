//
//  SNMediator.m
//  AiteCube
//
//  Created by snlo on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import "SNMediator.h"
#import <objc/runtime.h>

NSString * const kSNMediatorMoudleName = @"kSNMediatorMoudleName";
NSString * const kSNMediatorSafeUrl = @"safeLogicUrl:";
NSString * const kSNMediatorNotFound = @"notFound:";
NSString * const kSNMediatorConfig = @"SNMediatorConfig";

@interface SNMediator ()

@property (nonatomic, strong) NSMutableDictionary * cachedTarget;

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

- (id _Nullable)sn_mediator:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion {
    
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
        return [self errorNotFound:url.host action:actionMethodString param:parameters msg:@"It's not legal ！" code:@"400"];
    }
    if (![[self safePerformAction:NSSelectorFromString(kSNMediatorSafeUrl) target:[self getSubclassesFrom:[[NSClassFromString(kSNMediatorConfig) alloc] init]] params:@{@"url":url}] boolValue]) {
        
        return [self errorNotFound:url.host action:actionMethodString param:parameters msg:@"Failure to pass security monitoring ！" code:@"400"];
    }
    
    /*
     rational logic : target-action
     */
    id responseObject = [self sn_mediator:actionMethodString param:parameters target:url.host cache:NO];
    
    if (completion) {
        if (responseObject) {
            completion(@{@"result":responseObject});
        } else {
            completion(nil);
        }
    }
    return responseObject;
}

- (id _Nullable)sn_mediator:(nonnull NSString *)action param:(nullable NSDictionary *)param target:(nonnull NSString *)target cache:(BOOL)cache {
    
    NSString * targetClassString = [NSString stringWithFormat:@"Target_%@", target];
    NSString * actionMethodString = [NSString stringWithFormat:@"Action_%@:", action];
    Class targetClass;
    
    NSObject * target_obj = SNMediator.shared.cachedTarget[targetClassString];
    
    if (target_obj == nil) {
        targetClass = NSClassFromString(targetClassString);
        target_obj = [[targetClass alloc] init];
    }
    
    if (target_obj == nil) {
        NSString * swiftModuleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
        if (param[kSNMediatorMoudleName]) {
            swiftModuleName = param[kSNMediatorMoudleName];
        }
        targetClassString = [NSString stringWithFormat:@"%@.Target_%@", swiftModuleName, target];
        
        targetClass = NSClassFromString(targetClassString);
        target_obj = [[targetClass alloc] init];
    }
    
    SEL action_sel = NSSelectorFromString(actionMethodString);
    
    if (target_obj == nil) {
        return [self errorNotFound:targetClassString action:actionMethodString param:param msg:@"not found target" code:@"404"];
    }
    
    if (cache) {
        SNMediator.shared.cachedTarget[targetClassString] = target_obj;
    }
    
    if ([target_obj respondsToSelector:action_sel]) {
        return [self safePerformAction:action_sel target:target_obj params:param];
        
    } else {
        [self.cachedTarget removeObjectForKey:targetClassString];
        return [self errorNotFound:targetClassString action:actionMethodString param:param msg:@"not found action" code:@"404"];
    }
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

- (void)releaseCachedTarget:(NSString *)name {
    NSString * targetClassString = [NSString stringWithFormat:@"Target_%@", name];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

- (id)errorNotFound:(NSString *)targetString action:(NSString *)actionString param:(NSDictionary *)param msg:(NSString *)msg code:(NSString *)code {
    
    NSObject * target = [[NSClassFromString(kSNMediatorConfig) alloc] init];
    SEL action = NSSelectorFromString(kSNMediatorNotFound);
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:code forKey:@"code"];
    [params setValue:msg forKey:@"msg"];
    [params setValue:@{@"target":targetString, @"action":actionString, @"param":(param?:@"nil")} forKey:@"data"];
    
    target = [self getSubclassesFrom:target];
    
    return [self safePerformAction:action target:target params:params];
}

- (NSObject *)getSubclassesFrom:(NSObject *)object {
    if (self.config) {
        return (NSObject *)self.config;
    }
    self.config = (SNMediatorConfig *)object;
    unsigned int outCount;
    Class * classes = objc_copyClassList(&outCount);
    for (int i = 0; i < outCount; i++) {
        if (class_getSuperclass(classes[i]) == [object class]){
            self.config = (SNMediatorConfig *)[[NSClassFromString(NSStringFromClass(classes[i])) alloc] init];
            break;
        }
    }
    free(classes);
    return (NSObject *)self.config;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget {
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end


