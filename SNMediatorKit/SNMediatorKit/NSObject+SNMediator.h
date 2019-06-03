//
//  NSObject+SNMediator.h
//  SNMediatorKit
//
//  Created by snlo on 2019/5/31.
//  Copyright © 2019 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (SNMediator)

/**
 远程调度
 
 @param url scheme://[target]/[action]?[params]
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
 未找到相关‘Action’,用于子类继承

 @param param 包含该‘Action’相关信息
 @return 自定义
 */
- (id _Nullable)notFoundAction:(id _Nullable)param;


@end
