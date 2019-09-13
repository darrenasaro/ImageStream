//
//  Themes.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/17/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import Foundation
import UIKit

//TODO: Initializers
struct Theme {
    let colorTheme: ColorTheme = ColorTheme()
    let fontTheme: FontTheme = FontTheme()
    let dimensionTheme: DimensionTheme = DimensionTheme()
    let shadowTheme: ShadowTheme = ShadowTheme()
}

struct ColorTheme {
    let light = UIColor(hexString: "#F7FBFF")
    let middle = UIColor(hexString: "#E9F1F9")
    let dark = UIColor(hexString: "#424B54")
}

struct FontTheme {
    let lightFontName = "Avenir-Medium"
    let normalFontName = "Avenir-Heavy"
    let boldFontName = "Avenir-Black"
    
    let smallFontSize: CGFloat = 14
    let largeFontSize: CGFloat = 16
    
    let kerning: CGFloat = 3
    
    var largeBold: UIFont { return UIFont(name: boldFontName, size: largeFontSize)! }
    var smallBold: UIFont { return UIFont(name: boldFontName, size: smallFontSize)! }
    var smallLght: UIFont { return UIFont(name: lightFontName, size: smallFontSize)! }
}

struct DimensionTheme {
    let unit: CGFloat = 10
    var margins: CGFloat {
        return 2*unit
    }
}

struct ShadowTheme {
    let opacity: Float = 0.05
    let radius: CGFloat = 8.0
}
