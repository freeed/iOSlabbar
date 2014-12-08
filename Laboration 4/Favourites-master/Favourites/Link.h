//
//  Link.h
//  Favourites
//
//  Created by Alek Åström on 2012-02-12.
//  Edited by Cenny Davidsson 2014-01-15.
//  Copyright (c) 2012 Linköpings Universitet. All rights reserved.
//


//modiferad för att ha med titel
#import <Foundation/Foundation.h>

@interface Link : NSObject

@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, strong, readwrite) NSString *title;


- (instancetype)initWithURL:(NSURL *)anURL
                      Title:(NSString *) aTitle;
                    
@end
