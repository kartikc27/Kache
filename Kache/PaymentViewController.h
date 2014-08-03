//
//  PaymentViewController.h
//  Kache
//
//  Created by Neel Bhoopalam on 8/2/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APNumberPad.h"
#import <Parse/Parse.h>


@interface PaymentViewController : UIViewController <APNumberPadDelegate>

@property NSString* typeTransaction;

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) IBOutlet UITextField *moneyAmount;
@property (weak, nonatomic) IBOutlet UIButton *confirmTransaction;

@end
