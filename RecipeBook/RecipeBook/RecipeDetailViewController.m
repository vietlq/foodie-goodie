//
//  RecipeDetailViewController.m
//  RecipeBook
//
//  Created by Le Quoc Viet on 17/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
{
    
}

@synthesize recipeItem;
@synthesize prepTime;
@synthesize imageView;

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
    self.title = [recipeItem valueForKey:@"name"];
    //
    prepTime.text = [recipeItem valueForKey:@"prepTime"];
    //
    NSString *imgPath = [[recipeItem objectForKey:@"imgPath"] lastPathComponent];
    UIImage *image = [UIImage imageNamed:imgPath];
    imageView.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
