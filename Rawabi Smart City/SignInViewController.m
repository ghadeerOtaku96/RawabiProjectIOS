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
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic)RawabiAPI* rawabiAPI;
@property (strong, nonatomic)NSDictionary* receivedData;
@property (strong, nonatomic)NSMutableURLRequest* request;
@property (strong, nonatomic)NSData* postBody;
@property (strong, nonatomic)NSString* json;
@property (strong, nonatomic)NSUserDefaults* user;
@end

@implementation SignInViewController

#pragma mark - Application LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

-(void)setup{
    
    [self.activityIndicator setHidden:YES];
    self.rawabiAPI = [[RawabiAPI alloc]init];
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
    
// login notification **Rainbow-SDK
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:kLoginManagerDidLoginSucceeded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailedToLogin:) name:kLoginManagerDidFailedToAuthenticate object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self deregisterFromKeyboardNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver:kLoginManagerDidLoginSucceeded];
    [[NSNotificationCenter defaultCenter] removeObserver:kLoginManagerDidFailedToAuthenticate];
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
    
        if(![self.emailTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]){
            [self.activityIndicator setHidden:NO];
            [self.activityIndicator startAnimating];
            
            [self loginByRainbowUsingEmai:self.emailTextField.text andPassword:self.passwordTextField.text];
            [self createPostBodyWithEmail:self.emailTextField.text AndPassword:self.passwordTextField.text];
            [self postHttpRequest];
            
    
    }
}
- (IBAction)showSignUpPage:(UIButton *)sender {

}

#pragma mark - Rainbow SDK Login implementation

-(void)loginByRainbowUsingEmai:(NSString*)email andPassword:(NSString*)password
{
    [[ServicesManager sharedInstance].loginManager setUsername:email andPassword:password];
    [[ServicesManager sharedInstance].loginManager connect];
}

-(void) didLogin:(NSNotification *) notification {
    NSLog(@"LOGIN AS A RAINBOW USER");
    [self signInSuccessfully];
    
}


// what to do when the login failed

-(void) didFailedToLogin:(NSNotificationCenter *)notification{
    NSLog(@"NOT A RAINBOW USER");
    [self failedToSignIn];
}


#pragma mark - Rawabi API Login HTTP Requests handling
-(void)createPostBodyWithEmail:(NSString*)email AndPassword:(NSString*)password{
    
    NSDictionary* dict = @{@"email":email, @"password":password};
    NSError* error = nil;
    if([NSJSONSerialization isValidJSONObject:dict]){
        self.postBody = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        if(self.postBody!= nil && error==nil){
            self.json = [[NSString alloc]initWithData:self.postBody encoding:NSUTF8StringEncoding];
            self.postBody = [NSData dataWithBytes:[self.json UTF8String] length:[self.json lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"GG JSON::%@",self.json);
           
            
        }
        
    }
    
}

-(void)postHttpRequest
{
    NSString* postString = @"http://172.22.1.111:8080/auth/signIn";
    postString = [postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.request = [[NSMutableURLRequest alloc]init];
    [self.request setURL:[NSURL URLWithString:postString]];
    
    [self.request setHTTPMethod:@"POST"];
    [self.request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.request setHTTPBody:_postBody];
    self.rawabiAPI.delegate = self;
    [self.rawabiAPI httpRequest:self.request];
    NSLog(@"LOGED");
}

#pragma mark - RawabiAPI Delegate Method
-(void)getReceivedData:(NSMutableData *)data sender:(RawabiAPI *)sender
{
    NSError* error = nil;
    NSDictionary* receivedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.receivedData = receivedData;
    if(![[self.receivedData valueForKey:@"message"] isKindOfClass:[NSDictionary class]]){
        NSLog(@"WRONG SIGNIN");
        //[self failedToSignIn];

    }
    else {
        NSLog(@"CORRECT SIGNIN");
        //[self signInSuccessfully];
    }
    return ;
}

#pragma mark - SignIn Error Handling
-(void)signInSuccessfully{
    
    self.user = [NSUserDefaults standardUserDefaults];
    if(self.user){
        [self.user setObject:self.emailTextField.text forKey:@"currentUser"];
        [self.user setObject:self.passwordTextField.text forKey:@"currentPassword"];
        [self.user synchronize];
    }
    
    // go to the next ViewController
    UIStoryboard* st = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController * nextVC =[st instantiateViewControllerWithIdentifier:@"controller"];
    [self presentViewController:nextVC animated:YES completion:nil];
}

-(void)failedToSignIn{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"message:@"There is an error in the data you've entered . please try again!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    alert.tintColor = [UIColor redColor];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger) buttonIndex{
    
    self.passwordTextField.text = @"";
    [self.passwordTextField resignFirstResponder];
    [self.passwordTextField hideError];
    self.passwordTextField.rightView = nil;
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
