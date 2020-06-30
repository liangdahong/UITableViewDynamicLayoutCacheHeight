//
//  SwiftTestCell.swift
//  UITableViewDynamicLayoutCacheHeight_Example
//
//  Created by liangdahong on 2020/6/30.
//  Copyright © 2020 ios@liangdahong.com. All rights reserved.
//

import UIKit

class SwiftTestCell: UITableViewCell {
    @IBOutlet weak var descLabel: UILabel!
    var desc: String? {
        get {
            return descLabel.text
        }
        set {
            descLabel.text = newValue
        }
    }
}
