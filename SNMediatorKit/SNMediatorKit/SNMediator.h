//
//  SNMediator.h
//  AiteCube
//
//  Created by snlo on 2017/9/22.
//  Copyright © 2017年 AiteCube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SNMediatorConfig;

extern NSString * _Nullable const kSNMediatorMoudleName; //它是在'param'中指定swift模块名的‘key’

__attribute__((objc_subclassing_restricted))

__attribute__((objc_runtime_name("snloOXZjGfNl6qhP09")))

@interface SNMediator : NSObject 

/**
 只读的缓存池
 */
@property (nonatomic, readonly) NSMutableDictionary * _Nullable cachedTarget;

/**
 配置文件，有指定某个配置文件子类起作用。建议手动指定配置文件子类。
 */
@property (nonatomic, strong) SNMediatorConfig * _Nullable config;

/**
 构造函数

 @return 单例对象
 */
+ (instancetype _Nonnull)shared;

/**
 远程调度
 
 @param url 链接格式：scheme://[target]/[action]?[params]
 @param completion 执行回调
 @return 任意对象，可为空值
 */
- (id _Nullable)sn_mediatorForUrl:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion;

/**
 本机调度
 
 @param actionName 执行目标函数名
 @param param 参数
 @param targetName 执行目标名
 @param cache 是否缓存执行目标
 @return 任意对象，可为空值
 */
- (id _Nullable)sn_mediatorForAction:(nonnull NSString *)actionName param:(nullable NSDictionary *)param target:(nonnull NSString *)targetName cache:(BOOL)cache;

/**
 释放指定缓存
 */
- (void)releaseCachedTarget:(NSString *_Nonnull)name;


@end
