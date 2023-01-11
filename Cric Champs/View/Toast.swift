//
//  Toast.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 22/12/22.
//

import Foundation
import UIKit

class Toast: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeToFit = super.sizeThatFits(size)
        let width = sizeToFit.width + 20
        let height = sizeToFit.height + 20
        return CGSize(width: width, height: height)
    }
    
    func showToastMessage(message: String) -> Toast {
        self.text = message
        self.sizeToFit()
        self.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.textAlignment = .center
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        return self
    }
    
    
}
