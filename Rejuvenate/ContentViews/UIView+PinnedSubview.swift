//
//  UIView+PinnedSubview.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-25.
//

import UIKit

extension UIView {
    // function to add a subview that's pinned to its superview with optional padding
    func addPinnedSubview(_ subview: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subview) // addSubview() is a built-in function in UIView --> it adds the subview to the bottom of the superview's hierarchy
        subview.translatesAutoresizingMaskIntoConstraints = false // this member function attempts to automatically resize subviews so we disable it --> instead we provide our own constraints the dynamically change
        
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true // pins the subview to the top of the superview
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true // adds padding to leading edge
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true // add padding to trailing edge
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true // add padding to bottom
        
        // if an explicit height is passed in, constrain subview to said height 
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
