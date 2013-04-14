//
//  FGFoodMenuCell.h
//  FoodieGoodie
//
//  Created by Le Quoc Viet on 14/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGFoodMenuCell : UITableViewCell

// http://stackoverflow.com/questions/7654573/ios-uitableview-crashes-when-scrolling
@property (nonatomic, retain) IBOutlet UILabel *labelName;
@property (nonatomic, retain) IBOutlet UILabel *labelPrepTime;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewThumbnail;

@end
