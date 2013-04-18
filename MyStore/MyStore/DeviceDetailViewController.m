//
//  DeviceDetailViewController.m
//  MyStore
//
//  Created by Le Quoc Viet on 18/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

@synthesize txtFieldName;
@synthesize txtFieldVersion;
@synthesize txtFieldCompany;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)trim:(NSString *)inputString
{
    return [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (IBAction)save:(id)sender
{
    NSString *name = [self trim:self.txtFieldName.text];
    NSString *version = [self trim:self.txtFieldVersion.text];
    NSString *company = [self trim:self.txtFieldCompany.text];
    
    if(([name length] < 1) || ([company length] < 1))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid input" message:@"The Device Name and\nCompany must not be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:name forKey:@"name"];
    [newDevice setValue:version forKey:@"version"];
    [newDevice setValue:company forKey:@"company"];
    
    NSError *error = nil;
    
    // Save the object to the persistent store
    if(! [context save:&error])
    {
        NSLog(@"Cannot save! Error: %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
