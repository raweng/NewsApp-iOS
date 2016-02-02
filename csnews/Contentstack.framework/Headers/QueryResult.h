//
//  QueryResult.h
//  Contentstack
//
//  Created by Reefaq on 11/07/15.
//  Copyright (c) 2015 Built.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryResult : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

//MARK: Result -
/**---------------------------------------------------------------------------------------
 * @name Result
 *  ---------------------------------------------------------------------------------------
 */

/**
 @abstract Get array of entries returned by Query.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSArray *result = [result getResult];// get all result in array
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var results:Array  =  result.getResult()
     }
 
 @return Returns an array of entries returned by Query.
 */
- (NSArray *)getResult;

//MARK: Count -
/**---------------------------------------------------------------------------------------
 * @name Count
 *  ---------------------------------------------------------------------------------------
 */

/**
 @abstract Count of number of entries returned by Query alongwith entries themselves.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSInteger totalCount = [result totalCount];// totalcount
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var total:Int  =  result.totalCount()
     }
 
 @return Returns the count of number of object returned by Query.
 */
- (NSInteger)totalCount;

//MARK: Delta Entries-
/**---------------------------------------------------------------------------------------
 * @name Delta Entries
 *  ---------------------------------------------------------------------------------------
 */

/**
 @abstract Get array of updated entries returned by delta.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSArray *updatedEntries = [result updatedEntries];
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var updatedEntries:Array  =  result.updatedEntries()
     }
 
 @return Returns an array of updated entries returned by delta.
 */
- (NSArray *)updatedEntries;

/**
 @abstract Get array of created entries returned by delta.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSArray *createdEntries = [result createdEntries];
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var createdEntries:Array  =  result.createdEntries()
     }
 
 
 @return Returns an array of created entries returned by delta.
 */
- (NSArray *)createdEntries;

/**
 @abstract Get array of deleted entries returned by delta.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSArray *deletedEntries = [result deletedEntries];
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var deletedEntries:Array  =  result.deletedEntries()
     }
 
 @return Returns an array of deleted entries returned by delta.
 */
- (NSArray *)deletedEntries;

/**
 @abstract Get dictionary of all created/updated/deleted entries returned by delta.
 
     //Obj-C
     [blogQuery execInBackground:^(ResponseType type, QueryResult *result, NSError *error) {
        NSDictionary *allEntries = [result allEntries];
     }];
     
     //Swift
     blogQuery.execInBackground { (responseType, result!, error!) -> Void in
        var allEntries:Dictionary  =  result.allEntries()
     }
 
 @return Returns an dictionary of created/updated/deleted entries returned by delta.
 */
- (NSDictionary *)allEntries;

@end
