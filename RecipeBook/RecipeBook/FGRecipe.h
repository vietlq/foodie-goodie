//
//  FGRecipe.h
//  RecipeBook
//
//  Created by Le Quoc Viet on 17/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGRecipe : NSObject

@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSString *prepTime;
@property (nonatomic, weak) NSString *imgPath;
@property (nonatomic, weak) NSArray *ingredients;

+ (FGRecipe *)recipeFromDictionary:(NSDictionary *)recipeDict;

@end
