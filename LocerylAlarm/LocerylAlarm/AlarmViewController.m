//
//  AlarmViewController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/24/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import "AlarmViewController.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) delayAlarmTenMinutes:(id)sender
{
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval:60*10 sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) delayAlarmThirtyMinutes:(id)sender
{
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval:60*30 sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) delayAlarmOneHour:(id)sender
{
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval:60*60 sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) delayAlarmFourHours:(id)sender
{
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval:60*60*4 sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) delayAlarmTwelveHours:(id)sender
{
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval:60*60*12 sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) scheduleLocalNotificationWithDate: (NSDate *) fireDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    NSString *dateTimeString = [dateFormatter stringFromDate: fireDate];
    
    NSLog(@"set tapped, date: %@",dateTimeString);
    
    [[NSUserDefaults standardUserDefaults] setObject:fireDate forKey:@"alarmDate"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"alarmSet"];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = fireDate;
    notification.alertBody = @"Hora do Loceryl!";
    notification.soundName = @"Can.wav";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    //[notification release];
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

@end
