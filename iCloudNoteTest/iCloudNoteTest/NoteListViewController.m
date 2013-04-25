//
//  NoteListViewController.m
//  iCloudNoteTest
//
//  Created by Le Quoc Viet on 23/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "NoteListViewController.h"

@interface NoteListViewController ()

@end

@implementation NoteListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // Force to load from iCloud
    _notes = [[[NSUbiquitousKeyValueStore defaultStore] arrayForKey:@"NoteTestAvailableNotes"] mutableCopy];
    
    // Load the view
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Observer to catch changes from iCloud
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
    
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    // Observer to catch the local changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddNewNote:) name:@"New Note" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)notes
{
    if(_notes)
    {
        return _notes;
    }
    
    _notes = [[[NSUbiquitousKeyValueStore defaultStore] arrayForKey:@"NoteTestAvailableNotes"] mutableCopy];
    if(! _notes) _notes = [NSMutableArray array];
    
    return _notes;
}

#pragma mark - Observe "New Note" event

- (void)didAddNewNote:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *noteStr = [userInfo valueForKey:@"Note"];
    [self.notes addObject:noteStr];
    
    // Update data on the iCloud
    [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notes forKey:@"NoteTestAvailableNotes"];
    
    // Reload the table view to show changes
    [self.tableView reloadData];
}

#pragma mark - Observer

- (void)storeDidChange:(NSNotification *)notification
{
    // Retrieve the changes from iCloud
    _notes = [[[NSUbiquitousKeyValueStore defaultStore] arrayForKey:@"NoteTestAvailableNotes"] mutableCopy];
    
    // Reload the table view to show changes
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *strNote = [self.notes objectAtIndex:indexPath.row];
    cell.textLabel.text = strNote;
    
    return cell;
}

// Override to support conditional editing of the table view
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.notes removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [[NSUbiquitousKeyValueStore defaultStore] setArray:self.notes forKey:@"NoteTestAvailableNotes"];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
