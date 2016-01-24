//
//  EDPropertyViewerProtocol.h
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import <Foundation/Foundation.h>
#import "EDViewerProtocol.h"

@protocol EDPropertyViewerProtocol <EDViewerProtocol>

+ (NSString *)descriptionOfProperty:(objc_property_t)property forObject:(id)object valueBuilder:(EDValueViewerBuilder *)builder indent:(NSInteger)indent;

@end
