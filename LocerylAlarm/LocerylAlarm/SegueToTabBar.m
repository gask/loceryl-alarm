//
//  SegueToTabBar.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/19/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import "SegueToTabBar.h"

@implementation SegueToTabBar

- (void)perform
{
    // Add your own animation code here.
    //NSLog(@"perform");
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:YES];
}

@end
