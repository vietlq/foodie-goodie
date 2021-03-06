//
//  RecipeDetailViewController.h
//  RecipeBook
//
//  Created by Le Quoc Viet on 17/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGRecipe.h"

@interface RecipeDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *prepTime;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FGRecipe *recipe;

@end
