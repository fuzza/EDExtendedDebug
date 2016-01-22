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

#import "EDPropertyHelper.h"

@implementation EDCycleDetector

- (NSString *)objectHasRetainCycles:(id)receiver
{
    NSString *returnValue = @"Retain cycle not found";
    
    std::vector<objc_property_t>properties = [self propertiesOfObject:receiver];
    for(std::vector<objc_property_t>::iterator it = properties.begin(); it != properties.end(); ++it)
    {
        objc_property_t property = *it;
        id objectValue = [EDPropertyHelper objectValueOfProperty:property forObject:receiver];
        
        std::vector<objc_property_t>childProperties = [self propertiesOfObject:objectValue];
        
        for(std::vector<objc_property_t>::iterator childIt = childProperties.begin(); childIt != childProperties.end(); ++childIt)
        {
            objc_property_t childProperty = *childIt;
            id childObjectValue = [EDPropertyHelper objectValueOfProperty:childProperty forObject:objectValue];
            
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

@end
