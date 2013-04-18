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
{
    NSManagedObject *_device;
    NSString *_segueName;
}

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
    
    if(nil != _device)
    {
        self.txtFieldName.text = [_device valueForKey:@"name"];
        self.txtFieldVersion.text = [_device valueForKey:@"version"];
        self.txtFieldCompany.text = [_device valueForKey:@"company"];   
    }
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
    
    // Create a new managed object only on add
    if(! [_segueName isEqualToString:@"segueUpdateDevice"])
    {
        _device = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    }
    
    [_device setValue:name forKey:@"name"];
    [_device setValue:version forKey:@"version"];
    [_device setValue:company forKey:@"company"];
    
    NSError *error = nil;
    
    // Save the object to the persistent store
    if(! [context save:&error])
    {
        NSLog(@"Cannot save! Error: %@ %@", error, [error localizedDescription]);
    }
    
    _device = nil;
    _segueName = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareDeviceDetails:(NSManagedObject *)device
{
    _device = device;
    
    // Check for null
    if(_device == nil)
    {
        return;
    }
    
    _segueName = @"segueUpdateDevice";
}

@end
