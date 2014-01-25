//
//  ViewController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/5/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self moveToolbarToFront];
    return TRUE;
}

- (void)removeViews:(id)sender {
    [dayField resignFirstResponder];
    [pickerToolbar removeFromSuperview];
    [dateInput removeFromSuperview];
}


- (IBAction) doneAction: (id) sender
{
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    
    [UIView beginAnimations:@"MoveOut" context:nil];
    dateInput.frame = datePickerTargetFrame;
    pickerToolbar.frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    
}

-(void)moveToolbarToFront
{
    CGRect toolbarTargetFrame = CGRectMake(0, 173, 320, 44);
    [UIView beginAnimations:@"MoveIn" context:nil];
    pickerToolbar.frame = toolbarTargetFrame;
    [UIView commitAnimations];
    
    [self.view addSubview: pickerToolbar];
}

-(void)datePicked
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"pt_BR"]];
    
    NSString *dateTimeString = [dateFormatter stringFromDate: dateInput.date];
    
    //NSLog(@"set tapped, date: %@",dateTimeString);
    
    dayField.text = dateTimeString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"loadei a view princiapal...");
    
    //NSDate *now = [NSDate date];
    
    dayField.inputView = dateInput;
    dayField.delegate = self;
//    dateInput.minimumDate = [NSDate dateWithTimeInterval: -10 sinceDate:[NSDate date]];
    
    [dateInput addTarget:self action:@selector(datePicked) forControlEvents:UIControlEventValueChanged];
    
    [self datePicked];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(configureView) name:@"alarmSet" object:nil];
    
//    [self configureView];
}

- (void) configureView
{
    BOOL alarmSet = [[NSUserDefaults standardUserDefaults] boolForKey:@"alarmSet"];
    
    if(alarmSet)
    {
        [dayField removeFromSuperview];
        activateAlarmButton.titleLabel.text = @"Reiniciar alarme";
    }
    else
    {
        [self.view addSubview: dayField];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) presentMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loceryl" message: message delegate: nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
}

-(void) scheduleLocalNotificationWithDate: (NSDate *) fireDate
{
    
    [[NSUserDefaults standardUserDefaults] setObject:fireDate forKey:@"alarmDate"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"alarmSet"];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = fireDate;
    notification.alertBody = @"Hora do Loceryl!";
    notification.soundName = @"Can.wav";

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    //[notification release];
}

- (IBAction)alarmSetButtonTapped:(id)sender {
    
    BOOL alarmSet = [[NSUserDefaults standardUserDefaults] boolForKey: @"alarmSet"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    if(alarmSet)
    {
        NSDate *alarmDate = [[NSUserDefaults standardUserDefaults] objectForKey: @"alarmDate"];
        
        NSDateComponents *alarmDateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:alarmDate];
        
        [self presentMessage: [NSString stringWithFormat:@"O alarme já está programado para o dia %i às %02i:%02i", [alarmDateComponents day], [alarmDateComponents hour],[alarmDateComponents minute]]];
    }
    else
    {
        //[fieldDate setDay: dayField.text.intValue];
        
        NSDate *now = [NSDate date];
        
        
        NSDateComponents *nowComponents = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
        
        NSDateComponents *inputComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: dateInput.date];
        
        NSDateComponents *alarmComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: dateInput.date];
        
        [alarmComponents setDay: inputComponents.day+7];
        [alarmComponents setHour: nowComponents.hour];
        [alarmComponents setMinute:nowComponents.minute];
        [alarmComponents setSecond:nowComponents.second];
        
        NSDate *alarmDate = [gregorian dateFromComponents: alarmComponents];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        
        NSString *dateTimeString = [dateFormatter stringFromDate: alarmDate];
        
        NSLog(@"set tapped, date: %@",dateTimeString);
        
        NSDate *teste = [NSDate dateWithTimeIntervalSinceNow:10];
        
  //      [self scheduleLocalNotificationWithDate: alarmDate];
        [self scheduleLocalNotificationWithDate: teste];
        
        [self presentMessage:@"O aplicativo vai lembrá-lo da aplicação em 7 dias."];
    }
    
}

- (IBAction)alarmCancelButtonTapped:(id)sender {
    NSLog(@"cancel tapped");
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alarmSet"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"alarmDate"];
    
    [self presentMessage:@"O aplicativo não vai emitir mais lembretes."];
}

@end
