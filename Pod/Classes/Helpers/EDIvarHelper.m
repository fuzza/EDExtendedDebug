//
//  EDIvarHelper.m
//  Pods
//
//  Created by Petro Korienev on 1/24/16.
//
//

#import "EDIvarHelper.h"

@implementation EDIvarHelper

+ (NSString *)nameOfIvar:(Ivar)ivar {
    NSParameterAssert(ivar);
    return [NSString stringWithUTF8String:ivar_getName(ivar)];
}

+ (NSString *)encodedTypeForIvar:(Ivar)ivar {
    NSParameterAssert(ivar);
    return [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
}

+ (NSValue *)valueOfIvar:(Ivar)ivar forObject:(id)anObject {
    NSParameterAssert(ivar);
    NSParameterAssert(anObject);
    ptrdiff_t offset = ivar_getOffset(ivar);
    return [NSValue valueWithBytes:(__bridge const void *)anObject + offset objCType:ivar_getTypeEncoding(ivar)];
}

@end
