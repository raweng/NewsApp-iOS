## Introduction
Sample News app written in Swift showing use of Contentstack SDK.

<img src='http://contentstackdocs.built.io/images/ios-screentshot-new.jpg' width='650' height='550'/>
 
## Create Content Type - Category and News
In this news application, we will create 2 Content Types viz., Category and News. Download the JSON format of Category and News content type and import it in Contentstack.

[Category JSON](http://contentstackdocs.built.io/json/category.json)

[News JSON](http://contentstackdocs.built.io/json/news.json).

To learn more about how to import content type, check out the [guide](http://contentstackdocs.built.io/developer/guides/content-types#import-a-content-type).

Create **Category** Content Type

<img src='http://contentstackdocs.built.io/images/CS_CT.png' width='600' height='400'/>

Create **News** Content Type

<img src='http://contentstackdocs.built.io/images/Cs-News-CT.png' width='600' height='550'/>

## Clone repository

Open Terminal (for Mac and Linux users) or the command prompt (for Windows users) and paste the below command to clone the project.

    $ git clone https://github.com/raweng/NewsApp-iOS.git

## Configure project
Grab API Key and Access Token from Contentstack admin interface, Settings > General and Update the config parameters in SDK initialisation step:

    let stack:Stack = Contentstack.stackWithAPIKey("API_KEY", accessToken: "ACCESS_TOKEN", environmentName: "ENVIRONMENT_NAME")

## Usage

#### Query News Items 
Home page shows list of top news that we have created in Contentstack. Let’s see how to query Contentstack. 

    var topNewsArticles = [Entry]();
    var allNewsByCategoryQuery:Query = stack.contentTypeWithName("news").query()
    
    //filter topnews
    allNewsByCategoryQuery.whereKey("topnews", equalTo: NSNumber(bool: true))
    
    allNewsByCategoryQuery.includeReferenceFieldWithKey(["category"])
    allNewsByCategoryQuery.orderByAscending("updated_at")
    
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
                self.topNewsArticles.append(entry)
            }
        }
    }
For more details about Query, refer [Contentstack Query Guide][0] 

#### Filter By Category
    // self.selectedCategoryUId is a variable containing selected category uid
    allNewsByCategoryQuery.whereKey("category", equalTo: [self.selectedCategoryUId])

#### Filter By Language 
    //For English language
    allNewsByCategoryQuery.language(Language.ENGLISH_UNITED_STATES)
    
    //For Hindi language
    //allNewsByCategoryQuery.language(Language.HINDI_INDIA)
    
[0]: <http://contentstackdocs.built.io/developer/ios/query-guide>
