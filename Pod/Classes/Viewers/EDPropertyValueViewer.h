//
//  FUZPropertyViewStrategy.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "EDFormatters.h"

@interface EDPropertyValueViewer : NSObject

@property (nonatomic, strong) id<EDValueFormatterProtocol> objectFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> classFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> atomicTypesFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> structFormatter;

- (NSString *)showValueForProperty:(objc_property_t)property ofObject:(id)anObject;

@end
