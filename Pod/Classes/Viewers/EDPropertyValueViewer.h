//
//  FUZPropertyViewStrategy.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDFormatters.h"

@interface EDPropertyValueViewer : NSObject

@property (nonatomic, strong) id<EDValueFormatterProtocol> objectFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> classFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> atomicTypesFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> structFormatter;

@property (nonatomic, strong, readonly) id receiver;
@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, assign, readonly) const char *objCType;

- (NSValue *)obtainValue;
- (NSString *)showValueWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type;

@end
