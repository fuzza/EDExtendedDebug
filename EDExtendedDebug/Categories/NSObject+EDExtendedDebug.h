//
//  NSObject+FUZExtendedDebug.h
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/13/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EDExtendedDebug)

- (NSString *)FUZ_debugSelf;
- (NSString *)FUZ_debugSuper;

- (NSString *)FUZ_debugSelfObjects;
- (NSString *)FUZ_debugSuperObjects;

@end
