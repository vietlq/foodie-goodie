//
//  FGDeviceViewController.m
//  MyStore
//
//  Created by Le Quoc Viet on 17/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "FGDeviceViewController.h"
#import "DeviceDetailViewController.h"

@interface FGDeviceViewController ()

@property (strong) NSMutableArray *devices;

@end

@implementation FGDeviceViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    // Flush immediately
    [context setStalenessInterval:0.0];
    // Obtain all devices
    self.devices = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DeviceTitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"], [device valueForKey:@"version"]]];
    [cell.detailTextLabel setText:[device valueForKey:@"company"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Delete the cell in the delete mode
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the object from the persistent store
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        
        NSError *error;
        if(! [context save:&error])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not delete" message:@"Could not delete the requested row.\nTry again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
        [tableView beginUpdates];
        
        // Delete the object from the table view
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        // Delete the object from the array of devices
        [self.devices removeObjectAtIndex:indexPath.row];
        
        [tableView endUpdates];
        
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"segueUpdateDevice" sender:[tableView cellForRowAtIndexPath:indexPath]];
    [self performSegueWithIdentifier:@"segueUpdateDevice" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"segueUpdateDevice"])
    {
        NSIndexPath *indexPath = nil;
        DeviceDetailViewController *destViewController = segue.destinationViewController;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        
        [destViewController prepareDeviceDetails:[self.devices objectAtIndex:indexPath.row]];
    }
}

@end
