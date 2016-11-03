//
//  NewsCell.swift
//  csnews
//
//  Created by Reefaq on 24/09/15.
//  Copyright (c) 2015 Reefaq. All rights reserved.
//

import Foundation
import Kingfisher
import Contentstack

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadContent(entry:Entry){
        self.titleLabel.text = entry.title
        
        var category:String = ""
        
        let categories:NSArray = entry["category"] as! NSArray
        
        categories.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
            let categoryDict:[NSString:AnyObject] = obj as! [NSString:AnyObject]
            category = categoryDict["title"] as! String
        })
        
        self.categoryLabel.text = category
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dtString = dateFormatter.stringFromDate(entry.updatedAt) as String
        
        self.dateLabel.text = dtString
        self.bannerImageView.backgroundColor = UIColor.darkGrayColor()
        
        if(!entry["thumbnail"]!.isKindOfClass(NSNull)){
            let bannerDict:[NSString: AnyObject] = entry["thumbnail"] as! [NSString: AnyObject]
            let imageURLString = bannerDict["url"] as! String
            self.bannerImageView.contentMode = UIViewContentMode.ScaleAspectFill
            self.bannerImageView.clipsToBounds = true
            self.bannerImageView.kf_showIndicatorWhenLoading = true
            self.bannerImageView.kf_setImageWithURL(NSURL(string: imageURLString)!,
                placeholderImage: UIImage(named: "thumbImage"),
                optionsInfo: [.Transition: ImageTransition.Fade(0.1)])
        }else {
            self.bannerImageView.image = UIImage(named: "thumbImage");
        }
        
    }
}