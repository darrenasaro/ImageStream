//
//  ThemeManager.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//
import UIKit

/// Applies and holds a Theme which is consistent across the entire app.
final class ThemeManager {
    
    static let shared = ThemeManager()
    
    var currentTheme: Theme = Theme()
    
    static var color: ColorTheme { return ThemeManager.shared.currentTheme.colorTheme }
    static var font: FontTheme { return ThemeManager.shared.currentTheme.fontTheme }
    static var dimension: DimensionTheme { return ThemeManager.shared.currentTheme.dimensionTheme }
    static var shadow: ShadowTheme { return ThemeManager.shared.currentTheme.shadowTheme }
    
    private init() { }
    
    func apply(theme: Theme) {
        apply(colorTheme: theme.colorTheme)
        apply(fontTheme: theme.fontTheme)
        apply(dimensionTheme: theme.dimensionTheme)
        apply(shadowTheme: theme.shadowTheme)
        currentTheme = theme
    }
    
    private func apply(colorTheme: ColorTheme) {
        //UIView.appearance().backgroundColor = colorTheme.light
        UIView.appearance().layer.shadowColor = colorTheme.dark.cgColor
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
    
    private func apply(shadowTheme: ShadowTheme) {
        UIView.appearance().layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.appearance().layer.shadowRadius = shadowTheme.radius
    }
}
