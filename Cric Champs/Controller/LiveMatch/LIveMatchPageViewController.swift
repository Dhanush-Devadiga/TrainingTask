//
//  LIveMatchPageViewController.swift
//  LiveScoreProject
//
//  Created by Dhanush Devadiga on 16/12/22.
//

import UIKit

protocol SwipeIndex {
    func scrollToIndex(index: Int)
}

class LiveMatchPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var swipeDelagate: SwipeIndex?
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        if let startingViewController = contentView(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! LiveMatchContentViewController).index
        swipeDelagate?.scrollToIndex(index: index)
        currentIndex = index
        index -= 1
        return contentView(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! LiveMatchContentViewController).index
        swipeDelagate?.scrollToIndex(index: index)
        currentIndex = index
        index += 1
        return contentView(at: index)
    }

    func contentView(at index: Int) -> LiveMatchContentViewController? {
        if index < 0 || index >= 5 {
            return nil
        }
        if let pageObj = storyboard?.instantiateViewController(withIdentifier: "LiveMatchContentViewController") as? LiveMatchContentViewController {
            pageObj.index = index
            return pageObj
        }
        return nil
    }

    func forward(index: Int) {
        if let nextViewController = contentView(at: index) {
            if index == currentIndex {
                return
            } else if index > currentIndex {
                currentIndex = index
                setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            } else {
                currentIndex = index
                setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
            }
        }
    }
}
