//
//  SNMediatorTool.h
//  SNMediator
//
//  Created by sunDong on 2018/5/7.
//  Copyright © 2018年 snloveydus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <SNTool.h>

__attribute__((objc_subclassing_restricted))

singletonInterface(SNMediatorTool)

@property (nonatomic, strong) UIColor * contentColor;

@property (nonatomic, strong) UIColor * blackColor;


@end
