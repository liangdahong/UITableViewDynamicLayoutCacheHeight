//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

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
