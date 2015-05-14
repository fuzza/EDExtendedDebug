//
//  NSObject+FUZExtendedDebug.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/13/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "NSObject+EDExtendedDebug.h"
#import "EDFormatters.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

#import "EDPropertyViewer.h"
#import "EDPropertyObjectsViewer.h"

@implementation NSObject (EDExtendedDebug)

- (NSString *)FUZ_debugSelf
{
    Class objectClass = [self class];
    EBValueViewerBuilder *builder = [EBValueViewerBuilder new];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)FUZ_debugSelfObjects
{
    Class objectClass = [self class];
    EBValueViewerBuilder *builder = [EBValueViewerBuilder new];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)FUZ_debugSuperObjects
{
    Class objectClass = [[self class] superclass];
    EBValueViewerBuilder *builder = [EBValueViewerBuilder new];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)FUZ_debugSuper
{
    Class objectClass = [[self class] superclass];
    EBValueViewerBuilder *builder = [EBValueViewerBuilder new];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)FUZ_propertiesDescriptionOfClass:(Class)class withValueViewerBuilder:(EBValueViewerBuilder *)builder viewerClass:(Class)viewerClass
{
    unsigned int propertiesCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertiesCount);
    NSString *descriptionString = [NSString stringWithFormat:@"\n<%@: %p>\n", [self class], self];
    for (int i = 0; i < propertiesCount; i++)
    {
        objc_property_t property = properties[i];
        
        EBValueViewerBuilder *builder = [EBValueViewerBuilder new];
        NSString *propertyDescription = [viewerClass descriptionOfProperty:property forObject:self valueBuilder:builder];
        descriptionString = [descriptionString stringByAppendingString:propertyDescription];
    }
    free(properties);
    return descriptionString;
}

@end
