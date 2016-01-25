//
//  FUZPropertyValueViewerDefaultBuilder.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDFormatters.h"
#import "EDValueViewerProtocol.h"

@interface EDValueViewerBuilder : NSObject

+ (instancetype)valueViewerBuilderWithViewerClass:(Class<EDValueViewerProtocol>)viewerClass;
- (instancetype)initWithViewerClass:(Class<EDValueViewerProtocol>)viewerClass;

@property (nonatomic, strong, readonly) id<EDValueViewerProtocol> viewer;
@property (nonatomic, assign, readonly) Class<EDValueViewerProtocol> viewerClass;

- (id<EDValueViewerProtocol>)build;

- (void)setupFormatter;
- (void)setupObjectFormatter;
- (void)setupAtomicTypesFormatter;
- (void)setupClassFormatter;
- (void)setupStructFormatter;

@end
