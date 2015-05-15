//
//  EDViewController.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 05/15/2015.
//  Copyright (c) 2014 Alexey Fayzullov. All rights reserved.
//

#import "EDViewController.h"
#import <EDExtendedDebug/NSObject+EDExtendedDebug.h>

@interface EDViewController ()

@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", [self.view ED_debugSelf]);
    NSLog(@"%@", [self.view ED_debugSuper]);
    
    NSLog(@"%@", [self.view ED_debugSelfObjects]);
    NSLog(@"%@", [self.view ED_debugSuperObjects]);
    
    NSLog(@"%@", [self.view ED_debugSelfObjectsAddress]);
    NSLog(@"%@", [self.view ED_debugSuperObjectsAddress]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
