//
//  EDFormatterTestObject.h
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class __EDUnderlinedTestObject;

@interface EDFormatterTestObject : NSObject

@property (nonatomic, strong) __EDUnderlinedTestObject *strongULObject;

@end

@interface __EDUnderlinedTestObject : NSObject

@property (nonatomic, strong) EDFormatterTestObject *strongObject;
@property (nonatomic, weak) EDFormatterTestObject *weakObject;

@end