//
//  ThreeBtnController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/19/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import "ThreeBtnController.h"

@interface ThreeBtnController ()

@end

@implementation ThreeBtnController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"prepare for SEGUE!!!");
    /*if ([[segue identifier] isEqualToString:@"TabControllerSegue"])
    {
        UITabBarController *tabController = [segue destinationViewController];
        UIButton *senderButton = (UIButton *)sender;
        
        //NSLog(@"senderButton tag: %i", senderButton.tag);
        
        if(senderButton.tag == 0) tabController.selectedIndex = 2;
        else if(senderButton.tag == 1) tabController.selectedIndex = 0;
        else if(senderButton.tag == 2) tabController.selectedIndex = 1;
        
    }*/
    UITabBarController *tabController = [segue destinationViewController];
    
    //NSLog(@"seg id: %@",[segue identifier]);
    
    if ([[segue identifier] isEqualToString:@"QuizControllerSegue"])
    {
        //NSLog(@"quiz cnt");
        tabController.selectedIndex = 2;
    }
    else if([[segue identifier] isEqualToString:@"AlarmControllerSegue"])
    {
        //NSLog(@"alarm cnt");
        tabController.selectedIndex = 0;
    }
    else if([[segue identifier] isEqualToString:@"CameraControllerSegue"])
    {
        //NSLog(@"camera cnt");
        tabController.selectedIndex = 1;
    }
}

@end
