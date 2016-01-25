//
//  FUZPropertyViewStrategy.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "EDValueViewerProtocol.h"

@interface EDPropertyValueViewer : NSObject <EDValueViewerProtocol>

- (NSString *)showValueForProperty:(objc_property_t)property ofObject:(id)anObject;

@end
