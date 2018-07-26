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

@property (nonatomic, strong) UIScrollView* scrollView1;
@property (strong, nonatomic) personalDetails* firstView;
@property (strong, nonatomic) employeeDetails* secondView;
@property (strong, nonatomic) residencyDetails* thirdView;


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
    
    if(index >= 99 || status){
        sender.enabled = NO;
        
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
