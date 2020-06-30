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

extension SwiftTestVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SwiftTestCell.bm_tableViewCellFromNib(with: tableView)
        if let cell1 = cell {
            cell1.desc = dataSourceArray[indexPath.row]
            return cell1
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bm_height(withCellClass: SwiftTestCell.self, cacheBy: indexPath) { (cell) in
            if let cell1 = cell as? SwiftTestCell {
                cell1.desc = self.dataSourceArray[indexPath.row]
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
