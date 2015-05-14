//
//  FUZNumericFormatterProtocol.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EDNumericFormatterProtocol <NSObject>

- (NSString *)formatNumericFromValue:(NSNumber *)value;
- (NSString *)formatBoolFromValue:(NSNumber *)value;
- (NSString *)formatCharFromValue:(NSNumber *)value;

@end
