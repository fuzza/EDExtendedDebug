//
//  EDPropertyHelper.h
//  Pods
//
//  Created by Alexey Fayzullov on 5/25/15.
//
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@interface EDPropertyHelper : NSObject

+ (SEL)getterForProperty:(objc_property_t)property;
+ (SEL)setterForProperty:(objc_property_t)property;
+ (NSString *)nameOfProperty:(objc_property_t)property;
+ (NSString *)encodedReturnTypeStringOfProperty:(objc_property_t)property;

+ (NSValue *)valueOfProperty:(objc_property_t)property forObject:(id)anObject;

@end
