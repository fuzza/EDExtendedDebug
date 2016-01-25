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

- (NSString *)ED_debugSelfProperties
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfPropertyObjects
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfIvars
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfIvarObjects
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfMethods
{
    Class objectClass = [self class];
    NSString *descriptionString = [self FUZ_methodsDescriptionOfClass:objectClass];
    return descriptionString;
}

- (NSString *)ED_debugSuperMethods
{
    Class objectClass = [[self class] superclass];
    NSString *descriptionString = [self FUZ_methodsDescriptionOfClass:objectClass];
    return descriptionString;
}

- (NSString *)ED_debugSuperProperties
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuperPropertyObjects
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuperIvars
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuperIvarObjects
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfPropertyObjectsAddress
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;

}

- (NSString *)ED_debugSuperPropertyObjectsAddress
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
    NSString *descriptionString = [self FUZ_propertiesDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDPropertyObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSelfIvarObjectsAddress
{
    Class objectClass = [self class];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarObjectsViewer class]];
    return descriptionString;
}

- (NSString *)ED_debugSuperIvarObjectsAddress
{
    Class objectClass = [[self class] superclass];
    EDValueViewerBuilder *builder = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
    NSString *descriptionString = [self FUZ_ivarsDescriptionOfClass:objectClass withValueViewerBuilder:builder viewerClass:[EDIvarObjectsViewer class]];
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
    
    NSString *descriptionString = [NSString stringWithFormat:@"<%@ : %p - properties>\n", [self class], self];
    if(class != [self class])
    {
        descriptionString = [NSString stringWithFormat:@"<%@->%@ : %p - properties>\n", [self class], class, self];
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
    
    NSString *descriptionString = [NSString stringWithFormat:@"<%@ : %p - ivars>\n", [self class], self];
    if(class != [self class])
    {
        descriptionString = [NSString stringWithFormat:@"<%@->%@ : %p - ivars>\n", [self class], class, self];
    }
    
    for (unsigned int i = 0; i < ivarsCount; i++)
    {
        NSString *propertyDescription = [viewerClass descriptionOfIvar:ivars[i] forObject:self valueBuilder:builder indent:1];
        descriptionString = [descriptionString stringByAppendingString:propertyDescription];
    }
    free(ivars);
    return descriptionString;
}

- (NSString *)FUZ_methodsDescriptionOfClass:(Class)class
{
    unsigned int methodsCount = 0;
    Method *methods = class_copyMethodList(class, &methodsCount);
    
    NSString *descriptionString = [NSString stringWithFormat:@"<%@ : %p - methods>\n", [self class], self];
    if(class != [self class])
    {
        descriptionString = [NSString stringWithFormat:@"<%@->%@ : %p - methods>\n", [self class], class, self];
    }
    
    for (unsigned int i = 0; i < methodsCount; i++)
    {
        NSString *methodDescription = [NSString stringWithFormat:@"\t%@\n", NSStringFromSelector(method_getName(methods[i]))];
        descriptionString = [descriptionString stringByAppendingString:methodDescription];
    }
    free(methods);
    return descriptionString;
}

@end
