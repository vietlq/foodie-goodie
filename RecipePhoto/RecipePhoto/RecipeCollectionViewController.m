//
//  RecipeCollectionViewController.m
//  RecipePhoto
//
//  Created by Le Quoc Viet on 20/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "RecipeCollectionViewController.h"
#import "SectionHeaderView.h"
#import "RecipeDetailViewController.h"
#import <Social/Social.h>

@interface RecipeCollectionViewController ()
{
    NSArray *recipePhotos;
    BOOL shareEnabled;
    NSMutableArray *selectedRecipes;
    NSMutableArray *selectedIndexPaths;
}
@end

@implementation RecipeCollectionViewController

@synthesize shareButton;
@synthesize cancelButton;

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
    NSArray *mainDishes = [NSArray arrayWithObjects:@"egg_benedict.jpg", @"full_breakfast.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", nil];
    NSArray *drinkDesserts = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"green_tea.jpg", @"starbucks_coffee.jpg", @"white_chocolate_donut.jpg", nil];
    recipePhotos = [NSArray arrayWithObjects:mainDishes, drinkDesserts, nil];
    
    // Setting the section margin
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    // Top, right, bottom, left => Just like the order of CSS margins
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    // Initialize the values
    shareEnabled = NO;
    selectedRecipes = [NSMutableArray array];
    selectedIndexPaths = [NSMutableArray array];
    // By default the Cancel Button must not be present
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [recipePhotos count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[recipePhotos objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoodCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected-photo-frame.png"]];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[[recipePhotos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if(kind == UICollectionElementKindSectionHeader)
    {
        SectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc] initWithFormat:@"Recipe Group #%d", (indexPath.section + 1)];
        headerView.title.text = title;
        UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
        headerView.backgroundImage.image = headerImage;
        
        reusableView = headerView;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        SectionHeaderView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableView = footerView;
    }
    
    return reusableView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueRecipeDetail"])
    {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        RecipeDetailViewController *destView = segue.destinationViewController;
        [destView setRecipeImageName:[[recipePhotos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        // Remember to deselect the cell
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"segueRecipeDetail"])
    {
        return (! shareEnabled);
    }
    
    return YES;
}

- (void)restoreCollectionView
{
    shareEnabled = NO;
    shareButton.title = @"Share";
    shareButton.enabled = YES;
    self.navigationItem.leftBarButtonItem = nil;
    // http://www.raywenderlich.com/22417/beginning-uicollectionview-in-ios-6-part-22
    [self.collectionView setAllowsMultipleSelection:NO];
    [selectedRecipes removeAllObjects];
    // Clear the collection view from selected cells as well
    for(NSIndexPath *indexPath in selectedIndexPaths)
    {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];   
    }
    [selectedIndexPaths removeAllObjects];
}

- (IBAction)shareButtonTouched:(id)sender
{
    if(shareEnabled)
    {
        /*
         Invoke sharing to FB
         */
        if([selectedRecipes count] > 0)
        {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *socialController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [socialController setInitialText:@"Yummy foodies =P~"];
                for(NSString *recipePhoto in selectedRecipes)
                {
                    [socialController addImage:[UIImage imageNamed:recipePhoto]];
                }
                
                [self presentViewController:socialController animated:YES completion:^{
                    // Clean up
                    [self restoreCollectionView];
                }];
            }
        }
    }
    else
    {
        shareEnabled = YES;
        shareButton.title = @"Upload";
        shareButton.enabled = NO;
        self.navigationItem.leftBarButtonItem = cancelButton;
        // http://www.raywenderlich.com/22417/beginning-uicollectionview-in-ios-6-part-22
        [self.collectionView setAllowsMultipleSelection:YES];
    }
}

- (IBAction)cancelButtonTouched:(id)sender
{
    [self restoreCollectionView];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(shareEnabled)
    {
        shareButton.enabled = YES;
        [selectedRecipes addObject:[[recipePhotos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        [selectedIndexPaths addObject:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(shareEnabled)
    {
        [selectedRecipes removeObject:[[recipePhotos objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        [selectedIndexPaths removeObject:indexPath];
        if([selectedRecipes count] < 1)
        {
            shareButton.enabled = NO;
        }   
    }
}

@end
