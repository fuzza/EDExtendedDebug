//
//  EDIvarViewerProtocol.h
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import <Foundation/Foundation.h>
#import "EDViewerProtocol.h"
#import "EDValueViewerBuilder.h"
#import <objc/runtime.h>

@protocol EDIvarViewerProtocol <EDViewerProtocol>

+ (NSString *)descriptionOfIvar:(Ivar)property forObject:(id)object valueBuilder:(EDValueViewerBuilder *)builder indent:(NSInteger)indent;

@end
