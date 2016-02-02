//
//  Stack.h
//  Contentstack
//
//  Created by Reefaq on 11/07/15.
//  Copyright (c) 2015 Built.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContentType;

@interface Stack : NSObject

/**
 *  Readonly property to check value of apikey
 */
@property (nonatomic, copy, readonly) NSString *apiKey;

/**
 *  Readonly property to check value of acess token
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 *  Readonly property to check value of environment provided
 */
@property (nonatomic, copy, readonly) NSString *environment;

/**
 *  Readonly Boolean property to check if provided environment is "Environment UID" or "Environment Name"
 */
@property (nonatomic, assign, readonly) BOOL isEnvironmentUID;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

//MARK: ContentType -
/**---------------------------------------------------------------------------------------
 * @name ContentType
 *  ---------------------------------------------------------------------------------------
 */

/**
 Gets the new instance of ContentType object with specified name.

     //Obj-C
     ContentType *contentTypeObj = [stack contentTypeWithName:@"blog"];
     
     //Swift
     var contentTypeObj:ContentType = stack.contentTypeWithName("blog")

 @param contentTypeName name of the contentType to perform action.
 @return instance of ContentType.
 */
- (ContentType*)contentTypeWithName:(NSString*)contentTypeName;

//MARK: Manually set headers -
/**---------------------------------------------------------------------------------------
 * @name Manually set headers
 *  ---------------------------------------------------------------------------------------
 */

/**
 Set a header for Stack
 
     //Obj-C
     [stack setHeader:@"MyValue" forKey:@"My-Custom-Header"];
     
     //Swift
     stack.setHeader("MyValue", forKey: "My-Custom-Header")
 
 @param headerValue  The header key
 @param headerKey    The header value
 */
- (void)setHeader:(NSString *)headerValue forKey:(NSString *)headerKey;

/**
 Set a header for Stack
 
     //Obj-C
     [stack addHeadersWithDictionary:@{@"My-Custom-Header": @"MyValue"}];
     
     //Swift
     stack.addHeadersWithDictionary(["My-Custom-Header":"MyValue"])
 
 @param headers The headers as dictionary which needs to be added to the application
 */
- (void)addHeadersWithDictionary:(NSDictionary *)headers;

/**
 Removes a header from this Stack.
 
    //Obj-C
    [stack removeHeaderForKey:@"My-Custom-Header"];

    //Swift
    stack.removeHeaderForKey("My-Custom-Header")
 
 @param headerKey The header key that needs to be removed
 */
- (void)removeHeaderForKey:(NSString *)headerKey;

//MARK: Modify Environment -
/**---------------------------------------------------------------------------------------
 * @name Modify Environment
 *  ---------------------------------------------------------------------------------------
 */

/**
Sets environment for the Stack.

     //Obj-C
     [stack setEnvironment:@"dummy" isEnvironmentUID:YES];
     
     //Swift
     stack.setEnvironment("dummy", isEnvironmentUID:true)

 
 @param environment name/uid of environment
 @param isUID       Bool if true will consider environment string as 'Environment UID' instead of 'Environment Name'.
 */
- (void)setEnvironment:(NSString *)environment isEnvironmentUID:(BOOL)isUID;

@end
