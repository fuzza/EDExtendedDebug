//
//  FUZPropertyViewer.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "EDValueViewerBuilder.h"
#import "EDValueViewerAddressBuilder.h"
#import "EDPropertyViewerProtocol.h"

@interface EDPropertyViewer : NSObject <EDPropertyViewerProtocol>

@end