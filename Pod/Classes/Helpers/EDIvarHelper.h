//
//  EDIvarHelper.h
//  Pods
//
//  Created by Petro Korienev on 1/24/16.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface EDIvarHelper : NSObject

+ (NSString *)nameOfIvar:(Ivar)ivar;
+ (NSString *)encodedTypeForIvar:(Ivar)ivar;
+ (NSValue *)valueOfIvar:(Ivar)property forObject:(id)anObject;

@end
