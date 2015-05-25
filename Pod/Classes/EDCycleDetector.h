//
//  EDCycleDetector.h
//  Pods
//
//  Created by Alexey Fayzullov on 5/22/15.
//
//

#import <Foundation/Foundation.h>

@interface EDCycleDetector : NSObject

- (NSString *)objectHasRetainCycles:(id)receiver;

@end
