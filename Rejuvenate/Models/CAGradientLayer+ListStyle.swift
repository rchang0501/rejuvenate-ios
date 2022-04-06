//
//  CAGradientLayer+ListStyle.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-04-05.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style {
        case .all:
            beginColor = .rejuvenateGradientAllBegin
            endColor = .rejuvenateGradientAllEnd
        case .future:
            beginColor = .rejuvenateGradientFutureBegin
            endColor = .rejuvenateGradientFutureEnd
        case .today:
            beginColor = .rejuvenateGradientTodayBegin
            endColor = .rejuvenateGradientTodayEnd
        }
        return [beginColor.cgColor, endColor.cgColor]
    }
}
