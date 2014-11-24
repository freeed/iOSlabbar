//
//  FirstViewController.m
//  ViewApp
//
//  Created by Alek Åström on 2012-02-01.
//  Edited by Cenny Davidsson 2014-01-15.
//  Edited by Jakob Bandelin 2014-08-22.
//  Copyright (c) 2012 Linköping University. All rights reserved.
//

// --
// Börja med att öppna och kolla i MainStoryboard.storyboard. Endast en knapp finns för
// tillfället i gränssnittet för FirstViewController.
// Studera sedan FirstViewController.h samt FirstViewController.m. Notera att knappen
// har bundits till propertyn helloButton. Genom att skriva self.helloButton i koden kan
// man alltså komma åt knappen i gränssnittet. På samma sätt är händelse "Touch Up Inside",
// som alltså motsvarar en enkel nedtryckning, bunden till metoden helloButtonPressed.
// Kolla hur de olika konstruktionerna ser ut och lär dig dessa utantill.
// Att göra dessa kopplingar är mer eller mindre bara mekaniskt arbete.
//
// När du känner dig bekväm med hur alla delar hänger ihop, lägg till ytterligare
// en knapp och en textetikett i gränssnittet. Det spelar ingen större roll var du
// placerar dessa, de ska dock autosizeas vettigt till landscape-orientering.
// Målet är nu att när knappen trycks ned så ska slumpvis valt
// citat skrivas ut på textetiketten. Du får själv avgöra vilka citat du vill
// ha i din lilla "citatdatabas". Välj en lämplig datastruktur för att lagra citaten.
// Du måste nu se till att binda upp de komponenter du behöver till properties
// samt binda eventuella händelser till metoder, för att kunna slutföra uppgiften.
// --

#import "FirstViewController.h"

@implementation FirstViewController

#pragma mark - User Interaction
//skapar en array med citat
- (void) viewDidLoad {
    self.quotesArray = [[NSMutableArray alloc] init];
    self.quotesArray = [NSMutableArray arrayWithObjects:@"Life isn't about getting and having, it’s about giving and being.", @" Whatever the mind of man can conceive and be	lieve, it can achieve.", @"Strive not to be a success, but rather to be of value.", @"You miss 100% of the shots you don’t take.", nil];
}

//skapar en action för citat knappen som randomizar från arrayen med citat som sedan displayar det randomizade citatet
- (IBAction)quoteButtonPressed {
    int randomizer = arc4random_uniform(4);
    NSString *randomQuote = [self.quotesArray objectAtIndex:(randomizer)];
    [self.quoteLabel setText:(randomQuote)];
    
}

- (IBAction)helloButtonPressed {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                                 message:@"World"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertViewController addAction:okButton];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}



#pragma mark - View lifecycle

- (NSUInteger)supportedInterfaceOrientations {
    // Retunera tillåtna orientations
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
