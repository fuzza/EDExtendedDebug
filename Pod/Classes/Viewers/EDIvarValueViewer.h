//
//  EDIvarValueViewer.h
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "EDValueViewerProtocol.h"

@interface EDIvarValueViewer : NSObject <EDValueViewerProtocol>

- (NSString *)showValueForIvar:(Ivar)ivar ofObject:(id)anObject;

@end
