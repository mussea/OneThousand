//
//  SignUpViewController.h
//  OneThousand
//
//  Created by Ahmed Fathi on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface SignUpViewController : UIViewController<UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel *signuptitle;
    IBOutlet UIButton *backbtn;
    IBOutlet UITextField *fname;
    IBOutlet UITextField *lname;
    IBOutlet UITextField *email;
    IBOutlet UIScrollView *signupscrollview;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
- (IBAction)goback:(id)sender;
- (IBAction)nextstep:(id)sender;
@end
