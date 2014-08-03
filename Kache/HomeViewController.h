//
//  HomeViewController.h
//  Kache
//
//  Created by Kartik Chillakanti on 8/2/14.
//  Copyright (c) 2014 ychacks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate> {
    NSArray *transactionsArray;

}
@property (weak, nonatomic) IBOutlet UITableView *transactionsTable;

@end
