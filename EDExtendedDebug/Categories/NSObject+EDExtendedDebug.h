//
//  NSObject+FUZExtendedDebug.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/13/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EDExtendedDebug)

- (NSString *)ED_debugSelf;
- (NSString *)ED_debugSuper;

- (NSString *)ED_debugSelfObjects;
- (NSString *)ED_debugSuperObjects;

- (NSString *)ED_debugSelfObjectsAddress;
- (NSString *)ED_debugSuperObjectsAddress;

@end
