//
//  FUZPropertyValueViewerDefaultBuilder.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EBValueViewerBuilder.h"

@interface EBValueViewerBuilder ()

@property (nonatomic, strong) EDPropertyValueViewer *viewer;

@end

@implementation EBValueViewerBuilder

- (EDPropertyValueViewer *)buildViewerWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type
{
    self.viewer = [[EDPropertyValueViewer alloc] initWithReceiver:receiver key:key objCType:type];
    
    [self setupObjectFormatter];
    [self setupNumericFormatter];
    [self setupCStringFormatter];
    [self setupSelectorFormatter];
    [self setupClassFormatter];
    [self setupStructFormatter];
    
    return self.viewer;
}

- (void)setupObjectFormatter
{
    self.viewer.objectFormatter = [EDDescriptionFormatter new];
}

- (void)setupNumericFormatter
{
    self.viewer.numericFormatter = [EDNumericFormatter new];
}

- (void)setupCStringFormatter
{
    self.viewer.cStringFormatter = [EDCStringFormatter new];
}

- (void)setupSelectorFormatter
{
    self.viewer.selectorFormatter = [EDSelectorFormatter new];
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
