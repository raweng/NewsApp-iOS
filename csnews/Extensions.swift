//
//  Extensions.swift
//  csnews
//
//  Created by Reefaq on 11/09/15.
//  Copyright (c) 2015 Reefaq. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController{

    func showTopMenu(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("menuClicked"))
    }
    
    func menuClicked() {
        toggleLeftMenu()
    }
    
    private func toggleLeftMenu(){
        if(self.slidingPanelController.sideDisplayed != .Left){
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
            self.slidingPanelController!.openLeftPanel()
        }else {
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
            self.slidingPanelController!.closePanel()
        }
    }
    
    func showLoadingInView(view:UIView!){
        if(view == nil){
            return
        }
        
        let dimBackGroundView:UIView  = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)))
        
        dimBackGroundView.backgroundColor = UIColor(white: 1, alpha: 1);
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRectMake(dimBackGroundView.center.x-25, dimBackGroundView.center.y-25, 50, 50),
            type: NVActivityIndicatorType.LineScale, color: UIColor(hexString: "#E44B4E")!)
        dimBackGroundView.addSubview(activityIndicatorView)
        dimBackGroundView.tag = 99;
        view.addSubview(dimBackGroundView)
        
        activityIndicatorView.startAnimation()
    }
    
    func hideLoadingInView(view:UIView!){
        if(view == nil){
            return
        }

        let dimBackGroundView:UIView? = view.viewWithTag(99)
        let activityIndicatorView:NVActivityIndicatorView = dimBackGroundView?.subviews[0] as! NVActivityIndicatorView
        activityIndicatorView.stopAnimation()
        dimBackGroundView!.removeFromSuperview()
    }
}