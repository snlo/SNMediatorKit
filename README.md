# SNMediatorKit
模块化中间件，有助于本地模块间解耦甚至是相互独立。利用它可以实现模块间通信和调度，并且支持本地和远程，还提供通信和调度的本地缓存。

#### 常用两个高阶API

```objective-c
/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param action 事件名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 可能是'UIViewController'、‘UIView’、‘NSDictionary’、‘NSMutableDictionary’、‘NSArray’、‘NSMutableArray’、‘NSNumber’、‘NSSet’、‘NSMutableSet’、‘NSString’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url acrion:(NSString *)action params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 调度辅助函数，会包含一些特殊处理
 
 @param module 本地组件名
 @param url 远程调度链接
 @param signal signal:信号名
 @param params 附带参数
 @param shouldCacheTarget 是否缓存本地组件名
 @return 返回信号‘RACSignal’、‘RACCommand’、‘RACSubject’
 */
+ (id)mediateModule:(NSString *)module url:(NSURL *)url signal:(NSString *)signal params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget __attribute__((warn_unused_result));
```

