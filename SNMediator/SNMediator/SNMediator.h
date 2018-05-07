//
//  SNMediator.h
//  AiteCube
//
//  Created by sunDong on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__attribute__((objc_subclassing_restricted))

__attribute__((objc_runtime_name("snlo")))

@interface SNMediator : NSObject

+ (instancetype)sharedManager;

/**
 远程App调用入口
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(id responseObject))completion;

/**
 本地组件调用入口
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 释放指定缓存
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

/**
 扩展(统一API,)

 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回任意类型
 */
+ (id)module:(NSString *)module url:(NSURL *)url action:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 可能是'UIViewController'、‘UIView’、‘NSDictionary’、‘NSMutableDictionary’
 */
+ (id)mediatModule:(NSString *)module url:(NSURL *)url acrion:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 调度辅助函数，会包含一些特殊处理

 @param module 本地组件名
 @param url 远程调度链接
 @param signal signal:信号名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回信号‘RACSignal’、‘RACCommand’、‘RACSubject’
 */
+ (id)mediatModule:(NSString *)module url:(NSURL *)url signal:(NSString *)signal params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget __attribute__((warn_unused_result));


@end
