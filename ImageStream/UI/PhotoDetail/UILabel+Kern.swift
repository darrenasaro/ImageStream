//
//  UILabel+Kern.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func kern(_ kerningValue:CGFloat) {
        guard let font = font, let textColor = textColor else { return }
        let textAttributes = [NSAttributedString.Key.kern: kerningValue,
                              NSAttributedString.Key.font: font,
                              NSAttributedString.Key.foregroundColor: textColor] as [NSAttributedString.Key : Any]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: textAttributes)
    }
}
