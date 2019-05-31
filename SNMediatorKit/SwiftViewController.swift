//
//  SwiftViewController.swift
//  SNMediatorKit
//
//  Created by snlo on 2019/5/31.
//  Copyright © 2019 snlo. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "SNMediator"
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier: String? = self.description
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier!)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier!)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier!)
        }
        
        switch indexPath.row {
        case 0: cell?.textLabel?.text = "OC_mediator"
            break
        case 1: cell?.textLabel?.text = "Swift_mediator"
            break
        case 2: cell?.textLabel?.text = "Action"
            break
        case 3: cell?.textLabel?.text = "Action does not exist"
            break
        case 4: cell?.textLabel?.text = "Target does not exist"
            break
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var viewController: UIViewController! = nil
        
        switch indexPath.row {
        case 0:
            viewController = sn_mediator(forAction: "nativeTestViewController", param: nil, target: "kTest", cache: false) as? UIViewController
            break
        case 1:
            viewController = sn_mediator(forAction: "nativeFetchSwiftViewController", param: nil, target: "kTestSwift", cache: false) as? UIViewController
            break
        case 2:
            sn_mediator(forAction: "nativeTest", param: nil, target: "kTest", cache: false)
            break
        case 3:
            viewController = sn_mediator(forAction: "", param: nil, target: "kTestSwift", cache: false) as? UIViewController
            break
        case 4:
            viewController = sn_mediator(forAction: "nativeFetchSwiftViewController", param: nil, target: "", cache: false) as? UIViewController
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let _ = viewController else {return}
        navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
    

}
