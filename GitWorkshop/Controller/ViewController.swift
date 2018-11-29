//
//  ViewController.swift
//  GitWorkshop
//
//  Created by David Para on 11/27/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var textBoxView: TextBoxView = {
        let newTextBox = TextBoxView(title: "Title", description: "Please enter a title in the text field below", placeholderText: "Enter title") // TODO: - Change title parameter to pass
        newTextBox.dataSource = self
        return newTextBox
    }()
    
    lazy private var buttonAddViewTitle: UIView = {
        let newButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 185, y: UIScreen.main.bounds.height - 88, width: 175, height: 44))
        newButton.setTitleColor(Theme.Color.popupBackgroundColor, for: .normal)
        newButton.setTitle("Add Title", for: .normal)
        newButton.titleLabel?.font = Theme.Font.style(.demiBold, size: 18) // TODO: - Change font size
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
        _ = textBoxView.resignFirstResponder()
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
            subview.frame = CGRect(x: self.view.center.x, y: UIScreen.main.bounds.height, width: 0, height: 0)
        }, completion: { _ in
            subview.removeFromSuperview()
        })
    }
    
    // MARK: - Selector Functions
    
    @objc private func displayTextBox() {
        // Add the text box to view
        textBoxView.frame = CGRect(x: self.view.center.x - 100, y: UIScreen.main.bounds.height, width: 200, height: 150)
        view.addSubview(textBoxView)
        UIView.animate(withDuration: 0.5, animations: {
            self.textBoxView.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 200, width: 200, height: 150)
        })
    }

}

extension ViewController: TextBoxViewDataSource {
    func textBoxView(_ textBoxView: TextBoxView, didSubmit input: String) {
        labelTitle.text = input
        removeFromSuperView(textBoxView)
    }
}
