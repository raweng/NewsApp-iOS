//
//  Contentstack.h
//  Contentstack
//
//  Created by Reefaq on 22/06/15.
//  Copyright (c) 2015 Built.io. All rights reserved.
//

//  sdk-version: 0.0.1
//  api-version: 1.0


#import <Foundation/Foundation.h>

#import <Contentstack/Stack.h>
#import <Contentstack/ContentType.h>
#import <Contentstack/Entry.h>
#import <Contentstack/Query.h>
#import <Contentstack/QueryResult.h>


@class Stack;

@interface Contentstack : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
/**
Create a new Stack instance with stack's apikey, token and environment name.

     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentName:@"dummy"];
 
     //Swift
     let stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentName:@"dummy")

@param apiKey          stack apiKey.
@param token           acesstoken of stack.
@param environmentName environment name in which to perform action.

@return new instance of Stack.
 */
+ (Stack*)stackWithAPIKey:(NSString*)apiKey accessToken:(NSString*)token environmentName:(NSString*)environmentName;

/**
Create a new Stack instance with stack's apikey, token and environment name.

     //Obj-C
     Stack *stack = [Contentstack stackWithAPIKey:@"blt5d4sample2633b" accessToken:@"blt3esampletokeneb02" environmentUID:@"dummyUID"];
     
     //Swift
     let stack:Stack = Contentstack.stackWithAPIKey("blt5d4sample2633b", accessToken:"blt3esampletokeneb02", environmentUID:@"dummyUID")

 
@param apiKey         stack apiKey.
@param token          acesstoken of stack.
@param environmentUID environment uid in which to perform action.

@return new instance of Stack.
 */
+ (Stack*)stackWithAPIKey:(NSString*)apiKey accessToken:(NSString*)token environmentUID:(NSString*)environmentUID;

/**
Cancel all network request for Stack instance.

     //Obj-C
     [Contentstack cancelAllRequestsOfStack:stack];
     
     //Swift
     Contentstack.cancelAllRequestsOfStack(stack)
 
@param stack instance of Stack.
 */
+ (void)cancelAllRequestsOfStack:(Stack*)stack;

@end
