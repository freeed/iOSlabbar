//
//  SecondViewController.m
//  ViewApp
//
//  Created by Alek Åström on 2012-02-01.
//  Edited by Cenny Davidsson 2014-01-15.
//  Edited by Jakob Bandelin 2014-08-22.
//  Copyright (c) 2012 Linköping University. All rights reserved.
//

// --
// Den här vy-kontrollern är skapad utan storyboarden. Du ska här bygga samma gränssnitt som
// du gjorde med Interface Builder i FirstViewController. Men nu har du alltså inte tillgång
// till Interface Builder vid själva skapande av gränssnittet. Dock kan det vara praktiskt
// kolla vad komponenterna du skapar ska ha för koordinater och storlek genom att titta på
// storyboarden. Interface Builder kan således vara en hjälp medan du bygger det faktiska
// gränssnittet, bara för att slippa chansa var saker och ting ska hamna samt hur stora de
// ska vara.
//
// Innan du börjar koda, ta lite tid och titta igenom koden för den här vy-kontrollern och
// försöka se skillnaderna mellan att använda Interface Builder och att inte gör det.
// Framförallt är det viktigt att du förstår hur koden i loadView fungerar.
// Andra komponenter skapas på ungefär liknande sätt. Glöm inte heller bort att layouten
// ska autosizeas och se bra ut i landscape-orientering!
//
// Observera att du här gör gränsnittet utanför din storyboard bara för träning.
// I vanliga fall är Interface Builder nästan alltid att föredra och prestandaskillnaden
// till att skapa vyerna programmatiskt är i princip obefintlig och till Interface Builders
// fördel (!). Enda gångerna du vill skapa vyer programmatiskt är egentligen när de måste
// skapas på ett sådant dynamiskt sätt att det inte går att lösa smidigt med
// Interface Builder. I sådana fall kan det till och med vara bättre att tänka om och dela
// upp i flera vykontroller istället.
//
// --

#import "SecondViewController.h"

@implementation SecondViewController

#pragma mark - User Interaction

//action för hello knappen när man trycker på den
- (void)helloButtonPressed {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Hello"
                                                                                 message:@"World"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertViewController addAction:okButton];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}
//action för citat knappen när man trycker på den
//randomizar från citat arrayen och visar det randomizade citatet i citat labeln
- (void)quoteButtonPressed {
    int randomizer = arc4random_uniform(4);
    NSString *randomQuote = [self.quotesArray objectAtIndex:(randomizer)];
    [self.quoteLabel setText:(randomQuote)];
    
}



#pragma mark - View lifecycle

// Överlagra metoden loadView för att lägga till ytterligare grafiska komponenter.
// Man kan även överlagra metoden viewDidLoad, men den används oftast när ens vy-hierarki
// redan är uppsatt.
- (void)loadView {
    [super loadView];
    //array med citat
    self.quotesArray = [[NSMutableArray alloc] init];
    self.quotesArray = [NSMutableArray arrayWithObjects:@"Life isn't about getting and having, it’s about giving and being.", @" Whatever the mind of man can conceive and be	lieve, it can achieve.", @"Strive not to be a success, but rather to be of value.", @"You miss 100% of the shots you don’t take.", nil];
                        // Ytterst viktigt att ropa på superklassens implementation först
                        // Annars finns inte self.view som kommer ur storyboarden
    
    // Koden nedan skapar en vanlig knapp med texten "Hello". Den placeras på koordinaterna
    // (x=100, y=20) och har storleken (bredd=120, höjd=40). 
    // Notera att addTarget:action:forControlEvents: används för att binda vilken metod det är
    // som anropas när knappen trycks ned.
    // Sedan sätts en autoresizingmask på vyn för att den ska flyttas korrekt när man
    // roterar enheten. Observera att man använder OR-operatorn (|) för att välja flera
    // alternativ samtidigt.
    // Sista raden lägger till den nyskapade knappen i den vy som är associerad med den
    // nuvarande vy-kontrollern. Detta är normalt sett en vy som täcker nästan hela skärmen.
   
    //skapar en ny knapp i UI
    self.helloButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.helloButton.frame = CGRectMake(30.0, 20.0, 120.0, 40.0);
    [self.helloButton setTitle:@"Hello" forState:UIControlStateNormal];
    [self.helloButton addTarget:self 
                         action:@selector(helloButtonPressed) 
               forControlEvents:UIControlEventTouchUpInside];
    
    self.helloButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.helloButton];
    
    //skapar en citat knapp i UI
    self.quoteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.quoteButton.frame = CGRectMake(180.0, 20.0, 120.0, 40.0);
    [self.quoteButton setTitle:@"Generate" forState:(UIControlStateNormal)];
    [self.quoteButton addTarget:self action:@selector(quoteButtonPressed) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.quoteButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.quoteButton];
    
    //skapar label i UI
    self.quoteLabel = [[UILabel alloc] init];
    self.quoteLabel.frame = CGRectMake(10.0, 100.0, 300.0, 150.0);
    self.quoteLabel.textColor = [UIColor blackColor];
    self.quoteLabel.userInteractionEnabled=YES;
    self.quoteLabel.numberOfLines = 5;
    self.quoteLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.quoteLabel];
    self.quoteLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.quoteLabel];
}




- (NSUInteger)supportedInterfaceOrientations {
    // Retunera tillåtna orientations
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end