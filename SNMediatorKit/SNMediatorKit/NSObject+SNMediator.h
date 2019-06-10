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
- (id _Nullable)sn_mediator:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion;

/**
 本机调度
 
 @param action 执行目标函数名
 @param param 参数
 @param target 执行目标名
 @param cache 是否缓存执行目标
 @return 任意对象，可为空值
 */
- (id _Nullable)sn_mediator:(nonnull NSString *)action param:(nullable NSDictionary *)param target:(nonnull NSString *)target cache:(BOOL)cache;


@end
