//
//  EDValueViewerProtocol.h
//  
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import <Foundation/Foundation.h>
#import "EDValueFormatterProtocol.h"

@protocol EDValueViewerProtocol <NSObject>

@property (nonatomic, strong) id<EDValueFormatterProtocol> objectFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> classFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> atomicTypesFormatter;
@property (nonatomic, strong) id<EDValueFormatterProtocol> structFormatter;

+ (instancetype)alloc;

@end
