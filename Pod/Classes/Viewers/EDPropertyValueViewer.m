//
//  FUZPropertyViewStrategy.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyValueViewer.h"
#import "EDFormatters.h"

@interface EDPropertyValueViewer ()

@property (nonatomic, strong, readwrite) id receiver;
@property (nonatomic, strong, readwrite) NSString *key;
@property (nonatomic, assign, readwrite) const char *objCType;

@end

@implementation EDPropertyValueViewer

- (NSString *)showValueWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type
{
    self.receiver = receiver;
    self.key = key;
    self.objCType = type;

    NSValue *value = [self obtainValueWithReceiver:receiver key:key objCType:type];
    
    if(!value)
    {
        return nil;
    }
    
    switch (value.objCType[0]) {
        case '@':
        {
            return [self.objectFormatter formatValue:value];
        }
        case 'i':
        case 's':
        case 'l':
        case 'q':
        case 'I':
        case 'S':
        case 'L':
        case 'Q':
        case 'f':
        case 'd':
        case 'c':
        case 'C':
        case 'B':
        case '*':
        case ':':
            
        {
            return [self.atomicTypesFormatter formatValue:value];
        }
            break;
        case '#':
        {
            return [self.classFormatter formatValue:value];
        }
            break;
        case '{':
        {
            return [self.structFormatter formatValue:value];
        }
            break;
        default:
            return @"???";
            break;
    }
}

- (NSValue *)obtainValueWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type
{
    SEL getterSelector = sel_getUid([key cStringUsingEncoding:NSUTF8StringEncoding]);

    NSUInteger valueSize;
    NSUInteger align;
    
    NSGetSizeAndAlignment(type, &valueSize, &align);
    void *bytes = malloc(valueSize);
   
    NSMethodSignature * methodSig = [[receiver class] instanceMethodSignatureForSelector:getterSelector];
    if(!methodSig)
    {
        return nil;
    }
    
    NSInvocation * invocation=[NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:receiver];
    [invocation setSelector:getterSelector];
    [invocation invoke];
    [invocation getReturnValue:bytes];

    NSValue *value = [NSValue valueWithBytes:bytes objCType:type];
    free(bytes);
    return value;
}

@end
