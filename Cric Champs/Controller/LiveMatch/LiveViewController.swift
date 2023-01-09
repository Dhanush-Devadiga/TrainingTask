//
//  ViewController.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

class LiveViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    var liveViewModel = LiveScoreViweMdoel.shared
    @IBOutlet weak var collectionView: UICollectionView!
    var pageViewController: LiveMatchPageViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teams: UILabel!
    var timer: Timer?
    
    enum LiveMenuTitles: String, CaseIterable {
        case info = "INFO"
        case live = "LIVE"
        case scoreboard = "SCOREBOARD"
        case graph = "GRAPH"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.selectItem(at: [0,0], animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setValueForTeams()
        
    }
    
    private func setValueForTeams() {
        if let match = liveViewModel.currentMatchInfo {
            teams.text = match.teamOne + " Vs " + match.teamTwo
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueLiveViewController")
        {
            if let vc  = segue.destination as? LiveMatchPageViewController {
                self.pageViewController = vc
                vc.swipeDelagate = self
        }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveMenuCell", for: indexPath) as?  LiveMenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.menuTitle.text = LiveMenuTitles.allCases[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pageViewController?.forward(index: indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
   
    @IBAction func didTapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension LiveViewController: SwipeIndex {
    func scrollToIndex(index: Int) {
        collectionView.scrollToItem(at: [0,index], at: .centeredHorizontally, animated: true)
        self.collectionView.selectItem(at: [0,index], animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))

}
}
