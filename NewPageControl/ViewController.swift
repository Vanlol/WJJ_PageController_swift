//
//  ViewController.swift
//  NewPageControl
//
//  Created by admin on 17/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.green
        btn.frame = CGRect(x: 100, y: 200, width: 80, height: 80)
        btn.setTitle("ssss", for: .normal)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        view.addSubview(btn)
        
    }
    
    func btnClick(_ sender: Any) {
        
        let vc = ContentViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}

