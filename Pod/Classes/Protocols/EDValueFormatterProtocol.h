//
//  EDValueFormatterProtocol.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EDValueFormatterProtocol <NSObject>

- (NSString *)formatValue:(NSValue *)value;

@end
