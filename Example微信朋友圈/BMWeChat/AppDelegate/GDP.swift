//
//  fds.swift
//  BMWeChat
//
//  Created by mac on 2020/7/7.
//  Copyright © 2020 梁大红. All rights reserved.
//

import Foundation
import GDPerformanceView_Swift

class GDP: NSObject {
    @objc static func start() -> Void {
        PerformanceMonitor.shared().start()
    }
}
