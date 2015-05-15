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

@property (nonatomic, strong) id<EDObjectFormatterProtocol> objectFormatter;
@property (nonatomic, strong) id<EDObjectFormatterProtocol> classFormatter;

@property (nonatomic, strong) id<EDNumericFormatterProtocol> numericFormatter;

@property (nonatomic, strong) id<EDValueFormatterProtocol> cStringFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> selectorFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> structFormatter;

@property (nonatomic, strong, readonly) id receiver;
@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, assign, readonly) const char *objCType;

- (NSString *)showValueWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type;

@end
