//
//  KernedLabel.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

class Label: UILabel {
    
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
        let fontTheme = ThemeManager.shared.currentTheme.fontTheme
        let colorTheme = ThemeManager.shared.currentTheme.colorTheme
        
        textColor = colorTheme.dark
        
        switch style {
        case .titleBig  : font = fontTheme.largeBold
        case .titleSmall: font = fontTheme.smallBold
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let fontTheme = ThemeManager.shared.currentTheme.fontTheme
        
        switch style {
        case .titleBig:
            kern(fontTheme.kerning)
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
