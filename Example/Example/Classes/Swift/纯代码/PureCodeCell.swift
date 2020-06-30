//
//  PureCodeCell.swift
//  Example
//
//  Created by liangdahong on 2020/6/30.
//  Copyright © 2020 liangdahong. All rights reserved.
//

import UIKit
import SnapKit

class PureCodeCell: UITableViewCell {
    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = .systemFont(ofSize: 15)
        descLabel.textColor = .blue
        descLabel.numberOfLines = .zero
        return descLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // add descLabel
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }

        // 辅助 view，cell 需要的高度就是 linView 的 maxY
        let linView = UIView()
        contentView.addSubview(linView)
        linView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp_bottom).offset(10)
            make.width.left.height.equalTo(0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var descName: String? {
        get {
            descLabel.text
        }
        set {
            descLabel.text = newValue
        }
    }
}
