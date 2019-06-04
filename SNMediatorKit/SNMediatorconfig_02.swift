//
//  SNMediatorconfig_02.swift
//  SNMediatorKit
//
//  Created by snlo on 2019/6/4.
//  Copyright © 2019 snlo. All rights reserved.
//

import UIKit

class SNMediatorconfig_02: SNMediatorConfig {
    override func safeLogicUrl(_ param: [AnyHashable : Any]?) -> Bool {
        print("非法入侵参数：\(param!)")
        return false
    }
}
