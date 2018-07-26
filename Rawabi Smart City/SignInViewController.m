//
//  SignInViewController.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/15/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
{
    UIImageView* emailIcon;
    UIImageView* passwordIcon;
}
@end

@implementation SignInViewController

#pragma mark - Application LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

-(void)setup{
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.scrollView setScrollEnabled:NO];
    
    self.QimageView.image  = [UIImage imageNamed:NSLocalizedStringFromTable(@"Logo Name", @"uiStrings", nil)];

    
    [self.emailTextField setBackgroundColor:[UIColor clearColor]];
    [self.emailTextField setBorderStyle:UITextBorderStyleNone];
    emailIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    emailIcon.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"EmailIcon Name", @"uiStrings", nil)];
    self.emailTextField.leftView = emailIcon;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
   
    
    [self.passwordTextField setBackgroundColor:[UIColor clearColor]];
    [self.passwordTextField setBorderStyle:UITextBorderStyleNone];
    passwordIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    passwordIcon.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"PasswordIcon Name", @"uiStrings", nil)];
    self.passwordTextField.leftView = passwordIcon;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
   
    
    [self.forgetPassButton setTitle:NSLocalizedStringFromTable(@"Forget Btn", @"uiStrings", nil) forState:UIControlStateNormal];
    
    [self.loginButton setTitle:NSLocalizedStringFromTable(@"Login Btn", @"uiStrings", nil) forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.clipsToBounds = YES;
    
    [self.signUpButton setTitle:NSLocalizedStringFromTable(@"Signup Btn", @"uiStrings", nil) forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    //add login notification **Rainbow-SDK
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self deregisterFromKeyboardNotifications];
}

#pragma mark - Keyboard Notifications
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

#pragma mark - Keyboard Appearance
//scroll up the view when the keyboard is being used
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGPoint buttonOrigin = self.loginButton.frame.origin;
    CGFloat buttonHeight = self.loginButton.frame.size.height + 100;
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keyboardSize.height;
   
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}
//reset the view when the keyboard is being hidden
- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

//To handle touches outside UITextField
- (IBAction)dismissKeyboard:(id)sender {
    
    [self.emailTextField endEditing:YES];
    [self.passwordTextField endEditing:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.emailTextField)
        [self.passwordTextField becomeFirstResponder];
    if(textField == self.passwordTextField)
        [self.passwordTextField resignFirstResponder];
    
    return YES;
}


-(void)textFieldDidEndEditing:(ACFloatingTextField *)textField{
    
    textField.rightViewMode = UITextFieldViewModeNever;
    
    if([textField.text  isEqualToString:@""]){
        UIImageView* errorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-25, 2, 25, 25)];
        textField.errorLineColor = [UIColor redColor];
        [textField showError];
        
        errorIcon.image = [UIImage imageNamed:@"error"];
        [textField setRightView:errorIcon];
        textField.rightViewMode = UITextFieldViewModeAlways;
        [textField shakeView:textField];
        
        textField.errorText = @"Empty Field";
        textField.errorTextColor = [UIColor redColor];
        [textField showError];
        
    }
    
//    if(textField == self.emailTextField){
//        if(![self NSStringIsValidEmail:textField.text]){
//            UIImageView* errorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-25, 2, 25, 25)];
//            textField.errorLineColor = [UIColor redColor];
//            [textField showError];
//            
//            errorIcon.image = [UIImage imageNamed:@"error"];
//            [textField setRightView:errorIcon];
//            textField.rightViewMode = UITextFieldViewModeAlways;
//            [textField shakeView:textField];
//            
//            textField.errorText = @"Not a valid Email";
//            textField.errorTextColor = [UIColor redColor];
//            [textField showError];
//        
//        }
//}
       
    
}

//#pragma mark - Data Validation
//-(BOOL) NSStringIsValidEmail:(NSString *)checkString
//{
//    BOOL stricterFilter = NO;
//    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
//    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
//    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:checkString];
//}

#pragma mark - Event Handling
- (IBAction)forgetPassword:(UIButton *)sender {

}

- (IBAction)login:(UIButton *)sender {
}
- (IBAction)showSignUpPage:(UIButton *)sender {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
