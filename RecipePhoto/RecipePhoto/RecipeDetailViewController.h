//
//  RecipeDetailViewController.h
//  RecipePhoto
//
//  Created by Le Quoc Viet on 21/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *recipeImageView;

- (void)setRecipeImageName:(NSString *)recipeImageName;

- (IBAction)close:(id)sender;

@end
