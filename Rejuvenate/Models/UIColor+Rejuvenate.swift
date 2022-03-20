//
//  UIColor+Rejuvenate.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-17.
//

import UIKit

extension UIColor {
    static var rejuvenateDetailCellTint: UIColor {
        UIColor(named: "RejuvenateDetailCellTint") ?? .tintColor
    }
    
    static var rejuvenateListCellBackground: UIColor {
        UIColor(named: "RejuvenateListCellBackground") ?? .secondarySystemBackground
    }
    
    static var rejuvenateListCellDoneButtonTint: UIColor {
        UIColor(named: "RejuvenateListCellDoneButtonTint") ?? .tintColor
    }
    
    static var rejuvenateGradientAllBegin: UIColor {
        UIColor(named: "RejuvenateGradientAllBegin") ?? .systemFill
    }
    
    static var rejuvenateGradientAllEnd: UIColor {
        UIColor(named: "RejuvenateGradientAllEnd") ?? .quaternarySystemFill
    }
    
    static var rejuvenateGradientFutureBegin: UIColor {
            UIColor(named: "RejuvenateGradientFutureBegin") ?? .systemFill
    }
    
    static var rejuvenateGradientFutureEnd: UIColor {
            UIColor(named: "RejuvenateGradientFutureEnd") ?? .quaternarySystemFill
    }
    
    static var rejuvenateGradientTodayBegin: UIColor {
            UIColor(named: "RejuvenateGradientTodayBegin") ?? .systemFill
    }
    
    static var rejuvenateGradientTodayEnd: UIColor {
            UIColor(named: "RejuvenateGradientTodayEnd") ?? .quaternarySystemFill
    }
    
    static var rejuvenateNavigationBackground: UIColor {
        UIColor(named: "RejuvenateNavigationBackground") ?? .secondarySystemBackground
    }
    
    static var rejuvenatePrimaryTint: UIColor {
        UIColor(named: "RejuvenatePrimaryTint") ?? .tintColor
    }
    
    static var rejuvenateProgressLowerBackground: UIColor {
        UIColor(named: "RejuvenateProgressLowerBackground") ?? .systemGray
    }
    
    static var rejuvenateProgressUpperBackground: UIColor {
        UIColor(named: "RejuvenateProgressUpperBackground") ?? .systemGray6
    }
}

