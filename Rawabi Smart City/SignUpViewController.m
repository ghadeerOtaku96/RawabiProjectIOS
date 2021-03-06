//
//  SignUpViewController.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/15/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController () 
{
    int index;
    CGRect frameView;
    CGSize keySize;
    BOOL status;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet PSProfileStepper *stepperView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIScrollView* scrollView1;
@property (strong, nonatomic) personalDetails* firstView;
@property (strong, nonatomic) employeeDetails* secondView;
@property (strong, nonatomic) residencyDetails* thirdView;

@property (strong, nonatomic)RawabiAPI* rawabiAPI;
@property (strong, nonatomic)NSDictionary* receivedData;
@property (strong, nonatomic)NSMutableURLRequest* request;

@property (strong, nonatomic)NSData* postBody;
@property (strong, nonatomic)NSString* json;


@end

@implementation SignUpViewController

#pragma mark - Application LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
   
    // Do any additional setup after loading the view.
}

-(void)setup{
    index = 0;

    [self.activityIndicator setHidden:YES];
    self.rawabiAPI = [[RawabiAPI alloc]init];
    [self.stepperView setIndex:2 animated:YES];
    
    [self.scrollView showsHorizontalScrollIndicator];

    [self.scrollView setScrollEnabled:NO];
//    self.scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(self.scrollView.frame.origin.x,self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height )];
    
    
    
   dispatch_async(dispatch_get_main_queue(), ^{
    frameView = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.firstView = [[personalDetails alloc]initWithFrame:frameView];
    self.firstView.center = CGPointMake(190, 260);
    [self.scrollView addSubview:self.firstView];
    
    self.firstView.firstNameTextField.delegate =self;
    self.firstView.lastNameTextField.delegate = self;
    self.firstView.emailTextField.delegate = self;
    self.firstView.phoneTextField.delegate = self;
    
    [self.firstView.firstNameTextField resignFirstResponder];
    [self.firstView.lastNameTextField resignFirstResponder];
    [self.firstView.emailTextField resignFirstResponder];
    [self.firstView.phoneTextField resignFirstResponder];
    

    frameView = CGRectMake(self.view.frame.size.width, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.secondView = [[employeeDetails alloc]initWithFrame:frameView];
    self.secondView.center = CGPointMake(565, 180);
    [self.scrollView addSubview:self.secondView];
    
    frameView = CGRectMake(2*self.view.frame.size.width, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.thirdView = [[residencyDetails alloc]initWithFrame:frameView];
    self.thirdView.center = CGPointMake(940, 180);
    [self.scrollView addSubview:self.thirdView];
    

    
    [self.nextButton setTitle:NSLocalizedStringFromTable(@"Next Btn", @"uiStrings", nil) forState:UIControlStateNormal];
        self.nextButton.layer.cornerRadius = 10;
        self.nextButton.clipsToBounds = YES;
           self.nextButton.enabled = NO;
    });
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if([self NSStringIsValidEmail:self.firstView.emailTextField.text] == NO){
        [self.firstView.emailTextField setLineColor:[UIColor redColor]]; 
   
    }
    if([self NSStringIsValidPhone:self.firstView.phoneTextField.text] == NO){
        [self.firstView.phoneTextField setLineColor:[UIColor redColor]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];

}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGFloat buttonHeight = self.firstView.phoneTextField.frame.size.height;
    CGRect visibleRect = self.firstView.frame;
    visibleRect.size.height = buttonHeight;
    CGPoint scrollPoint = CGPointMake(0.0,  2*visibleRect.size.height );
    [self.scrollView setContentOffset:scrollPoint animated:YES];
        self.nextButton.enabled = YES;

}
-(void)textFieldDidEndEditing:(ACFloatingTextField *)textField{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    textField.rightViewMode = UITextFieldViewModeNever;
    
    if([textField.text  isEqualToString:@""]){
        UIImageView* errorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-25, 2, 25, 25)];
        textField.errorLineColor = [UIColor redColor];
        textField.errorText = @"Empty Field";
        [textField showError];
        
        errorIcon.image = [UIImage imageNamed:@"error"];
        [textField setRightView:errorIcon];
        textField.rightViewMode = UITextFieldViewModeAlways;
        [textField shakeView:textField];
        
        self.nextButton.enabled = NO;
        
    }
    
    if(textField == self.firstView.emailTextField){
        if(![self NSStringIsValidEmail:textField.text]){
            UIImageView* errorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-25, 2, 25, 25)];
            textField.errorLineColor = [UIColor redColor];
            [textField showError];
            
            errorIcon.image = [UIImage imageNamed:@"error"];
            [textField setRightView:errorIcon];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField shakeView:textField];
            
            self.firstView.emailTextField.errorText = @"Not a valid Email";
            self.firstView.emailTextField.errorTextColor = [UIColor redColor];
            [self.firstView.emailTextField showError];
            self.nextButton.enabled = NO;
        }
    }
    if(textField == self.firstView.phoneTextField){
        if(![self NSStringIsValidPhone:textField.text]){
            UIImageView* errorIcon = [[UIImageView alloc]initWithFrame:CGRectMake(textField.frame.size.width-25, 2, 25, 25)];
            textField.errorLineColor = [UIColor redColor];
            [textField showError];
            
            errorIcon.image = [UIImage imageNamed:@"error"];
            [textField setRightView:errorIcon];
            textField.rightViewMode = UITextFieldViewModeAlways;
            [textField shakeView:textField];
            
            self.firstView.phoneTextField.errorText = @"Not a valid phone number";
            self.firstView.phoneTextField.errorTextColor = [UIColor redColor];
            [self.firstView.phoneTextField showError];
            self.nextButton.enabled = NO;
        }
    }
    
}
// any touch outside the text fields will be ignored and disable the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.firstView.firstNameTextField resignFirstResponder];
    [self.firstView.lastNameTextField resignFirstResponder];
    [self.firstView.emailTextField resignFirstResponder];
    [self.firstView.phoneTextField resignFirstResponder];

}

#pragma - mark NEXT_DONE button
//process NEXT and DONE button on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.firstView.firstNameTextField)
        [self.firstView.lastNameTextField becomeFirstResponder];
    else if(textField == self.firstView.lastNameTextField)
        [self.firstView.emailTextField becomeFirstResponder];
    else if (textField == self.firstView.emailTextField)
        [self.firstView.phoneTextField becomeFirstResponder];
    else
    {
        [self.firstView.firstNameTextField endEditing:YES];
        [self.firstView.lastNameTextField endEditing:YES];
        [self.firstView.emailTextField endEditing:YES];
        [self.firstView.phoneTextField endEditing:YES];
    }
    
    return YES;
}
#pragma mark - Dismiss Keyboard
- (IBAction)dismissKeyboard:(id)sender {
    
    [self.firstView.firstNameTextField endEditing:YES];
    [self.firstView.lastNameTextField endEditing:YES];
    [self.firstView.emailTextField endEditing:YES];
    [self.firstView.phoneTextField endEditing:YES];
}



#pragma mark - Event Handling
- (IBAction)next:(UIButton *)sender {
    
    status = ([self.firstView.firstNameTextField.text isEqualToString:@""] ||
    [self.firstView.lastNameTextField.text isEqualToString:@""] ||
    [self.firstView.emailTextField.text isEqualToString:@""] ||
    [self.firstView.phoneTextField.text isEqualToString:@""]) ;
    
    if(index >= 50){
        [sender setTitle:@"SUBMIT" forState:UIControlStateNormal];
    }

    
    if(index >= 99 || status){
        
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        [self createPostBody];
        [self postHttpRequest];
        
        // go to next step
    }
    else{
    [self.backButton setEnabled:YES];
    index = index + 50;
    [self.stepperView setIndex:index animated:YES];
 
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +1+ self.scrollView.frame.size.width/3, 0) animated:YES];
    NSLog(@"index %d",index);
    }
 

}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.nextButton setEnabled:YES];
    if(index >= 50){
        index = index - 50;
        [self.stepperView setIndex:index animated:YES];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x -1- self.scrollView.frame.size.width/3, 0) animated:YES];
        NSLog(@"index %d",index);
        
    }
    else{
        sender.enabled = NO;
        index = 0;
        
    }
    
    if(index == 50 || index == 0 || index == 2)
        [self.nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
}



#pragma mark - Data Validation
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
 {
 BOOL stricterFilter = NO;
 NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
 NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
 NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
 NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
 return [emailTest evaluateWithObject:checkString];
 }

-(BOOL) NSStringIsValidPhone:(NSString *)checkString
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:checkString] == YES)
        return YES;
    else
        return NO;
}

#pragma mark - HTTP Request Handling
-(void)createPostBody{
    
    NSDictionary* dict = @{@"firstName":self.firstView.firstNameTextField.text,
                           @"lastName":self.firstView.lastNameTextField.text,
                           @"email":self.firstView.emailTextField.text,
                           @"employee":self.secondView.status,
                           @"department":self.secondView.department,
                           @"department_id":self.secondView.departmentID,
                           @"company":self.secondView.company,
                           @"company_id":self.secondView.companyID,
                           @"domain":self.secondView.domain,
                           @"resident":self.thirdView.status,
                           @"residency_type":self.thirdView.residencyType,
                           @"building_number":self.thirdView.buildingNumber,
                           @"building_id":self.thirdView.buildingNumberID,
                           @"floor_number":self.thirdView.floor,
                           @"floor_id":self.thirdView.floorID,
                           @"apartment_number":self.thirdView.apartmentNumber,
                           @"apartment_id":self.thirdView.apartmentNumberID,
                           @"neighbourhood_name":self.thirdView.neighborhood,
                           @"neighbourhood_id":self.thirdView.neighborhoodID,
                           @"mobile":self.firstView.phoneTextField.text,
                           @"hasRole":self.secondView.status,
                           };
    NSError* error = nil;
    
    //if([NSJSONSerialization isValidJSONObject:dict]){
        self.postBody = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        if(self.postBody!= nil && error==nil){
            self.json = [[NSString alloc]initWithData:self.postBody encoding:NSUTF8StringEncoding];
            self.postBody = [NSData dataWithBytes:[self.json UTF8String] length:[self.json lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"GG JSON::%@",self.json);
            
            
        }
    //}
    
}


-(void)postHttpRequest
{
    NSString* postString = @"http://172.22.1.111:8080/auth/signUp";
    postString = [postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.request = [[NSMutableURLRequest alloc]init];
    [self.request setURL:[NSURL URLWithString:postString]];
    
    [self.request setHTTPMethod:@"POST"];
    [self.request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.request setHTTPBody:self.postBody];
    self.rawabiAPI.delegate = self;
    [self.rawabiAPI httpRequest:self.request];
}

#pragma mark - RawabiAPI Delegate Method
-(void)getReceivedData:(NSMutableData *)data sender:(RawabiAPI *)sender
{
    NSError* error = nil;
    NSDictionary* receivedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.receivedData = receivedData;
    if(receivedData){
        if([receivedData count]>2){
            NSLog(@"SUCCESSFUL");
            [self signUpSuccessfully];
            
        }
        else{
            NSLog(@"FAILEDSSS");
            [self failedToSignUp];
        }
        NSLog(@"DONE");
    }
}

#pragma mark - SignUp Error Handling
-(void)signUpSuccessfully{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Verification"message:@"Check out your email for Verification" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    alert.tintColor = [UIColor colorWithRed:161.0/255.0 green:210.0/255.0 blue:103.0/255.0 alpha:1.0];
    
    [alert show];

}

-(void)failedToSignUp{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign up Error"message:@"Failed to create the account. This email is already exist, please try with different email!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    alert.tintColor = [UIColor redColor];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger) buttonIndex{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    if([alertView.title isEqualToString:@"Email Verification"]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // go to the next ViewController
            SignInViewController* nextVC =[self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
            [self presentViewController:nextVC animated:YES completion:nil];
        });
        
    }

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
