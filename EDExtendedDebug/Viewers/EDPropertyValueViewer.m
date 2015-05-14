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

@end

@implementation EDPropertyValueViewer

- (instancetype)initWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type
{
    self = [super init];
    if(self)
    {
        _receiver = receiver;
        _key = key;
        _objCType = type;
    }
    return self;
}

- (NSString *)showValue
{
    id value = [self obtainValue];
    
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
        {
            return [self.numericFormatter formatNumericFromValue:value];
        }
            break;
        case 'c':
        case 'C':
        {
            return [self.numericFormatter formatCharFromValue:value];
        }
            break;
        case 'B':
        {
            return [self.numericFormatter formatBoolFromValue:value];
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

- (id)obtainValue
{
    char firstTypeSymbol = self.objCType[0];
    if(firstTypeSymbol == '*')
    {
        SEL getterSelector = sel_getUid([self.key cStringUsingEncoding:NSUTF8StringEncoding]);
        char *charStringValue = ((char *(*)(id, SEL))objc_msgSend)(self.receiver, getterSelector);
        return [NSValue valueWithBytes:&charStringValue objCType:self.objCType];
    }
    else if(firstTypeSymbol == ':')
    {
        SEL getterSelector = sel_getUid([self.key cStringUsingEncoding:NSUTF8StringEncoding]);
        SEL selectorValue = ((SEL (*)(id, SEL))objc_msgSend)(self.receiver, getterSelector);
        NSValue *value = [NSValue valueWithBytes:&selectorValue objCType:@encode(SEL)];
        return value;
    }
    else
    {
        return [self.receiver valueForKey:self.key];
    }
}

@end
