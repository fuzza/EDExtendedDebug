//
//  FUZPropertyValueViewerDefaultBuilder.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDValueViewerBuilder.h"
#import <objc/runtime.h>

@interface EDValueViewerBuilder ()

@property (nonatomic, strong, readwrite) id<EDValueViewerProtocol> viewer;
@property (nonatomic, assign, readwrite) Class<EDValueViewerProtocol> viewerClass;

@end

@implementation EDValueViewerBuilder

- (instancetype)init {
    NSAssert(NO, @"Forbidden; Use -initWithViewerClass: instead");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (instancetype)valueViewerBuilderWithViewerClass:(Class<EDValueViewerProtocol>)viewerClass {
    return [[self alloc] initWithViewerClass:viewerClass];
}

- (instancetype)initWithViewerClass:(Class<EDValueViewerProtocol>)viewerClass {
    self = [super init];
    if (self) {
        self.viewerClass = viewerClass;
    }
    return self;
}

- (id<EDValueViewerProtocol>)build
{
    self.viewer = [[self.viewerClass alloc] init];
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
