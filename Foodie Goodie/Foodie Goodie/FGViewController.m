//
//  FGViewController.m
//  SimpleTable
//
//  Created by Le Quoc Viet on 10/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "FGViewController.h"
#import "FGFoodMenuCell.h"

@interface FGViewController ()

@end

@implementation FGViewController
{
    NSArray *tableData;
    NSString *foodMenuPath;
    NSString *rootLocalDataPath;
}

- (void)loadView
{
    foodMenuPath = [[NSBundle mainBundle] pathForResource:@"food-menu" ofType:@"plist"];
    rootLocalDataPath = [foodMenuPath stringByDeletingLastPathComponent];
    NSLog(@"foodMenuPath = %@", foodMenuPath);
    
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableData = [[NSArray alloc] initWithContentsOfFile:foodMenuPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *simpleTableId = @"SimpleTableItem";
    static NSString *simpleTableId = @"SimpleTableCell";
    
    FGFoodMenuCell *cell = (FGFoodMenuCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableId];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *recipeObj = [tableData objectAtIndex:indexPath.row];
    //NSString *imgPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[recipeObj objectForKey:@"imgPath"]];
    NSString *imgPath = [[recipeObj objectForKey:@"imgPath"] lastPathComponent];
    
    cell.labelName.text = [recipeObj objectForKey:@"name"];
    cell.imgViewThumbnail.image = [UIImage imageNamed:imgPath];
    cell.labelPrepTime.text = [recipeObj objectForKey:@"prepTime"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // If the row is ticked, remove the tick. Otherwise tick it
    if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    // Clear the select indicator with fade out effect
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
