//
//  Target_Test.m
//  SNMediator
//
//  Created by snlo on 2018/5/7.
//  Copyright © 2018年 snlo. All rights reserved.
//

#import "Target_Test.h"

@implementation Target_Test

//- (RACSubject *)Action_nativeTestSignal:(NSDictionary *)params {
//	
////	return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
////
////		[subscriber sendNext:@"haha"];
////		[subscriber sendCompleted];
////
////		return nil;
////	}];
//	
////	RACCommand * com = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
////		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
////			 [subscriber sendNext:@"ok"];
////			 [subscriber sendCompleted];
////			return nil;
////		}];
////	}];
////
////	return com;
//	
//	RACSubject * sub = [RACSubject subject];
//
////	[sub sendNext:@"hihi"];
////	[sub sendCompleted];
//
//	[sub subscribeNext:^(id  _Nullable x) {
//		NSLog(@"AAAAAAA---A-A--A-A-A-A--A%@",x);
//	}];
//	[sub sendNext:@"xxx"];
//
//	return sub;
//	
//}

- (UIViewController *)Action_nativeTestViewController:(NSDictionary *)params {
	UIViewController * vc = [[UIViewController alloc] init];
	vc.view.backgroundColor = [UIColor redColor];
	return vc;
}

@end
