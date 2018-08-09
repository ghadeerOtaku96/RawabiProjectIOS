//
//  CollectionViewController.m
//  Rawabi Smart City
//
//  Created by Ghadeer Abualrub on 8/8/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSArray *backgroundImagesArray;
@property (strong, nonatomic) NSArray *imagesArray;
@property (strong, nonatomic) NSArray *stringsArray;
@property (strong, nonatomic) NSArray *controllersID;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"cell";

#pragma mark - Application LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setUp];
    // Do any additional setup after loading the view.
    
}

-(void)setUp
{
    self.backgroundImagesArray = @[@"event.jpg",@"reservation.jpg",@"directory.jbg",@"entertainment.jpg",@"dining.jpg",@"shopping.jpg",@"maps.jpg",@"halls.jpg"];
    self.imagesArray = @[@"ic_events.png",@"ic_reservations.png",@"ic_directory.png",@"ic_entertainment.png",@"ic_restaurants.png",@"ic_shopping_cart.png",@"ic_maps.png",@"ic_halls.png"];
    self.stringsArray = @[@"EVENTS",@"RESERVATIONS",@"DIRECTORY",@"ENTERTAINMENT",@"DINING",@"SHOPPING",@"MAPS",@"HALLS"];
    self.controllersID = @[@"vc1",@"vc2",@"vc3",@"vc4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.backgroundImagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIButton* imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [imageButton setBackgroundImage:[UIImage imageNamed:[self.backgroundImagesArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];

    [imageButton setTitle:[self.stringsArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    imageButton.imageEdgeInsets = UIEdgeInsetsMake(20.0, 50.0, 20.0, 50.0);
   
    [imageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageButton setTitleEdgeInsets:UIEdgeInsetsMake(120.0, -50.0, 20.0, 1.0)];// top left bottom right
    
    [imageButton setImage:[UIImage imageNamed:[self.imagesArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    
    
    [cell setBackgroundView:imageButton];
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HELLO");
    if(indexPath.row <= 3){
    UIViewController* nextVC = [self.storyboard instantiateViewControllerWithIdentifier:[self.controllersID objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:nextVC animated:YES];}
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
