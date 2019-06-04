//
//  SNMediatorConfig.h
//  SNMediatorKit
//
//  Created by snlo on 2019/6/3.
//  Copyright © 2019 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 应该只有一个子类配置文件
 */
@interface SNMediatorConfig : NSObject

/**
 未找到界面处理，可在子类中重写

 @param param {
 code:
 data:{action: param: target:}
 msg:
 }
 @return 任意类型，建议为‘UIViewController’
 */
- (id _Nullable)notFound:(NSDictionary * _Nullable)param;

/**
 错误提示，DEBUG模式下只弹窗，可在子类中重写

 @param msg 提示语
 @return 错误提示界面
 */
- (UIViewController * _Nullable)errorWith:(NSString * _Nullable)msg;

/**
 本机安全监测，可在子类中重写
 
 @param param @{ url:scheme://[target]/[action]?[params] }
 @return 是否通过
 */
- (BOOL)safeLogicUrl:(NSDictionary * _Nullable)param;

@end
