//
//  FGViewController.h
//  RecipeBook
//
//  Created by Le Quoc Viet on 16/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeDetailViewController.h"

@interface FGViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *localTableView;

@end
