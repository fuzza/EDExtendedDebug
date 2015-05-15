//
//  FUZPropertyValueViewerDefaultBuilder.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDPropertyValueViewer.h"
#import "EDFormatters.h"

@interface EDValueViewerBuilder : NSObject

@property (nonatomic, strong) EDPropertyValueViewer *viewer;

- (EDPropertyValueViewer *)build;

- (void)setupFormatter;
- (void)setupObjectFormatter;
- (void)setupNumericFormatter;
- (void)setupCStringFormatter;
- (void)setupSelectorFormatter;
- (void)setupClassFormatter;
- (void)setupStructFormatter;

@end
