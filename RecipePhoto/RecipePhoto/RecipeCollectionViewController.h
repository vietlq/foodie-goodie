//
//  RecipeCollectionViewController.h
//  RecipePhoto
//
//  Created by Le Quoc Viet on 20/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionViewController : UICollectionViewController

@property (nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
// Must retain to reuse the Cancel Button
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;

- (IBAction)shareButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;

@end
