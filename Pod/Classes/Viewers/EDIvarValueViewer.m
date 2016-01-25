//
//  EDIvarValueViewer.m
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import "EDIvarValueViewer.h"

@implementation EDIvarValueViewer

@synthesize structFormatter;
@synthesize objectFormatter;
@synthesize classFormatter;
@synthesize atomicTypesFormatter;

- (NSString *)showValueForIvar:(id)ivar ofObject:(id)anObject {
    return @"";
}

@end
