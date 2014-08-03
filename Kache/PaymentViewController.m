//
//  PaymentViewController.m
//  Kache
//
//  Created by Neel Bhoopalam on 8/2/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import "PaymentViewController.h"
#import "APDarkPadStyle.h"
#import "APBluePadStyle.h"

@interface PaymentViewController () <APNumberPadDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end

@implementation PaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}



/*- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.textField.frame = CGRectMake(10.f, 50.f, CGRectGetWidth(self.view.bounds) - 10.f * 2, 30.f);
    self.styledTextField.frame = CGRectOffset(self.textField.frame, 0, 52.0f);
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.inputView = ({
            APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
            
            [numberPad.leftFunctionButton setTitle:@"B" forState:UIControlStateNormal];
            numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            numberPad;
        });
    }
    return _textField;
}*/

/*- (UITextField *)styledTextField{
    
    if (!_styledTextField) {
        _styledTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _styledTextField.borderStyle = UITextBorderStyleRoundedRect;
        _styledTextField.inputView = ({
            APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self numberPadStyleClass:[APDarkPadStyle class]];
            
            [numberPad.leftFunctionButton setTitle:@"Change Style" forState:UIControlStateNormal];
            numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            numberPad;
        });
    }
    
    return _styledTextField;
}*/


#pragma mark - APNumberPadDelegate

/*
- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:self.textField]) {
        [functionButton setTitle:[functionButton.currentTitle stringByAppendingString:@"z"] forState:UIControlStateNormal];
        [textInput insertText:@"#"];
    } else {
        Class currentSyle = [numberPad styleClass];
        
        Class nextStyle = currentSyle == [APDarkPadStyle class] ? [APBluePadStyle class] : [APDarkPadStyle class];
        self.styledTextField.inputView = ({
            APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self numberPadStyleClass:nextStyle];
            
            [numberPad.leftFunctionButton setTitle:@"Change Style" forState:UIControlStateNormal];
            numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            numberPad;
        });
        
        // Trick for update the inputview
        //
        [self.styledTextField resignFirstResponder];
        [self.styledTextField becomeFirstResponder];
    }
}*/

- (IBAction)backgroundButtonPressed:(id)sender {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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



@end