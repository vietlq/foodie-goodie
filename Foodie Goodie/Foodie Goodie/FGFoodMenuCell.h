//
//  FGFoodMenuCell.h
//  Foodie Goodie
//
//  Created by Le Quoc Viet on 14/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGFoodMenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelPrepTime;
@property (nonatomic, weak) IBOutlet UIImageView *imgViewThumbnail;

@end
