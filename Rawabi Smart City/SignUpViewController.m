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
}
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet PSProfileStepper *stepperView;
@property (strong, nonatomic) NSMutableArray* subviews;
@property (strong, nonatomic) customView* firstView;

@property (strong, nonatomic) customView2* secondView;
@property (strong, nonatomic) employeeView* thirdView;
@property (strong, nonatomic) customView4* forthView;
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

   
    frameView = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.firstView = [[customView alloc]initWithFrame:frameView];
    self.firstView.center = CGPointMake(190, 260);
    [self.firstView setBackgroundColor:[UIColor blueColor]];
    dispatch_async(dispatch_get_main_queue(), ^{
    self.firstView.profileImageView.image = [UIImage imageNamed:@"rawabi-logo"];
    self.firstView.profileImageView.layer.cornerRadius = self.firstView.profileImageView.frame.size.width/2;
    self.firstView.profileImageView.layer.masksToBounds = YES;});
    [self.scrollView addSubview:self.firstView];
    
    
    frameView = CGRectMake(self.view.frame.size.width, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.secondView = [[customView2 alloc]initWithFrame:frameView];
    self.secondView.center = CGPointMake(565, 180);
    [self.secondView setBackgroundColor:[UIColor blackColor]];
    [self.scrollView addSubview:self.secondView];
    
    frameView = CGRectMake(2*self.view.frame.size.width, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.thirdView = [[employeeView alloc]initWithFrame:frameView];
    self.thirdView.center = CGPointMake(940, 180);
    [self.thirdView setBackgroundColor:[UIColor redColor]];
    [self.scrollView addSubview:self.thirdView];
    
    frameView = CGRectMake(3*self.view.frame.size.width, self.scrollView.frame.origin.y, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.forthView = [[customView4 alloc]initWithFrame:frameView];
    self.forthView.center = CGPointMake(1315, 180);
    [self.forthView setBackgroundColor:[UIColor greenColor]];
    [self.scrollView addSubview:self.forthView];
    [self.nextButton setTitle:NSLocalizedStringFromTable(@"Next Btn", @"uiStrings", nil) forState:UIControlStateNormal];
   
   
    //self.subviews = [NSMutableArray arrayWithObjects:self.firstView,self.secondView,self.thirdView,self.forthView, nil];

    
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)next:(UIButton *)sender {
    
  
    
    index = index + 24;
    [self.stepperView setIndex:index animated:YES];
 
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +1+ self.scrollView.frame.size.width/5, 0) animated:YES];
   
    if(index>=96){
        sender.enabled = NO;
        // go to next step
    }
    
    
    //self.scrollView insertSubview: atIndex:;

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
