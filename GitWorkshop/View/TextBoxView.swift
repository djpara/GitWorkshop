//
//  TextBoxView.swift
//  GitWorkshop
//
//  Created by David Para on 11/28/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

protocol TextBoxViewDataSource: class {
    func textBoxView(_ textBoxView: TextBoxView, didSubmit input: String)
}

class TextBoxView: UIView {
    
    // MARK: - Public Properties
    
    public weak var dataSource: TextBoxViewDataSource?
    
    // MARK: - Private Properties
    
    private var _title: String? {
        didSet { labelTitle.text = _title }
    }
    
    private var _description: String?
    private var _placeholderString: String?
    
    lazy private var textFieldUserInput: UITextField = {
        let newTextField = UITextField()
        newTextField.returnKeyType = .go
        newTextField.font = Theme.Font.body
        newTextField.addTarget(self, action: #selector(updateTitle), for: .editingChanged)
        return newTextField
    }()
    
    lazy private var labelTitle: UILabel = {
        let newLabel = UILabel()
        newLabel.adjustsFontSizeToFitWidth = true
        newLabel.minimumScaleFactor = 0.5
        newLabel.font = Theme.Font.popupTitleFont // TODO: - Change font style
        return newLabel
    }()
    
    lazy private var labelDescription: UILabel = {
        let newLabel = UILabel()
        newLabel.numberOfLines = 0
        newLabel.font = Theme.Font.popupDescriptionFont // TODO: - Change font style
        return newLabel
    }()
    
    lazy private var viewTitleDivider: UIView = {
        let newView = UIView()
        return newView
    }()
    
    // MARK: - Initializers
    
    convenience init(title: String, description: String? = nil, placeholderText: String? = nil) {
        self.init()
        _title = title
        _description = description
        _placeholderString = placeholderText
        
        configureViews()
        layoutAndConstrainSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override Functions
    
    override func resignFirstResponder() -> Bool {
        if textFieldUserInput.isFirstResponder {
            textFieldUserInput.resignFirstResponder()
            return true
        }
        
        return false
    }
    
    // MARK: - Private Functions
    
    /// Configures view and subviews
    private func configureViews() {
        configureView()
        configureLabel(labelTitle, with: _title)
        configureLabel(labelDescription, with: _description)
        configureTextField(textFieldUserInput, with: _placeholderString)
    }
    
    /// Configure view
    private func configureView() {
        backgroundColor = Theme.Color.popupBackgroundColor
        layer.cornerRadius = 10
    }
    
    /// Configure label
    private func configureLabel(_ label: UILabel, with string: String?) {
        guard let string = string else { return }
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.backgroundColor = Theme.Color.popupBackgroundColor
        label.textColor = Theme.Color.popupTextColor
        label.textAlignment = .center
        label.text = string
        addSubview(label)
    }
    
    /// Configure text field
    private func configureTextField(_ textField: UITextField, with placeholderString: String? = "") {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholderString
        addSubview(textField)
    }
    
    /// Lays out optional divider subview when necessary and sets the constraints on all subviews
    private func layoutAndConstrainSubviews() {
        
        var lastBottomAnchor = topAnchor
        
        if _title != nil {
            // Add a divider - to be used between
            let divider = ViewDividerView(Theme.Color.backgroundColor)
            addSubview(divider)
            
            // Constrain Title
            NSLayoutConstraint.activate([
                labelTitle.topAnchor.constraint(equalTo: lastBottomAnchor),
                labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                labelTitle.heightAnchor.constraint(equalToConstant: 44)
                ])
            lastBottomAnchor = labelTitle.bottomAnchor
            // Constrain Divider
            NSLayoutConstraint.activate([
                divider.topAnchor.constraint(equalTo: lastBottomAnchor),
                divider.leadingAnchor.constraint(equalTo: leadingAnchor),
                divider.trailingAnchor.constraint(equalTo: trailingAnchor),
                divider.heightAnchor.constraint(equalToConstant: 2) // TODO: - Change height anchor
                ])
            lastBottomAnchor = divider.bottomAnchor
        }
        
        if _description != nil {
            // Constrain Description
            NSLayoutConstraint.activate([
                labelDescription.topAnchor.constraint(equalTo: lastBottomAnchor),
                labelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
                ])
            lastBottomAnchor = labelDescription.bottomAnchor
        }
        
        // Constrain Description
        NSLayoutConstraint.activate([
            textFieldUserInput.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 8),
            textFieldUserInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textFieldUserInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textFieldUserInput.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textFieldUserInput.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    // MARK: - Selector Functions
    
    @objc private func updateTitle() {
        if textFieldUserInput.text?.count == 26 {
            textFieldUserInput.text?.removeLast()
            return
        }
        
        _title = textFieldUserInput.text
    }
}

extension TextBoxView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dataSource?.textBoxView(self, didSubmit: _title ?? "")
        return true
    }
}


