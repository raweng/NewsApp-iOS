# NewsApp-iOS
Sample News app written in Swift showing use of Contentstack SDK.

![Screen1][1]
 
## Content Modelling in Contentstack (Content Type)
In this news application, we will create 2 Content Types viz., Category and News. Let's see how to create it in Contentstack.

Create **Category** Content Type

![Category_CT][2]

Create **News** Content Type

![News_CT][3]

## Clone repository

Open Terminal (for Mac and Linux users) or the command prompt (for Windows users) and paste the below command to clone the project.

    $ git clone https://github.com/raweng/NewsApp-iOS.git

## Usage

#### SDK Initialization
Grab API Key and Access Token from Contentstack management screen.

    let stack:Stack = Contentstack.stackWithAPIKey("blt5fbafb8f08f9d6d0", accessToken: AccessToken, environmentName: "dev")

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
    
[0]: <http://csdocs.builtapp.io/developer/ios/query-guide>
  [1]: https://api.contentstack.io/v2/assets/567180332b84a7fe5f23fc44/download?uid=bltdbd68f89ff7c253d&AUTHTOKEN=bltefb4f32b56206d8e5bc6cb9e
  [2]: https://api.contentstack.io/v2/assets/56b85f310ea5e91f35d9ffbb/download?uid=blt0ef50bfc28445d08&AUTHTOKEN=bltbfb694c915ad7c3b24584a7b
  [3]: https://api.contentstack.io/v1/uploads/56b85f390ea5e91f35d9ffc6/download?uid=blt04d8d8e7c7c632c5&AUTHTOKEN=bltefb4f32b56206d8e5bc6cb9e
  [4]: http://contentstackiossdk.builtapp.io/csio-quickstart.zip
