//
//  SwiftTestVC.swift
//  UITableViewDynamicLayoutCacheHeight_Example
//
//  Created by liangdahong on 2020/6/30.
//  Copyright © 2020 ios@liangdahong.com. All rights reserved.
//

import UIKit

class SwiftTestVC: UIViewController {
    lazy var dataSourceArray: [String] = {
        var arr = [String]()
        for i in 0..<30 {
            var str = ""
            var arc = arc4random_uniform(20) + 1
            while arc > 0 {
                str.append("我的内容")
                arc -= 1
            }
            arr.append(str)
        }
        return arr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Cell"
    }
}
