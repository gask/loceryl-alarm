//
//  AlarmViewController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/24/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import "AlarmViewController.h"

@interface AlarmViewController ()

@property (nonatomic) NSArray *delayArray;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *data = [[NSArray alloc] initWithObjects: @"Não Adiar", @"Adiar 30min", @"Adiar 1h", @"Adiar 4h", nil];
    
    self.delayArray = data;
	// Do any additional setup after loading the view.
}

#pragma mark Picker Data Source methods

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_delayArray count];
}

#pragma mark Picker Delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_delayArray objectAtIndex:row];
}

- (IBAction) setDelayToAlarm:(id)sender
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSInteger selectedDelayIndex = [_snoozePicker selectedRowInComponent:0];
    NSInteger secondsSelected = 0;
    
    if(selectedDelayIndex == 1) secondsSelected = 30*60;
    else if(selectedDelayIndex == 2) secondsSelected = 60*60;
    else if(selectedDelayIndex == 3) secondsSelected = 4*60*60;
    else if(selectedDelayIndex == 0)
    {
        NSLog(@"hehe, nada de adiar...");
        secondsSelected = 7*24*60*60;
    }
    else
    {
        NSLog(@"deu erro");
    }
    
    NSLog(@"selecionou %li horas.", secondsSelected/60/60);
    
    NSDate *oldAlarmDate = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
    
    NSDate *alarmDate = [NSDate dateWithTimeInterval: secondsSelected sinceDate:oldAlarmDate];
    
    [[NSUserDefaults standardUserDefaults] setObject: alarmDate forKey:@"alarmDate"];
    
    [self scheduleLocalNotificationWithDate: alarmDate];
    
    UIViewController *followUpView = [self.storyboard instantiateViewControllerWithIdentifier:@"FollowUpView"];
    
    followUpView.modalPresentationStyle = UIModalPresentationFullScreen;
    followUpView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController: followUpView animated:YES completion:nil];

    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alarmSet" object:nil];
    
}

/*- (IBAction) delayAlarmThirtyMinutes:(id)sender
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
}*/

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
    notification.alertBody = @"É hora de aplicar Loceryl esmalte";
    notification.soundName = @"locerylsound.mp3";
    notification.repeatInterval = NSWeekCalendarUnit;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    //[notification release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
