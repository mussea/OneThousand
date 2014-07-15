//
//  SignUpViewController.m
//  OneThousand
//
//  Created by Ahmed Fathi on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    backbtn.titleLabel.font = [UIFont fontWithName:@"Franchise" size:70];
    signuptitle.font = [UIFont fontWithName:@"Franchise" size:40];
    fname.backgroundColor = [UIColor whiteColor];
    fname.layer.masksToBounds =  YES;
    fname.bounds = CGRectMake(0, 0, 270, 50);
    
    lname.backgroundColor = [UIColor whiteColor];
    lname.layer.masksToBounds =  YES;
    lname.bounds = CGRectMake(0, 0, 270, 50);
    
    email.backgroundColor = [UIColor whiteColor];
    email.layer.masksToBounds =  YES;
    email.bounds = CGRectMake(0, 0, 270, 50);
    

    
    signupscrollview.contentSize = CGSizeMake(0, 560);

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [signupscrollview addGestureRecognizer:tapGesture];
}

-(void)hideKeyboard{
    [email resignFirstResponder];
    [lname resignFirstResponder];
    [fname resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//go back to the main page
- (IBAction)goback:(id)sender {
    NSLog(@"back");
}

// Save data into parse
- (IBAction)nextstep:(id)sender {
    if(email.text.length == 0){
        UIAlertView *fillboxes = [[UIAlertView alloc] initWithTitle:@"Boxes are empty" message:@"Please fill the empty boxes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fillboxes show];
    }else
    
    if(lname.text.length == 0){
        UIAlertView *fillboxes = [[UIAlertView alloc] initWithTitle:@"Boxes are empty" message:@"Please fill the empty boxes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fillboxes show];
    }else
    
    if(fname.text.length == 0){
        UIAlertView *fillboxes = [[UIAlertView alloc] initWithTitle:@"Boxes are empty" message:@"Please fill the empty boxes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fillboxes show];
    }else{
        // sign up
        NSLog(@"go next");
        
        [self.view endEditing:YES];
        NSString *user = [fname text];
        NSString *pass = [lname text];
        
        if ([user length] < 4 || [pass length] < 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Username and Password must both be at least 4 characters long." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
        } else {
            
            [activityIndicator startAnimating];
            
            PFUser *newUser = [PFUser user];
            newUser.username = user;
            newUser.password = pass;
            fname.userInteractionEnabled = NO;
            lname.userInteractionEnabled = NO;
            email.userInteractionEnabled = NO;
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [activityIndicator stopAnimating];
                if (error) {
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                    fname.userInteractionEnabled = YES;
                    lname.userInteractionEnabled = YES;
                    email.userInteractionEnabled = YES;
                } else {
                    // [self performSegueWithIdentifier:@"signupToMain" sender:self];
                    UIAlertView *success = [[UIAlertView alloc]initWithTitle:@"Hell yeah" message:@"it works" delegate:nil cancelButtonTitle:@"cool!" otherButtonTitles:nil];
                    [success show];
                    
                    fname.userInteractionEnabled = YES;
                    lname.userInteractionEnabled = YES;
                    email.userInteractionEnabled = YES;
                }
            }];
        }
    }
    
}
@end
