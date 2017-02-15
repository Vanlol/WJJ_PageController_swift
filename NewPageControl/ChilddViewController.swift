//
//  ChilddViewController.swift
//  NewPageControl
//
//  Created by admin on 17/2/13.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ChilddViewController: UIViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource,SegmentTapViewDelegate,UIScrollViewDelegate{
    
    
    var clickTapSegment:((_ viewCon:UIViewController,_ segTitle:String) -> Void)?
    var scrollClosure:((_ viewCon:UIViewController,_ segTitle:String) -> Void)?
    
    
    
    var viewControllers:[UIViewController]!
    var segmentTitles:[String]!
    var initIndex:Int!                           //第一次选中那个位置
    var rectBounds:CGRect!                      //否则顶部的tapview的frame位置会变
    
    
    var pageController:UIPageViewController!
    
    
    var segmentTapView:SegmentTapView!
    
    var currentIndex = 0
    
    init(viewCons:[UIViewController],titles:[String],index:Int,rect:CGRect,clickComplete:@escaping ((_ viewCon:UIViewController,_ segTitle:String) -> Void),scrollComplete:@escaping ((_ viewCon:UIViewController,_ segTitle:String) -> Void)) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = viewCons
        segmentTitles = titles
        initIndex = index
        currentIndex = index
        rectBounds = rect
        let count = viewCons.count
        for index in 0..<count {
            let vc = viewCons[index]
            vc.view.tag = index + 1
        }
        
        
        clickTapSegment = clickComplete
        scrollClosure = scrollComplete
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        initSubViews()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //初始化pageViewController和顶部选项卡
    func initSubViews() {
        
        let segView = SegmentTapView()
        
        segView.frame = CGRect(x: 0, y: 0, width: rectBounds.size.width, height: 40)
        segView.delegate = self
        view.addSubview(segView)
        segmentTapView = segView
        
        let pageC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageC.view.frame = CGRect(x: 0, y: 40, width: view.bounds.size.width, height: view.bounds.size.height - 40)
        pageC.delegate = self
        pageC.dataSource = self
        for subView in pageC.view.subviews {
            if subView.isKind(of: UIScrollView.classForCoder()) {
                (subView as! UIScrollView).delegate = self
            }
        }
        view.addSubview(pageC.view)
        pageController = pageC
        
        segView.initIndex = initIndex
        segView.titles = segmentTitles
        pageC.setViewControllers([viewControllers![initIndex]], direction: .reverse, animated: false, completion: nil)
        
    }
    
    //获取当前控制器所在的位置
    func indexOfViewController(viewController:UIViewController) -> Int {
        return viewControllers.index(of: viewController)!
    }
    
    //MARK: - UIPageViewControllerDataSource
    //获取前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController: viewController)
        if index == NSNotFound || index == 0 {
            return nil
        }
        index -= 1
        return viewControllers[index]
    }
    //获取后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController: viewController)
        if index == NSNotFound || index == viewControllers.count - 1 {
            return nil
        }
        index += 1
        return viewControllers[index]
    }
    
    //MARK: - SegmentTapViewDelegate
    func selectIndex(index: Int) {
        
        if currentIndex < index {
            pageController.setViewControllers([viewControllers![index]], direction: .forward, animated: true, completion: {(complete) -> Void in
                self.currentIndex = index
                let btn = self.segmentTapView.buttons[index]
                self.segmentTapView.scrollEnd(btn: btn)
            })
            
        }else if currentIndex == index{
            
        }else{
            pageController.setViewControllers([viewControllers![index]], direction: .reverse, animated: true, completion: {(complete) -> Void in
                self.currentIndex = index
                let btn = self.segmentTapView.buttons[index]
                self.segmentTapView.scrollEnd(btn: btn)
            })
        }
        
        let vc = viewControllers[index]
        let title = segmentTitles[index]
        clickTapSegment!(vc,title)
        
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        for button in segmentTapView.buttons {
            button.isUserInteractionEnabled = false
        }
        
    }
    
    //滑动结束后将顶部的标题状态进行改变
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for button in segmentTapView.buttons {
            button.isUserInteractionEnabled = true
        }
        
        let currentView = scrollView.subviews[1]
        let vcView = currentView.subviews[0]
        currentIndex = vcView.tag - 1
        
        segmentTapView.changeStatus(index: vcView.tag)
        
        let vc = viewControllers[vcView.tag - 1]
        let title = segmentTitles[vcView.tag - 1]
        scrollClosure!(vc,title)
    }
    
    
    
    
    
    
}
