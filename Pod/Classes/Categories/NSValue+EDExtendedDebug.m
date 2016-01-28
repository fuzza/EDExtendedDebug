//
//  NSValue+EDExtendedDebug.m
//  Pods
//
//  Created by Petro Korienev on 1/24/16.
//
//

#import "NSValue+EDExtendedDebug.h"

@implementation NSValue (EDExtendedDebug)

- (id)objectValue {
    id __unsafe_unretained resultedObject = nil;
    if(self.objCType[0] == '@' || self.objCType[0] == '#')
    {
        [self getValue:&resultedObject];
    }
    return resultedObject;
}

@end
