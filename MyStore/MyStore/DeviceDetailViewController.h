//
//  DeviceDetailViewController.h
//  MyStore
//
//  Created by Le Quoc Viet on 18/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *txtFieldName;
@property (nonatomic, weak) IBOutlet UITextField *txtFieldVersion;
@property (nonatomic, weak) IBOutlet UITextField *txtFieldCompany;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
