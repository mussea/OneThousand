//
//  PicturesViewController.m
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import "PicturesViewController.h"
#import "PhotoDetailViewController.h"
#import <Parse/Parse.h>

@interface PicturesViewController ()

@end

@implementation PicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allImages = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"Photos";
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithTitle:@"Add a picture" style:UIBarButtonItemStyleBordered target:self action:@selector(cameraButtonTapped:)];
    self.navigationItem.leftBarButtonItem = cameraButton;
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height - 44)];
    
    [self.view addSubview:photoScrollView];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD hides
    [HUD removeFromSuperview];
    HUD = nil;
}

-(IBAction)cameraButtonTapped:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == YES){
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        NSLog(@"delegate");
        // Show image picker
        imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:imagePicker animated:YES completion:nil];
    
        NSLog(@"showing");
    }
    else{
        // Device has no camera
        UIImage *image;
        int r = arc4random() % 5;
        switch (r) {
            case 0:
                image = [UIImage imageNamed:@"ParseLogo.jpg"];
                break;
            case 1:
                image = [UIImage imageNamed:@"Crowd.jpg"];
                break;
            case 2:
                image = [UIImage imageNamed:@"Desert.jpg"];
                break;
            case 3:
                image = [UIImage imageNamed:@"Lime.jpg"];
                break;
            case 4:
                image = [UIImage imageNamed:@"Sunflowers.jpg"];
                break;
            default:
                break;
        }
        
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(640, 960));
        [image drawInRect: CGRectMake(0, 0, 640, 960)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
        
        [self uploadImage:imageData];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    [self uploadImage:imageData];
    
}

-(void)uploadImage:(NSData *)imageData{
    NSLog(@"uploading");
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    //HUD creation here (see example for code)
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"without errors");
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
        
            NSLog(@"create image");
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"username"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    //[self refresh:nil];
                    //[refreshHUD hide:YES];
                    NSLog(@"NO ERRORS");
                    [self loadParseImage:userPhoto forImageColumn:@"imageFile" withProgressBar:nil andCompletionBlock:nil];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        //HUD.progress = (float)percentDone/100;
    }];
    
}

-(void)refresh:(id)sender{
    refreshHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:refreshHUD];
    
    // Register for HUD callbacks so we can remove it from the window at the right time
    refreshHUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [refreshHUD show:YES];
}

-(void)setUpImages:(NSMutableArray *)images{
    self.allImages = [images mutableCopy];
    NSLog(@"is coming here");
    // Remove old grid
    for (UIView *view in [photoScrollView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSLog(@"images %@", images);
    
    UIButton *button;
    UIImage *thumbnail;
    
    //Create a button for each image
    for (int i=0; i<images.count; i++) {
        NSLog(@"en el for");
        thumbnail = [images objectAtIndex:i];
        NSLog(@"image i %@", thumbnail);
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:thumbnail forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.frame = CGRectMake(thumbnail.size.width, thumbnail.size.height , thumbnail.size.width, thumbnail.size.height);
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        NSLog(@"before");
        [photoScrollView addSubview:button];
        NSLog(@"after");
        
    }
    
    int rows = images.count / 4.0;
    if (((float)images.count / 4) - rows != 0) {
        rows++;
    }
    
    int height = thumbnail.size.height * rows + 1 * rows + 1 + 1;
    
    NSLog(@"before end");
    photoScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
    photoScrollView.clipsToBounds = YES;
    NSLog(@"after end");
}

- (void)buttonTouched:(id)sender{
    NSLog(@"button touched");
    //When picture is touched, open a viewcontroller with the image
    UIImage *selectedPhoto = [self.allImages objectAtIndex:[sender tag]];
    
    PhotoDetailViewController *pdvc = [[PhotoDetailViewController alloc] init];
    
    pdvc.selectedImage = selectedPhoto;
    [self presentViewController:pdvc animated:YES completion:nil];
}


-(void)loadParseImage:(PFObject *)parseObject forImageColumn:(NSString *)columnName withProgressBar:(UIProgressView *)progressBar andCompletionBlock:(void (^)(UIImage *imageFile, NSError *error))completionBlock
{
    NSString *parseFileName = [NSString stringWithFormat:@"%@", [[parseObject objectForKey:columnName] name]];
    // Get a path to the place in the local documents directory on the iOS device where the image file should be stored.
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"path %@", documentsDirectory);
    // You can change the path as you see fit by altering the stringByAppendingPathComponent call here.
    NSString *imagesDirectory = [documentsDirectory stringByAppendingPathComponent:@"Images"];
    NSString *storePath = [imagesDirectory stringByAppendingPathComponent:parseFileName];
    if (progressBar)
    {
        // Reset and show the progress bar
        [progressBar setProgress:0.0 animated:NO];
        progressBar.hidden = NO;
    }
    // Image data from Parse.com is retrieved in the background.
    [[parseObject objectForKey:columnName] getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
     {
         if (!error)
         {
             NSData *fileData = [[NSData alloc] initWithData:data];
             NSLog(@"pictures %@", fileData);
             if (![[NSFileManager defaultManager] fileExistsAtPath:imagesDirectory])
             {
                 // Create the folder if it doesn't already exist.
                 [[NSFileManager defaultManager] createDirectoryAtPath:imagesDirectory
                                           withIntermediateDirectories:NO
                                                            attributes:nil
                                                                 error:&error];
             }
             // Write the PFFile data to the local file.
             [fileData writeToFile:storePath atomically:YES];
             
             UIImage *showcaseImage;
             if ([[NSFileManager defaultManager] fileExistsAtPath:imagesDirectory])
             {
                 for (int i=0; i < 10; i++) {
                     showcaseImage = [UIImage imageWithContentsOfFile:storePath];
                     NSLog(@"local image %@", showcaseImage);
                     [self.allImages addObject:showcaseImage];
                 }
              [self setUpImages:self.allImages];
             }
             
             else // No file exists at the expected path. Perhaps the disk is full, etc.?
             {
                 NSLog(@"Unable to find image file where we expected it: %@", storePath);
             }
             completionBlock(showcaseImage, error);
             // This may be a good place to clean up the target directory.
             NSLog(@"showcase thing");
         }
         else // Unable to pull the image data from Parse.com. Consider more robust error handling.
         {
             NSLog(@"Error getting image data.");
             completionBlock(nil, error);
         }
     }
                                                        progressBlock:^(int percentDone)
     {
         if (progressBar)
         {
             [progressBar setProgress:percentDone animated:YES];
         }
     }];
}

@end
