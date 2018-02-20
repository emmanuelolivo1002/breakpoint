//
//  ShadowView.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    // Setup shadow properties
    func setupView() {
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.75
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
  
    

}
