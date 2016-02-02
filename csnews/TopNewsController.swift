//
//  TopNews.swift
//  csnews
//
//  Created by Reefaq on 11/09/15.
//  Copyright (c) 2015 Reefaq. All rights reserved.
//

import Foundation
import Kingfisher
import Contentstack

class TopNewsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var bannerNewsList = [Entry]();
    private var topNewsArticles = [Entry]();
    private var newsArticles = [Entry]();
    
    private var topNewsQuery:Query! = nil
    private var allNewsByCategoryQuery:Query! = nil
    
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerCategoryLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    private var highlitedIndex:Int = 0
    private var currentIndex:Int = 0
    private var selectedCategory:String = ""
    private var selectedCategoryUId:String = ""
    private var isTopNews:Bool = true
    private var bannerTimer:NSTimer! = nil
    
    private var defaultSiteLanguage:LanguageType = LanguageType.English

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Stack News", comment: "VC title")
        
        bannerImage.superview?.hidden = true;
        
        self.tableView.estimatedRowHeight = 110
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        showTopMenu()
        
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        self.refreshControl.tintColor = UIColor(hexString: "#E44B4E")
        self.tableView.addSubview(self.refreshControl)
        
        // Do any additional setup after loading the view, typically from a nib.
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bannerImage.superview!.bounds
        gradient.colors = [UIColor(hexString:"#C64B4E")!.CGColor, UIColor(hexString:"#C64B4E")!.CGColor]
        bannerImage.superview!.layer.insertSublayer(gradient, atIndex: 0)
        
        let gradientForImage: CAGradientLayer = CAGradientLayer()
        gradientForImage.frame = CGRectMake(0, CGRectGetHeight(self.bannerImage.bounds)-130, CGRectGetWidth(bannerImage.bounds), 130)
        gradientForImage.colors = [UIColor.clearColor().CGColor, UIColor(white: 0, alpha: 0.8).CGColor]
        bannerImage.layer.insertSublayer(gradientForImage, atIndex: 0)

        self.slidingPanelController.leftPanelController.viewDidLoad()

        self.refresh(nil)

    }
    
    func refresh(refreshControl:UIRefreshControl!) {
        
        if(refreshControl == nil){
            self.enableNavigationButtons(false)

            self.showLoadingInView(self.view)
            let netCallsGroup:dispatch_group_t = dispatch_group_create()
            self.isTopNews = true;
            self.fetchNews(netCallsGroup, categoryEntry:nil, isTopNews:self.isTopNews)
            
            dispatch_group_notify(netCallsGroup, dispatch_get_main_queue()) { () -> Void in
                self.filterBannerNews(false)
                self.tableView.reloadData()
                self.hideLoadingInView(self.view)
                
                self.enableNavigationButtons(true)
            }
            
        }else {
            self.fetchNews(nil, categoryEntry:nil, isTopNews:self.isTopNews)
        }
    }
    
    func enableNavigationButtons(enable:Bool){
        self.navigationItem.leftBarButtonItem?.enabled = enable
        self.navigationItem.rightBarButtonItem?.enabled = enable
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.newsArticles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewsCell = tableView.dequeueReusableCellWithIdentifier("topNewsCell", forIndexPath: indexPath) as! NewsCell
        return cell;
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let entry:Entry! = self.newsArticles[indexPath.row]
        let newsCell:NewsCell = cell as! NewsCell
        newsCell.loadContent(entry)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(self.isTopNews){
            if(self.defaultSiteLanguage == LanguageType.English){
                return NSLocalizedString("TOP NEWS", comment: "Section title in homescreen")
            }else {
                return "मुख्य समाचार"
            }
        }else {
            return selectedCategory
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(self.newsArticles.count > 0){
            return 25
        }
        return 0
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.font = UIFont.systemFontOfSize(12)
    }
    
    func fetchTopNews(){
        self.isTopNews = true;
        self.fetchNews(nil, categoryEntry:nil, isTopNews:true)
    }
    func fetchNewsOnCategory(categoryEntry:Entry){
        self.isTopNews = false;
        self.fetchNews(nil, categoryEntry:categoryEntry)
    }
    
    func fetchNews(group:dispatch_group_t!, categoryEntry:Entry! = nil, isTopNews:Bool = false){
        if(group != nil){
            dispatch_group_enter(group)
        }else {
            if(!self.refreshControl.refreshing){
                self.showLoadingInView(self.view)
            }
            
        }
        if(categoryEntry != nil){
            let categoryTitle:String = categoryEntry.title
            let categoryUid:String = categoryEntry.uid
            self.selectedCategory = categoryTitle
            self.selectedCategoryUId = categoryUid
        }

        if(allNewsByCategoryQuery != nil){
            allNewsByCategoryQuery.cancelRequests()
        }
        allNewsByCategoryQuery = AppDelegate.sharedSite().contentTypeWithName("news").query()

        allNewsByCategoryQuery.language(Language.ENGLISH_UNITED_STATES)
        
        if(self.defaultSiteLanguage == LanguageType.Hindi){
            allNewsByCategoryQuery.language(Language.HINDI_INDIA)
        }
        
        if(isTopNews){
            allNewsByCategoryQuery.whereKey("top_news", equalTo: NSNumber(bool: true))
        }else {
            allNewsByCategoryQuery.whereKey("category", equalTo: [self.selectedCategoryUId])
        }
        
        allNewsByCategoryQuery.includeReferenceFieldWithKey(["category"])
        allNewsByCategoryQuery.orderByAscending("updated_at")
        
        self.newsArticles.removeAll(keepCapacity: false)
        
        allNewsByCategoryQuery.find { (responseType, result, error) -> Void in
            
            if(error != nil){
                let alertController:UIAlertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: "Opps! Some error occured while fetching data.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .Cancel) { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }else {
                
                for entry:Entry in (result.getResult() as! [(Entry)]){
                    self.newsArticles.append(entry)
                    
                    var category:String = ""
                    let categories:NSArray = entry["category"] as! NSArray
                    categories.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                        let categoryDict:[NSString:AnyObject] = obj as! [NSString:AnyObject]
                        category = categoryDict["title"] as! String
                    })
                    self.selectedCategory = category

                }
            }
            
            if(isTopNews){
                self.topNewsArticles.removeAll(keepCapacity: false)
                self.topNewsArticles.appendContentsOf(self.newsArticles)
            }

            if(group != nil){
                dispatch_group_leave(group)
            }else {
                self.filterBannerNews(!isTopNews)
                self.tableView.reloadData()

                if(self.refreshControl.refreshing){
                    self.refreshControl.endRefreshing()
                }else {
                    self.hideLoadingInView(self.view)
                }
            }

        }
        
    }
    
    func filterBannerNews(onCategory:Bool){
        self.stopRotatingBanner()
        self.bannerNewsList.removeAll(keepCapacity: false)
        if(onCategory){
            self.bannerNewsList = self.topNewsArticles.filter { (e) -> Bool in
                var retVal:Bool = false
                let categories:NSArray = e["category"] as! NSArray
                categories.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                    var categoryUID:String = ""
                    let category:Entry = AppDelegate.sharedSite().contentTypeWithName("category").entryWithUID(categoryUID)
                    category.configureWithDictionary(obj as! [NSObject : AnyObject])
                    categoryUID = category.uid
                    if(categoryUID == self.selectedCategoryUId){
                        retVal = true
                    }
                })
                return retVal
            }
        }else {
            self.bannerNewsList = self.topNewsArticles
        }
        
        self.highlitedIndex = 0
        self.startRotatingBanner()
    }

    func startRotatingBanner(){
        stopRotatingBanner()
        self.bannerTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBanner", userInfo: nil, repeats: true)
        rotateBanner()
    }
    
    func stopRotatingBanner(){
        if(self.bannerTimer != nil){
            self.bannerTimer.invalidate()
            self.bannerTimer = nil;
        }
    }

    func rotateBanner(){
        if(self.bannerNewsList.count==0){
            self.bannerImage.image = nil
            self.bannerTitleLabel.text = ""
            self.bannerCategoryLabel.text = ""
            return
        }
        
        if(self.highlitedIndex < self.bannerNewsList.count){
            bannerImage.superview?.hidden = false;
            bannerImage.kf_showIndicatorWhenLoading = true

            self.currentIndex = self.highlitedIndex
            let entry:Entry = self.bannerNewsList[self.highlitedIndex]
            if(!entry["featured_image"].isKindOfClass(NSNull)){
                let bannerDict:[NSString: AnyObject] = entry["featured_image"] as! [NSString: AnyObject]
                let imageURLString = bannerDict["url"] as! String
                self.bannerImage.contentMode = UIViewContentMode.ScaleAspectFill
                self.bannerImage.clipsToBounds = true
                self.bannerImage.kf_setImageWithURL(NSURL(string: imageURLString + "?AUTHTOKEN="+AccessToken)!,
                    placeholderImage: nil,
                    optionsInfo: [.Transition: ImageTransition.Fade(0.1)])

            }else {
                self.bannerImage.image = nil;
            }
            
            self.bannerTitleLabel.text = entry.title
            
            let categories:NSArray = entry["category"] as! NSArray
            var category:String = ""
            categories.enumerateObjectsUsingBlock({ (obj, index, stop) -> Void in
                let categoryDict:[NSString:AnyObject] = obj as! [NSString:AnyObject]
                category = categoryDict["title"] as! String
            })
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            dateFormatter.timeZone = NSTimeZone.localTimeZone()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            let dtString = dateFormatter.stringFromDate(entry.updatedAt) as String
            
            self.bannerCategoryLabel.text = category + " | " + dtString
            self.highlitedIndex+=1
            if(self.highlitedIndex>=self.bannerNewsList.count){
                self.highlitedIndex = 0
            }
        }

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(identifier == "bannerDetail"){
            if(self.bannerNewsList.count > self.currentIndex){
                return true
            }
            return false
        }
        
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "bannerDetail"){
            if(self.bannerNewsList.count > self.currentIndex){
                let entry:Entry = self.bannerNewsList[self.currentIndex]
                let detailVC:NewsDetailController = segue.destinationViewController as! NewsDetailController
                detailVC.newsArticle = entry
            }
        }else {
            var entry:Entry! = nil
            entry = self.newsArticles[self.tableView.indexPathForSelectedRow!.row]
            let detailVC:NewsDetailController = segue.destinationViewController as! NewsDetailController
            detailVC.newsArticle = entry
            
            self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: false)
        }
        
    }
    
    func fetchAndChangeNewsLanguage(){
        
        if(self.slidingPanelController.leftPanelController != nil && self.slidingPanelController.leftPanelController.isKindOfClass(CategoryController.classForCoder())){
            let leftVC:CategoryController =  self.slidingPanelController.leftPanelController as! CategoryController
            leftVC.fetchAllCategories(defaultSiteLanguage == LanguageType.English ? true : false)
        }

        self.enableNavigationButtons(false)

        self.stopRotatingBanner()
        self.showLoadingInView(self.view)
        let netCallsGroup:dispatch_group_t = dispatch_group_create()
        
        self.fetchNews(netCallsGroup, categoryEntry: nil, isTopNews: true)
        
        dispatch_group_notify(netCallsGroup, dispatch_get_main_queue()) { () -> Void in
            let netCallsGroup2:dispatch_group_t = dispatch_group_create()
            
            if(!self.isTopNews){
                self.fetchNews(netCallsGroup2, categoryEntry: nil)
            }
            dispatch_group_notify(netCallsGroup2, dispatch_get_main_queue()) { () -> Void in
                self.filterBannerNews(!self.isTopNews)
                self.tableView.reloadData()
                self.hideLoadingInView(self.view)

                self.enableNavigationButtons(true)
            }
        }

    }
    
    @IBAction func changeLanguage(){
        let alertController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        let englishAction = UIAlertAction(title: NSLocalizedString("English (Default)", comment: "English (Default)") + (self.defaultSiteLanguage == LanguageType.English ? " \u{2713}" : ""), style: .Default) { (action) in

            self.defaultSiteLanguage = LanguageType.English
            self.fetchAndChangeNewsLanguage()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(englishAction)
        
        let hindiAction = UIAlertAction(title: NSLocalizedString("हिंदी", comment: "Hindi") + (self.defaultSiteLanguage == LanguageType.Hindi ? " \u{2713}" : ""), style: .Default) { (action) in
            self.defaultSiteLanguage = LanguageType.Hindi
            self.fetchAndChangeNewsLanguage()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(hindiAction)

        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
}