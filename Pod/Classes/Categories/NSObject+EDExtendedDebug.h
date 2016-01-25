//
//  NSObject+FUZExtendedDebug.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/13/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EDExtendedDebug)

- (NSString *)ED_debugSelfProperties;
- (NSString *)ED_debugSuperProperties;
- (NSString *)ED_debugSelfIvars;
- (NSString *)ED_debugSuperIvars;

- (NSString *)ED_debugSelfPropertyObjects;
- (NSString *)ED_debugSuperPropertyObjects;
- (NSString *)ED_debugSelfIvarObjects;
- (NSString *)ED_debugSuperIvarObjects;

- (NSString *)ED_debugSelfPropertyObjectsAddress;
- (NSString *)ED_debugSuperPropertyObjectsAddress;
- (NSString *)ED_debugSelfIvarObjectsAddress;
- (NSString *)ED_debugSuperIvarObjectsAddress;

- (NSString *)ED_detectRetainCycles;

@end
