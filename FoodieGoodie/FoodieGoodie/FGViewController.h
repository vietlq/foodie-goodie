//
//  FGViewController.h
//  FoodieGoodie
//
//  Created by Le Quoc Viet on 14/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray *tableData;
}

@property (nonatomic, retain) NSMutableArray *tableData;

@end
