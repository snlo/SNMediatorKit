//
//  Target_kTestSwift.swift
//  SNMediatorKit
//
//  Created by snlo on 2019/5/31.
//  Copyright © 2019 snlo. All rights reserved.
//

import Foundation
import UIKit

class Target_kTestSwift: NSObject {
    
    @objc func Action_nativeFetchSwiftViewController(_ parmas:[AnyHashable:Any]?) -> UIViewController {
        
        return SwiftViewController.init()
    }
    
    @objc func Action_nativeTest(_ param: [AnyHashable:Any]?) -> Void {
        print("swift bala bala bala")
    }
    
    
}


