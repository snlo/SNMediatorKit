//
//  NSObject+SNMediator.m
//  SNMediatorKit
//
//  Created by snlo on 2019/5/31.
//  Copyright © 2019 snlo. All rights reserved.
//

#import "NSObject+SNMediator.h"

#import "SNMediator.h"

@implementation NSObject (SNMediator)

- (id _Nullable)sn_mediatorForUrl:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion {
    return [SNMediator.shared sn_mediatorForUrl:url completion:completion];
}

- (id _Nullable)sn_mediatorForAction:(nonnull NSString *)actionName param:(nullable NSDictionary *)param target:(nonnull NSString *)targetName cache:(BOOL)cache {

    return [SNMediator.shared sn_mediatorForAction:actionName param:param target:targetName cache:cache];
}

- (id _Nullable)notFoundAction:(id _Nullable)param {
#if DEBUG
    NSLog(@"%@",param);
#endif
    return nil;
}

@end
