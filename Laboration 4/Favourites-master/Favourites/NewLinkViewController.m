//
//  NewLinkViewController.m
//  Favourites
//
//  Created by Fredrik Sjöberg on 17/11/14.
//  Copyright (c) 2014 Linköpings University. All rights reserved.
//

#import "NewLinkViewController.h"

@interface NewLinkViewController ()

@end

@implementation NewLinkViewController
//returnar titeln från titleInput i UI
- (NSString *) title {
    return self.titleInput.text;
}
//returnar urln från urlInput i UI
- (NSString *) url {
    return self.urlInput.text;
}

@end
