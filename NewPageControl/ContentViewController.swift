//
//  ContentViewController.swift
//  NewPageControl
//
//  Created by admin on 17/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        initChildVC()
    }
    
    func initChildVC() {
        
        var vcs = [UIViewController]()
        let one = OneViewController()
        let two = TwoViewController()
        let three = ThreeViewController()
        let four = FourViewController()
        let five = FiveViewController()
        vcs.append(one)
        vcs.append(two)
        vcs.append(three)
        vcs.append(four)
        vcs.append(five)
        
        let strs = ["第一","第二","第三","第四","第五"]
        
        let rect = CGRect(x: 50, y: 100, width: 300, height: 500)
        
        let chVC = ChilddViewController(viewCons: vcs, titles: strs, index: 2, rect: rect, clickComplete: { (vc, str) in
            //print(vc)
            //print(str)
            
            if vc.isKind(of: OneViewController.classForCoder()) {
                print("one")
            }
            
            
        }) { (vc, str) in
            //print(vc)
            //print(str)
        }
        chVC.view.frame = rect
        addChildViewController(chVC)
        view.addSubview(chVC.view)
        
        
        
    }
    
    
    
}
