//
//  ThemeManager.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//
import UIKit

//singleton since only one theme for whole app
final class ThemeManager {
    static let shared = ThemeManager()
    
    var currentTheme: Theme = Theme()
    
    private init() { }
    
    func apply(theme: Theme) {
        apply(colorTheme: theme.colorTheme)
        apply(fontTheme: theme.fontTheme)
        apply(dimensionTheme: theme.dimensionTheme)
        currentTheme = theme
    }
    
    private func apply(colorTheme: ColorTheme) {
        UIView.appearance().backgroundColor = colorTheme.light
    }
    
    private func apply(fontTheme: FontTheme) {
        
    }
    
    private func apply(dimensionTheme: DimensionTheme) {
        let margins = dimensionTheme.margins
        UIView.appearance().layoutMargins = UIEdgeInsets(top: margins,
                                                         left: margins,
                                                         bottom: margins,
                                                         right: margins)
    }
}
