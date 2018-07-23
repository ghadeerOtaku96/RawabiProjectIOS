//
//  welcomePageViewController.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/12/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "welcomePageViewController.h"
#import "contentViewController.h"

@interface welcomePageViewController ()
{
    NSArray* imagesArray ;
}
@end

@implementation welcomePageViewController

#pragma mark - View Controller lifecycle methodes
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imagesArray = [[NSArray alloc]initWithObjects:@"im1",@"im2",@"im3", nil];
    self.dataSource = self;
    self.delegate = self;
    contentViewController* contentVC = (contentViewController *)[self viewcontrollerAtIndex:0];
    NSArray* arrayVC = [NSArray arrayWithObject:contentVC];

    
    [self setViewControllers:arrayVC direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(contentViewController *)viewcontrollerAtIndex:(NSUInteger)index
{
    if( index <= imagesArray.count){
        contentViewController* contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
        contentVC.backgroundImageViewName = imagesArray[index];
        contentVC.valueIndex = index;
        return contentVC;

    }
    return nil;
}

#pragma mark - UIPageViewControllerDataSource implementation
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = ((contentViewController *)viewController).valueIndex;
    if(index == 0 || index == NSNotFound){
        return nil;
    }
    index--;
    return [self viewcontrollerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSUInteger index = ((contentViewController *)viewController).valueIndex;
    if(index == NSNotFound){
        return nil;
    }
    index++;
    if(index == imagesArray.count)
    {
        return  nil;
    }
    return [self viewcontrollerAtIndex:index];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [imagesArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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
