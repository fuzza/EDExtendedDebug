//
//  FUZPropertyViewer.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "EBValueViewerBuilder.h"

@interface EDPropertyViewer : NSObject

+ (NSString *)descriptionOfProperty:(objc_property_t)property forObject:(id)object valueBuilder:(EBValueViewerBuilder *)builder;
+ (BOOL)returnTypeIsAllowed:(const char *)type;

@end
