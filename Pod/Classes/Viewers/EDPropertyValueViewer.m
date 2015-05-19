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

    id value = [self obtainValue];
    
    if(!value)
    {
        return nil;
    }
    
    switch (self.objCType[0]) {
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
        {
            return [self.numericFormatter formatValue:value];
        }
            break;
        case '*':
        {
            return [self.cStringFormatter formatValue:value];
        }
            break;
        case ':':
        {
            return [self.selectorFormatter formatValue:value];
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

- (NSValue *)obtainValue
{
    SEL getterSelector = sel_getUid([self.key cStringUsingEncoding:NSUTF8StringEncoding]);

    NSUInteger valueSize;
    NSUInteger align;
    
    NSGetSizeAndAlignment(self.objCType, &valueSize, &align);
    void *bytes = malloc(valueSize);
   
    NSMethodSignature * methodSig = [[self.receiver class] instanceMethodSignatureForSelector:getterSelector];
    NSInvocation * invocation=[NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:self.receiver];
    [invocation setSelector:getterSelector];
    
    @try {
        [invocation invoke];
        [invocation getReturnValue:bytes];
    }
    @catch (NSException *exception) {
        return nil;
    }

    NSValue *value = [NSValue valueWithBytes:bytes objCType:self.objCType];
    free(bytes);
    return value;
}

@end
