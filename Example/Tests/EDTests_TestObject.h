//
//  EDTests_TestObject.h
//  EDExtendedDebug
//
//  Created by Petro Korienev on 1/24/16.
//  Copyright © 2016 Alexey Fayzullov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDTests_TestObject : NSObject {
@public
    id _objectIvar;
    int _intIvar;
    CGRect _rectIvar;
    void(^_blockIvar)();
}
@property (nonatomic, strong) id simpleProperty;
@property (nonatomic, getter=nameBreakingCocoaConventions) id customGetterProperty;
@property (nonatomic, setter=nameBreakingCocoaConventions:) id customSetterProperty;

@end
