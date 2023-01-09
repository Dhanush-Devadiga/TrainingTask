//
//  EmptyDataCell.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 20/12/22.
//

import UIKit

class EmptyDataCell: UITableViewCell {

    @IBOutlet weak var textToDisplay: UILabel!
    func setText(data: String)
    {
        textToDisplay.text = "No \(data) Added Yet!"
    }

}
