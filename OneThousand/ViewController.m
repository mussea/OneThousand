//
//  ViewController.m
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import "ViewController.h"
#import "PicturesViewController.h"
#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [PFFacebookUtils initializeFacebook];
    
    mtitle.font = [UIFont fontWithName:@"Franchise" size:85];
    loginbtn.titleLabel.font = [UIFont fontWithName:@"Franchise" size:32];
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        //[self performSegueWithIdentifier:@"toMain" sender:self];
    }
    
    
}
- (IBAction)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        // [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            ProfileViewController *controller = [[ProfileViewController alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"toMain" sender:self];         }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Sign Up with Linked in button
- (IBAction)linkedinSignup:(id)sender {
}

//Sign Up with email button
- (IBAction)emailSignup:(id)sender {
}

//Log in button
- (IBAction)login:(id)sender {
}



@end
