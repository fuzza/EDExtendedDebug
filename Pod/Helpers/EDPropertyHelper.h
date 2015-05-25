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
+ (NSString *)nameOfProperty:(objc_property_t)property;

+ (const char *)encodedTypeOfProperty:(objc_property_t)property;

+ (id)objectValueOfProperty:(objc_property_t)property forObject:(id)anObject;
+ (NSValue *)valueOfProperty:(objc_property_t)property forObject:(id)anObject;
+ (NSValue *)valueOfPropertyByGetter:(SEL)getterSelector ofType:(const char *)type forObject:(id)anObject;

@end
