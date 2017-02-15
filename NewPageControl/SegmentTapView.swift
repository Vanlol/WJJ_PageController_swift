//
//  SegmentTapView.swift
//  NewPageControl
//
//  Created by admin on 17/2/14.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit


protocol SegmentTapViewDelegate:NSObjectProtocol {
    func selectIndex(index:Int)
}


class SegmentTapView: UIView {
    
    
    weak var delegate:SegmentTapViewDelegate?
    
    var initIndex = 0   //初始化后所在位置
    
    
    var titles:[String]!{
        didSet{
            initSubViews()
        }
    }
    
    var buttons = [UIButton]()
    
    var lineView:UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func initSubViews() {
        
        for btn in subviews {
            btn.removeFromSuperview()
        }
        
        let width = bounds.size.width / CGFloat(titles.count)
        for index in 0..<titles.count {
            let btn = UIButton()
            btn.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: bounds.size.height)
            btn.tag = index + 1
            btn.setTitle(titles[index], for: .normal)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitleColor(UIColor.black, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(tapButtonClick(btn:)), for: .touchDown)
            
            if index == initIndex {
                btn.isSelected = true
            }else{
                btn.isSelected = false
            }
            buttons.append(btn)
            addSubview(btn)
        }
        let button = buttons[initIndex]
        
        let line = UIView()
        line.frame = CGRect(x: 0, y: bounds.size.height - 1, width: 60, height: 1)
        line.center.x = button.center.x
        line.backgroundColor = UIColor.orange
        addSubview(line)
        lineView = line
    }
    //顶部按钮点击事件
    func tapButtonClick(btn:UIButton) {
        
        delegate?.selectIndex(index: btn.tag - 1)
        
    }
    //视图滑动结束之后调用方法
    func scrollEnd(btn:UIButton) {
        for button in buttons {
            if button == btn {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.lineView.center.x = btn.center.x
        }
    }
    //滑动子控制器的时候,线的移动动画
    func changeStatus(index:Int) {
        for button in buttons {
            if index != button.tag {
                button.isSelected = false
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    button.isSelected = true
                    self.lineView.center.x = button.center.x
                })
            }
        }
    }

    
    
}
