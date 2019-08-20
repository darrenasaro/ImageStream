//
//  UIView+ApplyShadow.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var hasShadow: Bool {
        set(newValue) {
            layer.shadowOpacity = newValue ? ThemeManager.shared.currentTheme.shadowTheme.opacity : 0
        }
        get {
            return layer.shadowOpacity != 0
        }
    }
}
