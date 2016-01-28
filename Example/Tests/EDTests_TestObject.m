//
//  EDTests_TestObject.m
//  EDExtendedDebug
//
//  Created by Petro Korienev on 1/24/16.
//  Copyright © 2016 Alexey Fayzullov. All rights reserved.
//

#import "EDTests_TestObject.h"

@implementation EDTests_TestObject

- (id)nameBreakingCocoaConventions {
    [self doesNotRecognizeSelector:_cmd];
    return self;
}

@end