//
//  TextBoxView.swift
//  GitWorkshop
//
//  Created by David Para on 11/28/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

protocol TextBoxViewDelegate: class {
    func textBoxView(_ textBoxView: TextBoxView, didSubmit input: String)
}

class TextBoxView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: TextBoxViewDelegate?
    
    // MARK: - Private Properties
    
    private var _title: String? {
        didSet { labelTitle.text = _title }
    }
    
    private var _originalTitle: String?
    private var _description: String?
    private var _placeholderString: String?
    
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
    
    lazy private var textInputView: TextInputView = {
        let newTextInputView = TextInputView()
        newTextInputView.translatesAutoresizingMaskIntoConstraints = false
        newTextInputView.backgroundColor = Theme.Color.backgroundColor
        newTextInputView.delegate = self
        return newTextInputView
    }()
    
    // MARK: - Initializers
    
    convenience init(title: String, description: String? = nil, placeholderText: String? = nil) {
        self.init()
        _originalTitle = title
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
    
    override func becomeFirstResponder() -> Bool {
        return textInputView.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textInputView.resignFirstResponder()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if _title == "" { _title = _originalTitle }
    }
    
    // MARK: - Private Functions
    
    /// Configures view and subviews
    private func configureViews() {
        configureView()
        configureLabel(labelTitle, with: _title)
        configureLabel(labelDescription, with: _description)
        configureTextInputView(textInputView, with: _placeholderString)
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
    private func configureTextInputView(_ textInputView: TextInputView, with placeholderString: String? = "") {
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.delegate = self
        textInputView.placeholder = placeholderString
        textInputView.layer.cornerRadius = 4
        addSubview(textInputView)
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
        
        // Constrain Text Field
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 8),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textInputView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textInputView.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    // MARK: - Selector Functions
    
    @objc private func updateTitle() {
        let textCount = textInputView.text?.count ?? 0
        if textCount >= 26 {
            textInputView.text?.removeLast(textCount - 26)
            return
        }
        
        _title = textInputView.text
    }
    
    @objc private func submitTitle() {
        _ = textInputView.resignFirstResponder()
        delegate?.textBoxView(self, didSubmit: textInputView.text ?? "")
    }
}

extension TextBoxView: TextInputViewDelegate {
    func textInputView(_ textInputView: TextInputView, didSubmit input: String) {
        submitTitle()
    }
    func textInputView(_ textInputView: TextInputView, textInputDidChangeTo input: String) {
        updateTitle()
    }
}
