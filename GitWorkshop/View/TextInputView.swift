//
//  TextInputView.swift
//  GitWorkshop
//
//  Created by David Para on 12/2/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

protocol TextInputViewDelegate: class {
    func textInputView(_ textInputView: TextInputView, didSubmit input: String)
    func textInputView(_ textInputView: TextInputView, textInputDidChangeTo input: String)
}

class TextInputView: UIView {

    // MARK: - Public Properties
    
    public weak var delegate: TextInputViewDelegate?
    
    public var text: String? {
        get { return textFieldUserInput.text }
        set { textFieldUserInput.text = newValue}
    }
    
    public var placeholder: String? {
        get { return textFieldUserInput.placeholder }
        set { textFieldUserInput.placeholder = newValue }
    }

    // MARK: - Private Properties
    
    lazy private var textFieldUserInput: UITextField = {
        let newTextField = UITextField()
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        newTextField.returnKeyType = .go
        newTextField.font = Theme.Font.body
        newTextField.borderStyle = .none
        newTextField.clearButtonMode = .whileEditing // TODO: - Remove this line
        newTextField.delegate = self
        newTextField.addTarget(self, action: #selector(textInputDidChange), for: .editingChanged)
        return newTextField
    }()
    
    lazy private var buttonGo: UIButton = {
        let newButton = UIButton()
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.clipsToBounds = true
        newButton.setImage(#imageLiteral(resourceName: "NextArrowSquareBlue"), for: .normal) // TODO: - Change image (double tap on first parameter)
        newButton.addTarget(self, action: #selector(goPressed), for: .touchUpInside)
        newButton.layer.cornerRadius = 4
        return newButton
    }()
    
    // MARK: - Override Properties
    
    override var isFirstResponder: Bool {
        get { return textFieldUserInput.isFirstResponder }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override Functions
    
    override func becomeFirstResponder() -> Bool {
        return textFieldUserInput.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textFieldUserInput.resignFirstResponder()
    }
    
    // MARK: - Private Functions
    
    private func configureViews() {
        configureView()
        configureTextFieldUserInput()
        configureButtonGo()
        layoutAndConstrainSubviews()
    }
    
    private func configureView() {
        layer.cornerRadius = 4
    }
    
    private func configureTextFieldUserInput() {
        addSubview(textFieldUserInput)
    }
    
    private func configureButtonGo() {
        addSubview(buttonGo)
    }
    
    private func layoutAndConstrainSubviews() {
        NSLayoutConstraint.activate([
            textFieldUserInput.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textFieldUserInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textFieldUserInput.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            ])
        
        // Constrain Next Button
        NSLayoutConstraint.activate([
            buttonGo.topAnchor.constraint(equalTo: textFieldUserInput.topAnchor),
            buttonGo.leadingAnchor.constraint(equalTo: textFieldUserInput.trailingAnchor, constant: 5),
            buttonGo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            buttonGo.bottomAnchor.constraint(equalTo: textFieldUserInput.bottomAnchor),
            buttonGo.heightAnchor.constraint(equalTo: buttonGo.widthAnchor)
            ])
    }
    
    // MARK: - Initializers
    
    @objc private func goPressed() {
        textFieldUserInput.resignFirstResponder()
        delegate?.textInputView(self, didSubmit: text ?? "")
    }
    
    @objc private func textInputDidChange() {
        delegate?.textInputView(self, textInputDidChangeTo: text ?? "")
    }
}

extension TextInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goPressed()
        return true
    }
}
