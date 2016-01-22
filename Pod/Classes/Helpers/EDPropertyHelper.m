//
//  EDPropertyHelper.m
//  Pods
//
//  Created by Alexey Fayzullov on 5/25/15.
//
//

#import "EDPropertyHelper.h"

@implementation EDPropertyHelper

+ (SEL)getterForProperty:(objc_property_t)property;
{
    char *getterName = property_copyAttributeValue(property, "G");
    if(getterName == nil)
    {
        return sel_getUid(property_getName(property));
    }
    return sel_getUid(getterName);
}

+ (NSString *)nameOfProperty:(objc_property_t)property
{
    return [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
}

+ (const char *)encodedTypeOfProperty:(objc_property_t)property
{
    return property_copyAttributeValue(property, "T");
}

+ (id)objectValueOfProperty:(objc_property_t)property forObject:(id)anObject
{
    NSValue *value = [self valueOfProperty:property forObject:anObject];
    if(value && (value.objCType[0] == '@' || value.objCType[0] == '#'))
    {
        id __unsafe_unretained resultedObject;
        [value getValue:&resultedObject];
        if(resultedObject)
        {
            return resultedObject;
        }
    }
    return nil;
}

+ (NSValue *)valueOfProperty:(objc_property_t)property forObject:(id)anObject
{
    SEL getterSelector = [self getterForProperty:property];
    const char *encodedType = [self encodedTypeOfProperty:property];
    
    return [self valueOfPropertyByGetter:getterSelector ofType:encodedType forObject:anObject];
}

+ (NSValue *)valueOfPropertyByGetter:(SEL)getterSelector ofType:(const char *)type forObject:(id)anObject
{
    NSUInteger valueSize;
    NSUInteger align;
    
    NSGetSizeAndAlignment(type, &valueSize, &align);
    void *bytes = malloc(valueSize);
    
    NSMethodSignature * methodSig = [[anObject class] instanceMethodSignatureForSelector:getterSelector];
    if(!methodSig)
    {
        return nil;
    }
    
    NSInvocation * invocation=[NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:anObject];
    [invocation setSelector:getterSelector];
    [invocation invoke];
    [invocation getReturnValue:bytes];
    
    NSValue *value = [NSValue valueWithBytes:bytes objCType:type];
    free(bytes);
    
    return value;
}

@end
