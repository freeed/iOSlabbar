//
//  NewLinkViewController.h
//  Favourites
//
//  Created by Fredrik Sjöberg on 17/11/14.
//  Copyright (c) 2014 Linköpings University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewLinkViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *titleInput;
@property (strong, nonatomic) IBOutlet UITextField *urlInput;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *url;

@end
