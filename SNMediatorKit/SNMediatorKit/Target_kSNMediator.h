//
//  Target_kSNMediator.h
//  SNMediatorKit
//
//  Created by snlo on 2019/6/3.
//  Copyright © 2019 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SNMediatorProtocol.h"

@interface Target_kSNMediator : NSObject <SNMediatorProtocol>

- (id)Action_nativeNotFound:(NSDictionary *)param;

- (BOOL)Avtion_nativeSafeMediatorUrl:(NSDictionary *)param;

@end
