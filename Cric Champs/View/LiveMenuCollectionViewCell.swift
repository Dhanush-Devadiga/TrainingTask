//
//  LiveMenuCollectionViewCell.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

class LiveMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var selectionIndicator: UIView!
    
    override var isSelected: Bool {
            didSet {
                self.selectionIndicator.backgroundColor = isSelected ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) : #colorLiteral(red: 0.03137254902, green: 0.5058823529, blue: 0.9019607843, alpha: 1)
            }
        }
    
}
