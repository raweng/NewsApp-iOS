//
//  CategoryController.swift
//  csnews
//
//  Created by Reefaq on 11/09/15.
//  Copyright (c) 2015 Reefaq. All rights reserved.
//

import Foundation
import Contentstack

class CategoryController: UITableViewController {
    
    private var categoryList = [Entry]();
    private var categoryQuery:Query! = nil
    private var selectedRowIndex = 0
    private var isEnglish = true
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.clearsSelectionOnViewWillAppear = false
        
        if(self.categoryList.count == 0){
            fetchAllCategories(true)
        }else {
            self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedRowIndex, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.categoryList.count>0 ? self.categoryList.count+1 : self.categoryList.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) 
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0){
            if(self.isEnglish){
                cell.textLabel?.text = NSLocalizedString("Top News", comment: "topnews in category")
            }else {
                cell.textLabel?.text = "मुख्य समाचार"
            }
        }else {
            let entry:Entry = self.categoryList[indexPath.row-1]
            cell.textLabel?.text = entry.title
        }

        cell.textLabel?.highlightedTextColor = UIColor.whiteColor()

        cell.selectedBackgroundView = UIView(frame: cell.bounds)
        cell.selectedBackgroundView?.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        selectedRowIndex = indexPath.row
        let centerVC:UINavigationController =  self.slidingPanelController.centerViewController as! UINavigationController
        
        if(centerVC.topViewController!.isKindOfClass(TopNewsController.classForCoder())){
            let topNewsVC:TopNewsController =  centerVC.topViewController as! TopNewsController
            
            if (indexPath.row == 0){
                //show top news
                topNewsVC.fetchTopNews()
            }else {
                let entry:Entry = self.categoryList[indexPath.row-1]
                topNewsVC.fetchNewsOnCategory(entry)
            }
        }
        menuClicked()
    }
    
    func fetchAllCategories(isEnglish:Bool){
        
        self.isEnglish = isEnglish
        if(categoryQuery != nil){
            categoryQuery.cancelRequests()
        }
        categoryQuery = AppDelegate.sharedSite().contentTypeWithName("category").query()
        
        categoryQuery.language(Language.ENGLISH_UNITED_STATES)
        
        if(!isEnglish){
            categoryQuery.language(Language.HINDI_INDIA)
        }
        
        categoryQuery.find { (responseType, result, error) -> Void in
            if(error != nil){
                print(error)
            }else {
                let entries:[(Entry)]! = result!.getResult() as! [(Entry)]
                if(entries != nil && entries.count > 0){
                    self.categoryList.removeAll(keepCapacity: false)
                    for entry:Entry in (result!.getResult() as! [(Entry)]){
                        self.categoryList.append(entry)
                    }
                    self.tableView.reloadData()
                    
                    self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
                }
                
                if(self.isEnglish){
                    self.categoriesLabel.text = "Categories"
                }else {
                    self.categoriesLabel.text = "श्रेणियाँ"
                }
            }
        }
    }

}