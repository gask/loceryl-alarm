//
//  CameraController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/4/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import "CameraController.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Resize.h"

@interface CameraController ()

@end

@implementation CameraController

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
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    float divisor = 5.1f;
    
    if(chosenImage.size.width < 1000) divisor = 1.0f;
    
    // 2448 x 3264 --> 5.1
    // 480 x 640
    CGSize newSize = CGSizeMake(chosenImage.size.width/divisor, chosenImage.size.height/divisor);
    
    //NSLog(@"w: %f h: %f", newSize.width, newSize.height);
    
    UIImage *newOne = [chosenImage resizedImage: newSize interpolationQuality:kCGInterpolationHigh];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"pt_BR"]];
    
    NSString *dateTimeString = [dateFormatter stringFromDate: [NSDate date]];
    
    //NSLog(@"data: %@",dateTimeString);
    
    NSArray *picIDs = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"picIDs"];
    
    int thisPicID = 1;
    if(picIDs.count > 0)
    {
        //NSLog(@"tem outros ids");
        thisPicID = [[picIDs valueForKeyPath:@"@max.intValue"] intValue]+1;
        picIDs = [picIDs arrayByAddingObject:[NSNumber numberWithInt: thisPicID]];
    }
    else
    {
        //NSLog(@"primeiro ID");
        picIDs = [NSArray arrayWithObject: [NSNumber numberWithInt:1]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject: picIDs forKey: @"picIDs"];
    
    [[NSUserDefaults standardUserDefaults] setValue:dateTimeString forKey:[NSString stringWithFormat: @"photoname%i", thisPicID]];
    
    
    //NSLog(@"%i", thisPicID);
    
    NSData *pngData = UIImagePNGRepresentation(newOne);
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
     NSString *filePath = [documentsPath stringByAppendingPathComponent: [NSString stringWithFormat: @"photoname%i.png", thisPicID]]; //Add the file name
     [pngData writeToFile:filePath atomically:YES]; //Write the file
     
     //NSLog(@"saving to path... %@", filePath);
    
    //[self savePhotoWithDict:info andName:[NSString stringWithFormat: @"photoname%i.png", thisPicID]];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)takePhoto:(id)sender
{
    /*UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];*/
    
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    /*cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];*/
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController: cameraUI animated: YES completion:NULL];
    return YES;
}

- (void) savePhotoWithDict: (NSDictionary *) info andName:(NSString *) name
{
    // Get your image.
    UIImage *capturedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Get your metadata (includes the EXIF data).
    NSDictionary *metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
    
    // Create your file URL.
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSURL *docsURL = [[defaultManager URLsForDirectory:NSDocumentDirectory
                                             inDomains:NSUserDomainMask] lastObject];
    NSURL *outputURL = [docsURL URLByAppendingPathComponent:name];
    
    //NSLog(@"and the location is: %@", outputURL);
    
    // Set your compression quuality (0.0 to 1.0).
    NSMutableDictionary *mutableMetadata = [metadata mutableCopy];
    
    //NSLog(@"%@", mutableMetadata);
    
    [mutableMetadata setObject:@(1.0) forKey:(__bridge NSString *)kCGImageDestinationLossyCompressionQuality];
    
    // Create an image destination.
    CGImageDestinationRef imageDestination = CGImageDestinationCreateWithURL((__bridge CFURLRef)outputURL, kUTTypePNG , 1, NULL);
    if (imageDestination == NULL ) {
        
        // Handle failure.
        //NSLog(@"Error -> failed to create image destination.");
        return;
    }
    
    // Add your image to the destination.
    CGImageDestinationAddImage(imageDestination, capturedImage.CGImage, (__bridge CFDictionaryRef)mutableMetadata);
    
    // Finalize the destination.
    if (CGImageDestinationFinalize(imageDestination) == NO) {
        
        // Handle failure.
        //NSLog(@"Error -> failed to finalize the image.");
    }
    
    CFRelease(imageDestination);
}

@end
