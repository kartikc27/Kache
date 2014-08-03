//
//  CardIOViewController.m
//  Kache
//
//  Created by Kartik Chillakanti on 8/3/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import "CardIOViewController.h"
#import "Parse/Parse.h"
#import "Stripe.h"


@interface CardIOViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CardIOViewController

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
    
    // After logging in with Facebook
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSString *facebookId = [result objectForKey:@"name"];
             [self.nameLabel setText:facebookId];
             [self performSelectorInBackground:@selector(fullName:) withObject:facebookId];

             
//             PFUser *currentUser = [PFUser currentUser];
//             currentUser[@"fullName"] = facebookId;
//             [currentUser saveInBackground];
            
         }
     }];
    
}


-(void)fullName:(NSString *)fullName
{
    self.fullName = fullName;
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"fullName"] = fullName;
    [currentUser saveInBackground];
}




- (IBAction)scanCard:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.appToken = @"871461a9140442b6b0ad326cbde03445"; // get your app token from the card.io website
    [self presentModalViewController:scanViewController animated:YES];
}

- (IBAction)noButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Details" message:@"Enter the name as shown on your card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *nameTextField = [alertView textFieldAtIndex:0];
    NSLog(@"%@",nameTextField.text);
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.appToken = @"871461a9140442b6b0ad326cbde03445"; // get your app token from the card.io website
    [self presentModalViewController:scanViewController animated:YES];
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

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissModalViewControllerAnimated:YES];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv);
    // Use the card info...
    
    STPCard *card = [[STPCard alloc] init];
    card.number = @"4242424242424242";
    card.expMonth = 12;
    card.expYear = 2020;
    card.cvc = @"123";
    
    [Stripe createTokenWithCard:card
                 publishableKey:@"pk_test_4W9Ubr8tyu4DLlndcnzzPUa6"
                     completion:^(STPToken *token, NSError *error) {
                         if (error) {
                             NSLog (@"you erred 1");

                             [self handleError:error];
                         } else {
                             NSLog (@"sup");

                             [self handleToken:token]; // Hooray!
                         }
                     }];
    
}

- (void)handleError:(NSError *)error
{
    NSLog (@"you erred 2");

    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)handleToken:(STPToken *)token
{
    
    NSLog(@"Received token %@", token.tokenId);
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:token.tokenId forKey:@"stripeToken"];

    [PFCloud callFunctionInBackground:@"chargeWithStripe" withParameters:dictionary block:^(NSString *result, NSError *error) {
        if (!error) {
            NSString *customerID = result;
            NSLog(@"%@", customerID);
            [self performSelectorInBackground:@selector(customerIDSave:) withObject:customerID];
        }
    }];
    
    
    NSMutableDictionary* recipientDictionary = [[NSMutableDictionary alloc] init];
    [recipientDictionary setObject:self.fullName forKey:@"fullName"];
    [recipientDictionary setObject:token.tokenId forKey:@"stripeToken"];
    [PFCloud callFunctionInBackground:@"recipientsStripe" withParameters:recipientDictionary block:^(NSString *result, NSError *error) {
        if (!error) {
            NSString *recipientID = result;
            NSLog(@"%@", recipientID);
            [self performSelectorInBackground:@selector(recipientIDSave:) withObject:recipientID];
        }
    }];
    
    
    
    /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://example.com"]];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@", token.tokenId];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                               }*/
     
    
}

-(void)recipientIDSave:(NSString *)recipientID
{
    PFUser *user = [PFUser currentUser];
    user[@"recipientID"] = recipientID;
    [user saveInBackground];
}

-(void)customerIDSave:(NSString *)customerID
{
    PFUser *user = [PFUser currentUser];
    user[@"customerID"] = customerID;
    [user saveInBackground];
}

@end
