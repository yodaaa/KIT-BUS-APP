//
//  ViewController.swift
//  KIT-BUS-APP
//
//  Created by yodaaa on 2018/10/16.
//  Copyright © 2018年 yodaaa. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self as UIPageViewControllerDataSource
    }
    
    func getFirst() -> YViewController {
        return storyboard!.instantiateViewController(withIdentifier: "YViewController") as! YViewController
    }
    
    func getSecond() -> OViewController {
        return storyboard!.instantiateViewController(withIdentifier: "OViewController") as! OViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: OViewController.self) {
            return getFirst()
        } else {
            return getSecond()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: YViewController.self) {
            return getSecond()
        } else {
            return getFirst()
        }
    }
}

