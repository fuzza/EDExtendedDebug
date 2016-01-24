//
//  EDPropertyHelper.m
//  Pods
//
//  Created by Alexey Fayzullov on 5/25/15.
//
//

#import "EDPropertyHelper.h"

@implementation EDPropertyHelper

#pragma mark - public

+ (SEL)getterForProperty:(objc_property_t)property
{
    NSParameterAssert(property);
    SEL result = NULL;
    char *getterName = property_copyAttributeValue(property, "G");
    if(getterName == NULL)
    {
        result = sel_getUid(property_getName(property));
    }
    else {
        result = sel_getUid(getterName);
        free(getterName);
    }
    return result;
}

+ (SEL)setterForProperty:(objc_property_t)property
{
    NSParameterAssert(property);
    SEL result = NULL;
    char *setterName = property_copyAttributeValue(property, "S");
    if(setterName == NULL)
    {
        const char *propertyName = property_getName(property);
        char *setterName = (char *)malloc(strlen(propertyName) + 4);
        strncpy(setterName, "set", 3);
        strcpy(setterName + 3, propertyName);
        strcat(setterName, ":");
        setterName[3] = toupper(setterName[3]);
        result = sel_getUid(setterName);
        free(setterName);
    }
    else {
        result = sel_getUid(setterName);
        free(setterName);
    }
    return result;
}

+ (NSString *)nameOfProperty:(objc_property_t)property
{
    NSParameterAssert(property);
    return [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
}

+ (NSString *)encodedReturnTypeStringOfProperty:(objc_property_t)property
{
    NSParameterAssert(property);
    char *type = [self copyEncodedReturnTypeOfProperty:property];
    NSString *result = [NSString stringWithUTF8String:type];
    free(type);
    return result;
}

+ (id)objectValueOfProperty:(objc_property_t)property forObject:(id)anObject
{
    NSParameterAssert(property);
    id __unsafe_unretained resultedObject = nil;
    NSValue *value = [self valueOfProperty:property forObject:anObject];
    if(value && (value.objCType[0] == '@' || value.objCType[0] == '#'))
    {
        [value getValue:&resultedObject];
    }
    return resultedObject;
}

+ (NSValue *)valueOfProperty:(objc_property_t)property forObject:(id)anObject
{
    NSParameterAssert(property);
    SEL getterSelector = [self getterForProperty:property];
    char *encodedType = [self copyEncodedReturnTypeOfProperty:property];
    NSValue *result = [self valueOfPropertyByGetter:getterSelector ofType:encodedType forObject:anObject];
    free(encodedType);
    return result;
}

#pragma mark - private

+ (NSValue *)valueOfPropertyByGetter:(SEL)getterSelector ofType:(const char *)type forObject:(id)anObject
{
    NSValue *returnValue = nil;
    // -respondsToSelector: check is vital, since there's protocols with optional properties.
    // Instances of classes, that conform to protocol with optional properties has descriptions
    // of that properties returned in class_copyPropertyList, however, no getter and setter implemented
    // Fixes crash for example project on iOS 9 for -[UIView ED_debugSelf]
    if ([anObject respondsToSelector:getterSelector]) {
        NSUInteger valueSize = 0;
        NSUInteger align = 0;
        
        NSGetSizeAndAlignment(type, &valueSize, &align);
        void *bytes = malloc(valueSize);
        
        NSMethodSignature * methodSig = [[anObject class] instanceMethodSignatureForSelector:getterSelector];
        if(methodSig)
        {
            NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            [invocation setTarget:anObject];
            [invocation setSelector:getterSelector];
            [invocation invoke];
            [invocation getReturnValue:bytes];
            
            returnValue = [NSValue valueWithBytes:bytes objCType:type];
            free(bytes);
        }
    }
    return returnValue;
}


+ (char *)copyEncodedReturnTypeOfProperty:(objc_property_t)property
{
    NSParameterAssert(property);
    return property_copyAttributeValue(property, "T");
}

@end
