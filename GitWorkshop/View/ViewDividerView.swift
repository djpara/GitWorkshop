//
//  ViewDividerView.swift
//  GitWorkshop
//
//  Created by David Para on 11/28/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class ViewDividerView: UIView {
    
    // MARK: - Initializers
    
    convenience init(_ dividerBackgroundColor: UIColor = UIColor.black) {
        self.init()
        backgroundColor = dividerBackgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Properties
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    // TODO - : Remove commented code below

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
