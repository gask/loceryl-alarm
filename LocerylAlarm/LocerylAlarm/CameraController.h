//
//  CameraController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/4/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;

@end
