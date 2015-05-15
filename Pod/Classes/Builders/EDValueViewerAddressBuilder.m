//
//  EDValueViewerAddressBuilder.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/15/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDValueViewerAddressBuilder.h"

@implementation EDValueViewerAddressBuilder

- (void)setupObjectFormatter
{
    self.viewer.objectFormatter = [EDAddressFormatter new];
}

@end
