//
//  FGViewController.m
//  RecipeBook
//
//  Created by Le Quoc Viet on 16/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "FGViewController.h"

@interface FGViewController ()

@end

@implementation FGViewController
{
    NSMutableArray *recipes;
    NSString *foodMenuPath;
    NSArray *searchResults;
}

@synthesize localTableView;

- (void)loadView
{
    [super loadView];
    
    foodMenuPath = [[NSBundle mainBundle] pathForResource:@"food-menu" ofType:@"plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    recipes = [[NSMutableArray alloc] initWithContentsOfFile:foodMenuPath];
    NSLog(@"Number of recipes: %d", [recipes count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecipeCellIdentifier = @"RecipeCell";
    
    UITableViewCell *cell;
    
    // This is a critical piece
    cell = [tableView dequeueReusableCellWithIdentifier:RecipeCellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipeCellIdentifier];   
    }
    
    NSDictionary * dictItem = nil;
    
    if([self.searchDisplayController isActive])
    {
        dictItem = [NSDictionary dictionaryWithDictionary:[searchResults objectAtIndex:indexPath.row]];   
    }
    else
    {
        dictItem = [NSDictionary dictionaryWithDictionary:[recipes objectAtIndex:indexPath.row]];   
    }
    
    cell.textLabel.text = [dictItem valueForKey:@"name"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showRecipeDetail"])
    {
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = nil;
        
        if([self.searchDisplayController isActive])
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            destViewController.recipeItem = [searchResults objectAtIndex:indexPath.row];
        }
        else
        {
            indexPath = [self.localTableView indexPathForSelectedRow];
            destViewController.recipeItem = [recipes objectAtIndex:indexPath.row];   
        }
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    // http://stackoverflow.com/questions/958622/using-nspredicate-to-filter-an-nsarray-based-on-nsdictionary-keys
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"(name contains[cd] %@)",
                                    searchText];
    
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.searchDisplayController isActive])
    {
        [self performSegueWithIdentifier:@"showRecipeDetail" sender:self];
    }
}

@end
