//
//  LoginViewController.h
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface LoginViewController : UIViewController<UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    IBOutlet UIScrollView *scrollviewlogin;
    IBOutlet UILabel *logintitle;
    IBOutlet UIButton *gohome;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
- (IBAction)nextlogin:(id)sender;
@end
