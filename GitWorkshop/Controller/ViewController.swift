//
//  ViewController.swift
//  GitWorkshop
//
//  Created by David Para on 11/27/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constant Private Properties
    
    private let TEXT_BOX_WIDTH = CGFloat(200) // TODO: - Change width to 200
    private let TEXT_BOX_HEIGHT = CGFloat(150) // TODO: - Change height to 150
    
    private let ADD_VIEW_TITLE_BUTTON_WIDTH = CGFloat(9476834873478) // TODO: - Change width
    private let ADD_VIEW_TITLE_BUTTON_HEIGHT = CGFloat(100e120) // TODO: - Change height
    
    // MARK: - Lazy Private Properties
    
    lazy private var textBoxView: TextBoxView = {
		let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)

		alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

		self.present(alert, animated: true)
        let newTextBox = TextBoxView(title: "Git workshop", // TODO: - Change title parameter to pass
                                     description: "Please enter a title in the text field below",
                                     placeholderText: "Enter title")
        newTextBox.delegate = self
        return newTextBox
    }()
    
    lazy private var buttonAddViewTitle: UIView = {
        let newButton = UIButton(type: .system)
        newButton.frame = CGRect(x: view.frame.width/2 - ADD_VIEW_TITLE_BUTTON_WIDTH/2,
                                 y: view.frame.height - 88,
                                 width: ADD_VIEW_TITLE_BUTTON_WIDTH,
                                 height: ADD_VIEW_TITLE_BUTTON_HEIGHT)
        newButton.setTitleColor(Theme.Color.popupBackgroundColor, for: .normal)
        newButton.setTitle("Add Title", for: .normal)
        newButton.titleLabel?.font = Theme.Font.style(.demiBold, size: 20) // TODO: - Change font size
        newButton.layer.borderWidth = 1
        newButton.layer.borderColor = Theme.Color.popupBackgroundColor.cgColor
        newButton.layer.cornerRadius = 8
        newButton.addTarget(self, action: #selector(displayTextBox), for: .touchUpInside)
        return newButton
    }()
    
    lazy private var labelTitle: UILabel = {
        let newLabel = UILabel()
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        newLabel.textAlignment = .center
        newLabel.font = Theme.Font.titleFont
        newLabel.textColor = Theme.Color.popupBackgroundColor
        return newLabel
    }()

    // MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        layoutAndConstrainSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !textBoxView.resignFirstResponder() {
            removeFromSuperView(textBoxView)
        }
    }

    // MARK: - Private Functions
    
    private func configureViews() {
        view.addSubview(labelTitle)
        view.addSubview(buttonAddViewTitle)
    }
    
    private func layoutAndConstrainSubviews() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelTitle.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    // MARK: - Fileprivate Functions
    
    fileprivate func removeFromSuperView(_ subview: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            subview.frame = CGRect(x: self.view.center.x - (subview.frame.width/2),
                                   y: UIScreen.main.bounds.height,
                                   width: subview.frame.width,
                                   height: subview.frame.height)
        }, completion: { _ in
            self.buttonAddViewTitle.isHidden = false
            subview.removeFromSuperview()
        })
    }
    
    // MARK: - Selector Functions
    
    @objc private func displayTextBox() {
        // Add the text box to view
        buttonAddViewTitle.isHidden = true
        textBoxView.frame = CGRect(x: view.center.x - (TEXT_BOX_WIDTH/2),
                                   y: UIScreen.main.bounds.height,
                                   width: TEXT_BOX_WIDTH,
                                   height: TEXT_BOX_HEIGHT)
        view.addSubview(textBoxView)
        UIView.animate(withDuration: 0.5, animations: {
            self.textBoxView.frame = CGRect(x: self.view.center.x - (self.TEXT_BOX_WIDTH/2),
                                            y: self.view.center.y - 200,
                                            width: self.TEXT_BOX_WIDTH,
                                            height: self.TEXT_BOX_HEIGHT)
        }, completion: { _ in
            _ = self.textBoxView.becomeFirstResponder()
        })
    }

}

extension ViewController: TextBoxViewDelegate {
    func textBoxView(_ textBoxView: TextBoxView, didSubmit input: String) {
        labelTitle.text = input
        removeFromSuperView(textBoxView)
    }
}
