
//
//  PureCodeVC.swift
//  Example
//
//  Created by liangdahong on 2020/6/30.
//  Copyright © 2020 liangdahong. All rights reserved.
//

import UIKit

class PureCodeVC: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var dataSourceArray: [String] = {
        var arr = [String]()
        for i in 0..<30 {
            var str = ""
            var arc = arc4random_uniform(20) + 1
            while arc > 0 {
                str.append("我是内容")
                arc -= 1
            }
            arr.append(str)
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "纯代码布局"

        // add tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}

extension PureCodeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PureCodeCell.bm_tableViewCellFromAlloc(with: tableView, style: .default)
        if let cell1 = cell {
            cell1.descName = dataSourceArray[indexPath.row]
            return cell1
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bm_height(withCellClass: PureCodeCell.self, cacheBy: indexPath) { (cell) in
            if let cell1 = cell as? PureCodeCell {
                cell1.descName = self.dataSourceArray[indexPath.row]
            }
        }
    }
}
