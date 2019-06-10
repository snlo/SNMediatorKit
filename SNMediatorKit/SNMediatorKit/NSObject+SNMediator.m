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

- (id _Nullable)sn_mediator:(nonnull NSURL *)url completion:(void(^_Nullable)(NSDictionary * _Nullable responseObject))completion {
    return [SNMediator.shared sn_mediator:url completion:completion];
}

- (id _Nullable)sn_mediator:(nonnull NSString *)action param:(nullable NSDictionary *)param target:(nonnull NSString *)target cache:(BOOL)cache {

    return [SNMediator.shared sn_mediator:action param:param target:target cache:cache];
}

@end
