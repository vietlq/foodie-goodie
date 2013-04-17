//
//  FGRecipe.m
//  RecipeBook
//
//  Created by Le Quoc Viet on 17/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "FGRecipe.h"

@implementation FGRecipe

@synthesize name;
@synthesize prepTime;
@synthesize imgPath;
@synthesize ingredients;

+ (FGRecipe *)recipeFromDictionary:(NSDictionary *)recipeDict
{
    FGRecipe *recipe = [[FGRecipe alloc] init];
    
    recipe.name = [recipeDict valueForKey:@"name"];
    recipe.prepTime = [recipeDict valueForKey:@"prepTime"];
    recipe.imgPath = [recipeDict valueForKey:@"imgPath"];
    //recipe.ingredients = [recipeDict valueForKey:@"name"];
    
    return recipe;
}

@end
