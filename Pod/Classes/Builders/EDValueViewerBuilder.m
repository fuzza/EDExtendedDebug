//
//  FUZPropertyValueViewerDefaultBuilder.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDValueViewerBuilder.h"

@interface EDValueViewerBuilder ()

@end

@implementation EDValueViewerBuilder

- (EDPropertyValueViewer *)build
{
    self.viewer = [[EDPropertyValueViewer alloc] init];
    [self setupFormatter];
    return self.viewer;
}

- (void)setupFormatter
{
    [self setupObjectFormatter];
    [self setupAtomicTypesFormatter];
    [self setupClassFormatter];
    [self setupStructFormatter];
}

- (void)setupObjectFormatter
{
    self.viewer.objectFormatter = [EDDescriptionFormatter new];
}

- (void)setupAtomicTypesFormatter
{
    self.viewer.atomicTypesFormatter = [EDAtomicTypesFormatter new];
}

- (void)setupClassFormatter
{
    self.viewer.classFormatter = [EDDescriptionFormatter new];
}

- (void)setupStructFormatter
{
    self.viewer.structFormatter = [EDStructFormatter new];
}

@end
