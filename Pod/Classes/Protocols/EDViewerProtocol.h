//
//  EDViewerProtocol.h
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import <Foundation/Foundation.h>

@protocol EDViewerProtocol <NSObject>

+ (BOOL)returnTypeIsAllowed:(NSString *)type;

@end
