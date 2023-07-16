//
//  UIFont+Creation.swift
//  Pokepedia-iOS
//
//  Created by Василий Клецкин on 7/16/23.
//

import UIKit

extension UIFont {
    static func standard(size: FontSize, weight: Weight) -> UIFont {
        let font = UIFont.monospacedSystemFont(ofSize: size.rawValue, weight: weight)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
}

enum FontSize: CGFloat {
    case title = 15
    case body = 13
    case caption = 10
}
