//
//  SNMediator.h
//  AiteCube
//
//  Created by snlo on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SNMediatorProtocol.h"


__attribute__((objc_subclassing_restricted))

__attribute__((objc_runtime_name("snloOXZjGfNl6qhP09")))

@interface SNMediator : NSObject <SNMediatorProtocol>

+ (instancetype)sharedManager;

/**
 远程App调用入口
 scheme://[target]/[action]?[params]
 
 url sample:
 http://targetA/actionB?id=1234
 */
- (id)performAction:(NSURL *)url completion:(void(^)(id responseObject))completion;

/**
 本地组件调用入口
 */
- (id)performTarget:(NSString *)name action:(NSString *)actionName params:(NSDictionary *)params cacheTarget:(BOOL)cacheTarget;

/**
 释放指定缓存
 */
- (void)releaseCachedTarget:(NSString *)name;

/**
 扩展(统一API)

 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param cacheTarget 是否缓存本地组件名
 @return 返回任意类型
 */
+ (id)module:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params cacheTarget:(BOOL)cacheTarget;

@end
