//
//  EDCycleDetector.m
//  Pods
//
//  Created by Alexey Fayzullov on 5/22/15.
//
//

#import "EDCycleDetector.h"
#import "objc/runtime.h"

#import "EDPropertyObjectsViewer.h"
#import "EDValueViewerAddressBuilder.h"

#include <stdio.h>
#include <vector>

@implementation EDCycleDetector

- (NSString *)objectHasRetainCycles:(id)receiver
{
    NSString *returnValue = @"Retain cycle not found";
    
    std::vector<objc_property_t>properties = [self propertiesOfObject:receiver];
    for(std::vector<objc_property_t>::iterator it = properties.begin(); it != properties.end(); ++it)
    {
        objc_property_t property = *it;
        id objectValue = [self objectFromProperty:property receiver:receiver];
        
        std::vector<objc_property_t>childProperties = [self propertiesOfObject:objectValue];
        
        for(std::vector<objc_property_t>::iterator childIt = childProperties.begin(); childIt != childProperties.end(); ++childIt)
        {
            objc_property_t childProperty = *childIt;
            id childObjectValue = [self objectFromProperty:childProperty receiver:objectValue];
            
            if(receiver == childObjectValue)
            {
                returnValue = [NSString stringWithFormat:@"Found retain cycle between %@ and %@", receiver, objectValue];
            }
        }
        childProperties.clear();
    }
    
    properties.clear();
    return returnValue;
}

- (id)objectFromProperty:(objc_property_t)property receiver:(id)receiver
{
    const char *encodedReturnType = property_copyAttributeValue(property, "T");
    NSString *getter = [self getterNameForProperty:property];
    
    EDValueViewerAddressBuilder *builder = [[EDValueViewerAddressBuilder alloc] init];
    [builder build];
    
    NSValue *resultValue = [builder.viewer obtainValueWithReceiver:receiver key:getter objCType:encodedReturnType];
    
    if(resultValue)
    {
        __unsafe_unretained id resultObject;
        [resultValue getValue:&resultObject];
        if(resultObject)
        {
            return resultObject;
        }
    }
    return nil;
}

- (std::vector<objc_property_t>)propertiesOfObject:(id)object
{
    unsigned int propertiesCount;
    objc_property_t *properties = class_copyPropertyList([object class], &propertiesCount);
    
    std::vector<objc_property_t> filteredProperties;
    
    for(unsigned int i = 0; i < propertiesCount; i++)
    {
        const char *encodedReturnType = property_copyAttributeValue(properties[i], "T");
        char *strongAttribute = property_copyAttributeValue(properties[i], "&");
        
        if(encodedReturnType[0] == '@' && strongAttribute != NULL)
        {
            filteredProperties.push_back(properties[i]);
        }
    }
    free(properties);
    return filteredProperties;
}


- (NSString *)getterNameForProperty:(objc_property_t)property
{
    const char *getterName = property_copyAttributeValue(property, "G");
    if(getterName == nil)
    {
        return [self nameOfProperty:property];
    }
    return [NSString stringWithCString:getterName encoding:NSUTF8StringEncoding];
}

- (NSString *)nameOfProperty:(objc_property_t)property
{
    return [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
}

@end
