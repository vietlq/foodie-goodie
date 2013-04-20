//
//  RecipeCollectionViewController.m
//  RecipePhoto
//
//  Created by Le Quoc Viet on 20/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "RecipeCollectionViewController.h"

@interface RecipeCollectionViewController ()
{
    NSArray *recipePhotos;
}
@end

@implementation RecipeCollectionViewController

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
    recipePhotos = [NSArray arrayWithObjects:@"noodle_with_bbq_pork.jpg", @"instant_noodle_with_egg.jpg", @"green_tea.jpg", @"angry_birds_cake.jpg", @"thai_shrimp_cake.jpg", @"japanese_noodle_with_pork.jpg", @"vegetable_curry.jpg", @"starbucks_coffee.jpg", @"creme_brelee.jpg", @"full_breakfast.jpg", @"mushroom_risotto.jpg", @"ham_and_cheese_panini.jpg", @"egg_benedict.jpg", @"hamburger.jpg", @"ham_and_egg_sandwich.jpg", @"white_chocolate_donut.jpg", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [recipePhotos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoodCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
