//
//  UIContentConfiguration+Stateless.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-25.
//

import UIKit

// and object that conforms to UIContentView requires a configuration property of UIContentConfiguration 
extension UIContentConfiguration {
    // use the default updated for method (not customization requried)
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
