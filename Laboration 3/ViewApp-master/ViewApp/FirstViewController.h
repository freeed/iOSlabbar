//
//  FirstViewController.h
//  ViewApp
//
//  Created by Alek Åström on 2012-02-01.
//  Edited by Cenny Davidsson 2014-01-15.
//  Edited by Jakob Bandelin 2014-08-22.
//  Copyright (c) 2012 Linköping University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *helloButton;
@property (weak, nonatomic) IBOutlet UIButton *quoteButton;

@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (nonatomic) NSMutableArray *quotesArray;

@end