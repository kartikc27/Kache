//
//  LoginViewController.m
//  Kache
//
//  Created by Kartik Chillakanti on 8/2/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import "LoginViewController.h"
//#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    
    
    
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        // Push the next view controller without animation
        [self.navigationController pushViewController:
         [[UINavigationController alloc] init]
                                             animated:NO];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)loginButtonTouchHandler:(id)sender  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ ];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            //[self.navigationController pushViewController:[[HomeViewController alloc] init] animated:YES];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *viewController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"home"];
            viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:viewController animated:YES completion:nil];

        } else {
            NSLog(@"User with facebook logged in!");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *viewController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"home"];
            viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:viewController animated:YES completion:nil];
            
        }
    }];
}


@end