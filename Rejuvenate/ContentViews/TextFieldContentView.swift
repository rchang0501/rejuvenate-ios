//
//  TextFieldContentView.swift
//  Rejuvenate
//
//  Created by Ryan Chang on 2022-03-25.
//

import UIKit

// custom text field subclass of UIView
// conforming to UIContentView protocol signals that this view renders the content and styling that's defined in UIContentConfiguration+Stateless.swift
class TextFieldContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }
    
    let textField = UITextField()
    var configuration: UIContentConfiguration { // variable that stores the custom content configuration
        // observer to call the configure function to the configuration property
        didSet {
            configure(configuration: configuration)
        }
    }
        
    // hard set the content size
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration){
        self.configuration = configuration // assign the custom content configuration
        
        super.init(frame: .zero)
        
        // pins the suvview and provides left and right padding
        // top and bottom padding set to 0 forces the texfield to span the entire height of the superview
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        textField.clearButtonMode = .whileEditing // creates a trialing clear button in the textview when there is content to clear 
    }
    
    // UIView subclasses that implement custom initializers must also use init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return } // cast configuraiton as a TextFieldContentView.Configuration, otherwise, return to the function calling point
        textField.text = configuration.text // assign the text field text to whatever was in the configuration ("" initially but whatever else when they start typing)
        
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
}
