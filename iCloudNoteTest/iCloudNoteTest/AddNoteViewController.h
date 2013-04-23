//
//  AddNoteViewController.h
//  iCloudNoteTest
//
//  Created by Le Quoc Viet on 23/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UITextField *txtFieldNote;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
