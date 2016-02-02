//
//  Entry.h
//  Contentstack
//
//  Created by Reefaq on 22/06/15.
//  Copyright (c) 2015 Built.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentstackDefinitions.h"

@interface Entry : NSObject

/**
 *  Readonly property to check value of entry's uid
 */
@property (nonatomic, copy, readonly) NSString *uid;

/**
 *  Readonly property to check tags of entry
 */
@property (nonatomic, copy, readonly) NSArray *tags;

/**
 *  Readonly property to check ContentType name of entry
 */
@property (nonatomic, copy, readonly) NSString *contentTypeName;

/**
 *  Readonly property to check title of entry
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 *  Readonly property to check url of entry
 */
@property (nonatomic, copy, readonly) NSString *url;

/**
 *  Readonly property to check Language of entry
 */
@property (nonatomic, assign, readonly) Language language;

/**
 *  Readonly property to check createAt of entry
 */
@property (nonatomic, copy, readonly) NSDate *createdAt;

/**
 *  Readonly property to check createdBy of entry
 */
@property (nonatomic, copy, readonly) NSString *createdBy;

/**
 *  Readonly property to check updatedAt of entry
 */
@property (nonatomic, copy, readonly) NSDate *updatedAt;

/**
 *  Readonly property to check updatedBy of entry
 */
@property (nonatomic, copy, readonly) NSString *updatedBy;

/**
 *  Readonly property to check deletedAt of entry
 */
@property (nonatomic, copy, readonly) NSDate *deletedAt;

/**
 *  Readonly property to check deletedBy of entry
 */
@property (nonatomic, copy, readonly) NSString *deletedBy;

/**
 *  Readonly property to check metadata of entry.
 */
@property (nonatomic, copy, readonly) NSDictionary *metadata;

/**
 *  property to assign cache policy like CACHE_THEN_NETWORK, NETWORK_ELSE_CACHE, NETWORK_ONLY, etc.
 */
@property (nonatomic, assign) CachePolicy cachePolicy;


- (instancetype)init UNAVAILABLE_ATTRIBUTE;

//MARK: Manually set headers -
/**---------------------------------------------------------------------------------------
 * @name Manually set headers
 *  ---------------------------------------------------------------------------------------
 */

/**
 Set a header for Entry
 
     //'blt5d4sample2633b' is a dummy Stack API key
     
     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentName:@"dummy"];
     [stack setHeader:@"MyValue" forKey:@"My-Custom-Header"];
     
     //Swift
     var stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentName:@"dummy")
     stack.setHeader("MyValue", forKey: "My-Custom-Header")
 
 @param headerValue  The header key
 @param headerKey    The header value
 */
- (void)setHeader:(NSString *)headerValue forKey:(NSString *)headerKey;

/**
 Set a header for Entry
 
     //'blt5d4sample2633b' is a dummy Stack API key
     
     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentName:@"dummy"];
     [stack addHeadersWithDictionary:@{@"My-Custom-Header": @"MyValue"}];
     
     //Swift
     var stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentName:@"dummy")
     stack.addHeadersWithDictionary(["My-Custom-Header":"MyValue"])
 
 
 @param headers  The headers as dictionary which needs to be added to the application
 */
- (void)addHeadersWithDictionary:(NSDictionary *)headers;

/**
 Removes a header from this Entry.
 
     //'blt5d4sample2633b' is a dummy Stack API key
 
     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentName:@"dummy"];
     [stack removeHeaderForKey:@"My-Custom-Header"];
     
     //Swift
     var stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentName:@"dummy")
     stack.removeHeaderForKey("My-Custom-Header")
 
 @param headerKey    The header key that needs to be removed
 */
- (void)removeHeaderForKey:(NSString *)headerKey;

//MARK: Configuring manually -
/**---------------------------------------------------------------------------------------
 * @name Configuring manually
 *  ---------------------------------------------------------------------------------------
 */

/**
 Configure user properties with built object info.
 
     //Obj-C
     [entryObj configureWithDictionary:@{@"key_name":@"MyValue"}];
     
     //Swift
     entryObj.configureWithDictionary(["key_name":"MyValue"])
 
 @param dictionary User Info
 */
- (void)configureWithDictionary:(NSDictionary*)dictionary;

//MARK: - Check for key existence -
/**---------------------------------------------------------------------------------------
 * @name Check for key existence
 *  ---------------------------------------------------------------------------------------
 */

/**
 Checks whether an entry has a given property
 
     //Assuming 'entryObj' is a Entry instance
 
     //Obj-C
     BOOL hashKey = [entryObj hasKey:@"key"];
     if (hashKey) {
        //Hash Key
     } else {
        //No hash key
     }
     
     //Swift
     var hashKey:Bool = entryObj.hasKey("key")
     if (hashKey) {
        //Hash Key
     } else {
        //No Hash Key
     }
 
 @param key The property to be checked
 @return YES if key exists, NO if not
 */
- (BOOL)hasKey:(NSString *)key;

//MARK: - HTML String from Markdown -
/**---------------------------------------------------------------------------------------
 * @name HTML String from Markdown
 *  ---------------------------------------------------------------------------------------
 */
/**
 Converts Markdown to String of HTML String for specified key
 
    //Assuming 'entryObj' is a Entry instance
 
    //Obj-C
    NSString *markdownString = [entryObj HTMLStringForMarkdownKey:@"markdownString"];
 
 
    //Swift
    var markdownString:NSString = entryObj.HTMLStringForMarkdownKey("markdownString")
 
 
 @param key is Markdown string parameter
 @return Markdown to HTML String
 */
- (NSString *)HTMLStringForMarkdownKey:(NSString *)key;


/**
 Converts Markdown to Array of HTML String for specified key
 
 //Assuming 'entryObj' is a Entry instance
 
    //Obj-C
    NSArray *markdownArray = [entry HTMLArrayForMarkdownKey:@"multiple_markdown"];
 
    //Swift
    var markdownArray = entry.HTMLArrayForMarkdownKey("multiple_markdown")
 
 @param key is Multiple Markdown Parameter
 @return HTML Array from Markdown
 */
- (NSArray *)HTMLArrayForMarkdownKey:(NSString *)key;


//MARK: - Only and Except -
/**---------------------------------------------------------------------------------------
 * @name Only and Except
 *  ---------------------------------------------------------------------------------------
 */

/**
Specifies an array of 'only' keys in BASE object that would be included in the response.
 
     //Obj-C
     [entryObj includeOnlyFields:@["name"]];
     
     //Swift
     entryObj.includeOnlyFields(["name"])
 
 @discussion Specifies an array of keys in BASE object that would be included in the response.
 @param fieldUIDs Array of the 'only' keys to be included in response.
 */
- (void)includeOnlyFields:(NSArray *)fieldUIDs;

/**
Specifies an array of keys in reference class object that would be 'excluded' from the response.
 
     //Obj-C
     [entryObj includeAllFieldsExcept:@["name"]];
     
     //Swift
     entryObj.includeAllFieldsExcept(["name"])
 
 @discussion Specifies an array of keys in BASE object that would be 'excluded' from the response.
 @param fieldUIDs Array of keys to be excluded from the response.
 */
- (void)includeAllFieldsExcept:(NSArray *)fieldUIDs;

//MARK: - Reference -
/**---------------------------------------------------------------------------------------
 * @name Reference
 *  ---------------------------------------------------------------------------------------
 */

/**
Include reference objects with given key in response
 
     //Obj-C
     [entryObj includeRefFieldWithKey:@[@"detail"]];
     
     //Swift
     entryObj.includeRefFieldWithKey(["detail"])
 
 @discussion The include parameter accepts the name of a reference field. By default, no reference field is bought along with the object, only the uids are. To include any reference, this parameter must be used. Nested references can be bought by "." separating the references. This will work for references which are nested inside groups or references which are nested inside other references.
 @param key Array of reference keys to include in response.
 */
- (void)includeRefFieldWithKey:(NSArray *)key;

/**
Specifies an array of 'only' keys in reference class object that would be included in the response.
 
     //Obj-C
     [entryObj includeRefFieldWithKey:@[@"detail"] andOnlyRefValuesWithKeys:@[@"name",@"description"]];
     
     //Swift
     entryObj.includeRefFieldWithKey(["detail"], andOnlyRefValuesWithKeys:["name","description"])
 
 @discussion Specifies an array of keys in reference class object that would be included in the response.
 @param key Key who has reference to some other class object.
 @param values Array of the 'only' reference keys to be included in response.
 */
- (void)includeRefFieldWithKey:(NSString *)key andOnlyRefValuesWithKeys:(NSArray *)values;

/**
Specifies an array of keys in reference class object that would be 'excluded' from the response.
 
     //Obj-C
     [entryObj includeRefFieldWithKey:@[@"detail"] excludingRefValuesWithKeys:@[@"description"]];
     
     //Swift
     entryObj.includeRefFieldWithKey(["detail"], excludingRefValuesWithKeys:["description"])
 
 @discussion Specifies an array of keys in reference class object that would be 'excluded' from the response.
 @param key Key who has reference to some other class object.
 @param values Array of the 'only' reference keys to be 'excluded' from the response.
 */
- (void)includeRefFieldWithKey:(NSString *)key excludingRefValuesWithKeys:(NSArray *)values;

//MARK: - Fetch -
/**---------------------------------------------------------------------------------------
 * @name Fetch
 *  ---------------------------------------------------------------------------------------
 */

/**
 Fetches an entry asynchronously provided entry UID
 
     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentName:@"dummy"];
     ContentType *contentTypeObj = [stack contentTypeWithName:@"blog"];
     //'bltf4fsamplec851db' is uid of an entry of 'blog' contenttype
     Entry *entryObj  = [contentTypeObj entryWithUID:@"bltf4fsamplec851db"];
     [entryObj fetch:^(NSError *error) {
        //error if exists then use 'error' object for details
     }];
     
     
     //Swift
     var stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentName:@"dummy")
     var contentTypeObj:ContentType = stack.contentTypeWithName("blog")
     //'bltf4fsamplec851db' is uid of an entry of 'blog' contenttype
     var entryObj:Entry = contentTypeObj.entryWithUID("bltf4fsamplec851db")
     entryObj.fetch { (error!) -> Void in
        //error if exists then use 'error' object for details
     }
 
 @param callback Completion block with params NSError
 */
- (void)fetch:(void(^)(NSError *error))callback;

//MARK: - Cancel Request -
/**---------------------------------------------------------------------------------------
 * @name Cancel Request
 *  ---------------------------------------------------------------------------------------
 */

/**
Advises the operation object that it should stop executing its task.
 
     //Obj-C
     [entryObj cancelRequest];
     
     //Swift
     entryObj.cancelRequest()
 
 @discussion This method does not force your operation code to stop. Instead, it updates the object’s internal flags to reflect the change in state. If the operation has already finished executing, this method has no effect. Canceling an operation that is currently in an operation queue, but not yet executing, makes it possible to remove the operation from the queue sooner than usual.
 */
- (void)cancelRequest;

//MARK: - Subscripting -
- (id)objectForKey:(NSString *)key;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
