//
//  RecipeDetailViewController.m
//  RecipePhoto
//
//  Created by Le Quoc Viet on 21/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
{
    NSString *_recipeImageName;
}

@synthesize recipeImageView;

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
    recipeImageView.image = [UIImage imageNamed:_recipeImageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setRecipeImageName:(NSString *)recipeImageName
{
    _recipeImageName = recipeImageName;
}

@end
