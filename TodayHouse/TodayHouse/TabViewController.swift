//
//  TabViewController.swift
//  TodayHouse
//
//  Created by 한상진 on 2021/07/29.
//

//import UIKit
//import SPMManager
//
//import Tabman
//import Pageboy
//
//public final class TabViewController: TabmanViewController {
//    
//    private var viewControllers: [UIViewController] = [
//        UIViewController(),
//        UIViewController(),
//        UIViewController(),
//        UIViewController()
//    ]
//    
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.delegate = self
//        
//        let bar = TMBar.ButtonBar()
//        bar.layout.transitionStyle = .snap
//        
//        self.addBar(bar, dataSource: self, at: .top)
//    }
//}
//
//extension TabViewController: PageboyViewControllerDataSource {
//    public func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
//        return viewControllers.count
//    }
//    
//    public func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
//        return viewControllers[index]
//    }
//    
//    public func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        return nil
//    }
//}
//
//extension TabViewController: TMBarDataSource {
//    public func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
//        let title = "Page \(index)"
//        return TMBarItem(title: title)
//    }
//}
