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
#import "EDIvarViewer.h"
#import "EDIvarObjectsViewer.h"
#import "EDPropertyValueViewer.h"
#import "EDIvarValueViewer.h"

#import "EDCycleDetector.h"

@implementation NSObject (EDExtendedDebug)

#pragma mark - public

- (NSString *)ED_debugSelf
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfObjects
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuperObjects
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuper
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfObjectsAddress
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;

}

- (NSString *)ED_debugSuperObjectsAddress
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_detectRetainCycles
{
    EDCycleDetector *detector = [EDCycleDetector new];
    return [detector objectHasRetainCycles:self];
}

#pragma mark - private

- (NSString *)FUZ_propertiesDescriptionOfClass:(Class)class withValueViewerBuilder:(EDValueViewerBuilder *)builder viewerClass:(Class<EDPropertyViewerProtocol>)viewerClass
{
    unsigned int propertiesCount = 0;
    objc_property_t *properties = class_copyPropertyList(class, &propertiesCount);
    
    NSString *descriptionString = [NSString stringWithFormat:@"<%@ : %p>\n", [self class], self];
    if(class != [self class])
    {
        descriptionString = [NSString stringWithFormat:@"<%@->%@ : %p>\n", [self class], class, self];
    }
    
    for (unsigned int i = 0; i < propertiesCount; i++)
    {
        NSString *propertyDescription = [viewerClass descriptionOfProperty:properties[i] forObject:self valueBuilder:builder indent:1];
        descriptionString = [descriptionString stringByAppendingString:propertyDescription];
    }
    free(properties);
    return descriptionString;
}

- (NSString *)FUZ_ivarsDescriptionOfClass:(Class)class withValueViewerBuilder:(EDValueViewerBuilder *)builder viewerClass:(Class<EDIvarViewerProtocol>)viewerClass
{
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(class, &ivarsCount);
    
    NSString *descriptionString = [NSString stringWithFormat:@"<%@ : %p>\n", [self class], self];
    if(class != [self class])
    {
        descriptionString = [NSString stringWithFormat:@"<%@->%@ : %p>\n", [self class], class, self];
    }
    
    for (unsigned int i = 0; i < ivarsCount; i++)
    {
        NSString *propertyDescription = [viewerClass descriptionOfIvar:ivars[i] forObject:self valueBuilder:builder indent:1];
        descriptionString = [descriptionString stringByAppendingString:propertyDescription];
    }
    free(ivars);
    return descriptionString;
}


@end
