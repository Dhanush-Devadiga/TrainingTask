//
//  ManageTournamentsViewController.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 29/12/22.
//

import UIKit

class ManageTournamentsViewController: UIViewController {

    let manageViewModel = ManageMatchViewModel()
    let homeViewModel = HomeViewModel.shared
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manageViewModel.getAllTournaments { isSuccess, error in
            DispatchQueue.main.async {
                if isSuccess {
                    self.tableView.reloadData()
                }
            }
        }
    }
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension ManageTournamentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manageViewModel.tournaments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tournamentsCell") as? HomeTableViewCell
        cell?.designCell()
        cell?.delagate = self
        cell?.setData(data: manageViewModel.tournaments[indexPath.row])
        cell?.manage.tag = indexPath.row
        cell?.view.tag = indexPath.row
        return cell!
    }
}

extension ManageTournamentsViewController: ManageOrView {
    func manageTapped(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManageViewController") as? ManageViewController
        guard  let tournamentVc = vc else {
            return
        }
        homeViewModel.currentTournamentId = manageViewModel.tournaments[index].id
        vc?.currentTournament = manageViewModel.tournaments[index]
        navigationController?.pushViewController(tournamentVc, animated: true)
    }
    
    func viewTapped(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewMatchPageController") as? ViewMatchPageController
        guard  let tournamentVc = vc else {
            return
        }
        homeViewModel.currentTournamentId = manageViewModel.tournaments[index].id
        navigationController?.pushViewController(tournamentVc, animated: true)
    }
    
}
