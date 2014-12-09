//
//  MasterViewController.m
//  Favourites
//
//  Created by Cenny Davidsson on 2014-10-03.
//  Copyright (c) 2014 Linköpings University. All rights reserved.
//

/*
 Denna vykontroller styr en tabell som visar länkar.
 När en användare trycker på en länk pushas DetailViewController in på iPhone,
 medan på iPad så uppdateras bara DetailViewController med en ny länk.
 Observera även att prepareForSegue körs för att skicka länken till den pushade
 vykontrollern på iPhone.
 
 Det du behöver göra i denna vykontroller är tre saker:
 
 1: Användaren ska kunna ta bort länkar med swipe-to-delete och genom att gå in
 i editing mode.
 
 2: Cellerna inte bara visa URLen på länken men även en titel. För att göra det
 behöver ni ändra stil på tabellvycellen som visas. Ni får göra en egen cell,
 men ni kan även använda någon av de andra inbyggda cellstilarna. Se även till att
 uppdatera modellen (Link) så att den har en property för en titel.
 
 3: Användaren ska kunna lägga in nya länkar med en modal vykontroller. Vy-kontrollern
 ska innehålla ett formulär för att skriva in en URL och en titel på länken. Ni kommer
 vara tvugna att skriva ett eget delegatprotokoll för att skicka data tillbaka till denna
 vykontroller när användaren fyllt i formuläret. På iPad är det lämpligt att använda sig
 av stilen UIModalPresentationFormSheet för att presentera vykontrollern.
 */

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Link.h"
#import "NewLinkViewController.h"

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //edit-knapp
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
   
    //Kollar om device är iPad
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //Sätter layouten
        self.detailViewController = (DetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        self.detailViewController.link = (self.links)[0];
        
        self.clearsSelectionOnViewWillAppear = NO;
    }

}

#pragma mark - Segues
//returna till tableview med ny skapad länk segue
- (IBAction)returnToTableView:(UIStoryboardSegue *) segue {
    NewLinkViewController *returnTview = segue.sourceViewController;
    Link *addlink = [[Link alloc] initWithURL: [NSURL URLWithString:returnTview.url] Title: returnTview.title];
    [self.links addObject:addlink];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        // Hämta länken från våran array.
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Link *link = self.links[indexPath.row];
        
        // Skicka länken till detaljvyn.
        DetailViewController *controller = (DetailViewController *)[segue.destinationViewController topViewController];
        controller.link = link;
        
        // Splitview configuration
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.links.count;
}
//ta bort från array och datasource med swipe
- (void) tableView: (UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.links removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Hämta cell.
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Hämta data.
    Link *link = self.links[indexPath.row];
    
    // Konfigurera cellen
    cell.textLabel.text = [NSString stringWithFormat:@"%@", link.title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", link.url];
    
    return cell;
}



@end
