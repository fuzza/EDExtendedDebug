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

@interface EBValueViewerBuilder : NSObject

- (EDPropertyValueViewer *)buildViewerWithReceiver:(id)receiver key:(NSString *)key objCType:(const char *)type;

- (void)setupObjectFormatter;
- (void)setupNumericFormatter;
- (void)setupCStringFormatter;
- (void)setupSelectorFormatter;
- (void)setupClassFormatter;
- (void)setupStructFormatter;

@end
