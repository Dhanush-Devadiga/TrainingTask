//
//  HomeTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import UIKit

protocol ManageOrView {
    func manageTapped(index: Int)
    func viewTapped(index: Int)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var tournamentCode: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var matchStatus: MatchStatusLabel!
    @IBOutlet weak var view: UIButton!
    
    @IBOutlet weak var manage: UIButton!
    var tournamentId: Int64?
    var delagate: ManageOrView?
    
    func designCell() {
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .white
    }
    
    func setValues(index: Int) {
        if index % 2 == 0 {
            matchStatus.setUpInprogress()
        } else {
            matchStatus.setUpCompleted()
        }
    }
    
    func setData(data: Tournament) {
        tournamentId = data.id
        tournamentCode.text = data.tournamentCode
        tournamentName.text = data.name
        matchStatus.setMatchStatus(status: data.status ?? "")
    }
    
    @IBAction func onClickManage(_ sender: UIButton) {
        delagate?.manageTapped(index: manage.tag)
    }
    
    @IBAction func onClickView(_ sender: Any) {
        delagate?.viewTapped(index: manage.tag)
    }
    
}
