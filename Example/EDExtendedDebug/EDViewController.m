//
//  EDViewController.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 05/15/2015.
//  Copyright (c) 2014 Alexey Fayzullov. All rights reserved.
//

#import "EDViewController.h"
#import <EDExtendedDebug/NSObject+EDExtendedDebug.h>

#import <EDExtendedDebug/EDCycleDetector.h>

@implementation EDObject : NSObject

@end


@interface EDViewController ()

@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aClass = [NSObject class];
    self.selector = @selector(stringWithFormat:);
    
    self.anInteger = 25;
    self.aFloat = 13.25;
    
    self.rect = CGRectMake(0, 0, 320, 240);

    self.object = [EDObject new];
    self.object.controller = self;
    self.object->_ivar = self;
    
    NSLog(@"%@", [self ED_detectRetainCycles]);
    
    NSLog(@"%@", [self ED_debugSelfProperties]);
    NSLog(@"%@", [self.view ED_debugSelfProperties]);
    NSLog(@"%@", [self.view ED_debugSuperProperties]);

    NSLog(@"%@", [self.view ED_debugSelfPropertyObjects]);
    NSLog(@"%@", [self.view ED_debugSuperPropertyObjects]);
    
    NSLog(@"%@", [self.view ED_debugSelfPropertyObjectsAddress]);
    NSLog(@"%@", [self.view ED_debugSuperPropertyObjectsAddress]);

    NSLog(@"%@", [self ED_debugSelfIvars]);
    NSLog(@"%@", [self.view ED_debugSelfIvars]);
    NSLog(@"%@", [self.view ED_debugSuperIvars]);
    
    NSLog(@"%@", [self.view ED_debugSelfIvarObjects]);
    NSLog(@"%@", [self.view ED_debugSuperIvarObjects]);
    
    NSLog(@"%@", [self.view ED_debugSelfIvarObjectsAddress]);
    NSLog(@"%@", [self.view ED_debugSuperIvarObjectsAddress]);
}

@end
