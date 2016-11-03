//
//  NewsDetailController.swift
//  csnews
//
//  Created by Reefaq on 23/09/15.
//  Copyright (c) 2015 Reefaq. All rights reserved.
//

import Foundation
import Contentstack

class NewsDetailController: UIViewController, UIWebViewDelegate {
    var newsArticle:Entry!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var detailWebView: UIWebView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var webviewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Stack News", comment: "VC title")
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bannerImageView.superview!.bounds
        gradient.colors = [UIColor(hexString:"#C64B4E")!.CGColor, UIColor(hexString:"#C64B4E")!.CGColor]
        self.bannerImageView.superview!.layer.insertSublayer(gradient, atIndex: 0)

        let gradientForImage: CAGradientLayer = CAGradientLayer()
        gradientForImage.frame = CGRectMake(0, CGRectGetHeight(self.bannerImageView.bounds)-130, CGRectGetWidth(self.bannerImageView.bounds), 130)
        gradientForImage.colors = [UIColor.clearColor().CGColor, UIColor(white: 0, alpha: 0.8).CGColor]
        self.bannerImageView.layer.insertSublayer(gradientForImage, atIndex: 0)

        if (newsArticle != nil){
            if(!newsArticle["featured_image"]!.isKindOfClass(NSNull.classForCoder())){
                let bannerDict:[NSString: AnyObject] = newsArticle["featured_image"] as! [NSString: AnyObject]
                let imageURLString = bannerDict["url"] as! String
                self.bannerImageView.contentMode = UIViewContentMode.ScaleAspectFill
                self.bannerImageView.clipsToBounds = true
                self.bannerImageView.kf_setImageWithURL(NSURL(string: imageURLString)!)
            }else {
                self.bannerImageView.image = nil;
            }
            
            self.titleLabel.text = newsArticle.title
            
            self.detailWebView.delegate = self
            self.detailWebView.scrollView.scrollEnabled = false;
            if(!newsArticle["body"]!.isKindOfClass(NSNull.classForCoder())){
                let description = newsArticle["body"] as! String
                self.detailWebView.loadHTMLString(description, baseURL: nil)
            }
        }
        
        let categories:NSArray = newsArticle["category"] as! NSArray
        var category:String = ""
        categories.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
            let categoryDict:[NSString:AnyObject] = obj as! [NSString:AnyObject]
            category = categoryDict["title"] as! String
        })
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dtString = dateFormatter.stringFromDate(newsArticle.updatedAt) as String
        
        self.categoryLabel.text = category + " | " + dtString

        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webviewHeight.constant = webView.scrollView.contentSize.height
        self.view.layoutIfNeeded()
        
        let scrollView:UIScrollView = self.detailWebView.superview as! UIScrollView
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, webviewHeight.constant + 200)
    }
}