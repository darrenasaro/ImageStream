//
//  KernedLabel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

/// A Label with custom styles
class Label: UILabel {
    /// Adjusted to account for attributed text
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let newWidth = attributedText?.size().width ?? originalSize.width
        return CGSize(width: newWidth+1, height: originalSize.height)
    }

    private let style: Style
    
    init(style: Style) {
        self.style = style
        super.init(frame: CGRect())
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = ThemeManager.color.dark
        
        switch style {
        case .titleBig: font = ThemeManager.font.largeBold
        case .titleSmall: font = ThemeManager.font.smallBold
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        switch style {
        case .titleBig:
            kern(ThemeManager.font.kerning)
            invalidateIntrinsicContentSize()
        case .titleSmall:
            break
        }
    }
}

extension Label {
    enum Style {
        case titleBig
        case titleSmall
    }
}
