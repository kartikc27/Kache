//
//  HomeViewController.m
//  Kache
//
//  Created by Kartik Chillakanti on 8/2/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize transactionsTable;


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
    
    //PFQuery *transactionQuery = [PFQuery queryWithClassName:@"Transaction"];
    //[transactionQuery whereKey:@"sender" equalTo:[PFUser currentUser]];
    //NSArray* objects = [transactionQuery findObjects];
    [self performSelector:@selector(retrieveFromParse)];

    
}

- (void) retrieveFromParse {
    
    PFQuery *transactionsQuery = [PFQuery queryWithClassName:@"Transaction"];
    [transactionsQuery whereKey:@"sender" equalTo:[PFUser currentUser]];
    [transactionsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            transactionsArray = [[NSArray alloc] initWithArray:objects];
        }
        [self.transactionsTable reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = transactionsArray.count;
    NSLog (@"%d", count);
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //setup cell
    static NSString *simpleTableIdentifier = @"TransactionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier]; }
    
    PFObject *tempObject = [transactionsArray objectAtIndex:indexPath.row];
    NSString *myString = [[tempObject objectForKey:@"amount"] stringValue];

    cell.textLabel.text = myString;
    
    return cell;
    
}

/*- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; // allow that row to swipe
    //return NO; // not allow that row to swipe
}*/


@end
