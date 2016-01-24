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
    id _publicIvar;
@package
    int _packageIvar;
@private
    CGRect _privateIvar;
@protected
    void(^_protectedIvar)();
}
@property (nonatomic, strong) id simpleProperty;
@property (nonatomic, getter=nameBreakingCocoaConventions) id customGetterProperty;
@property (nonatomic, setter=nameBreakingCocoaConventions:) id customSetterProperty;

@end
