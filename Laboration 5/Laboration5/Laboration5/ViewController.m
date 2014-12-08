//
//  ViewController.m
//  Laboration5
//
//  Created by Fredrik Sjöberg on 22/11/14.
//  Copyright (c) 2014 Fredrik Sjöberg. All rights reserved.
//

#import "ViewController.h"
@import MapKit;

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) UITapGestureRecognizer *inputRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    //tips från screencast föreläsningen för att fixa request för position för alla iOS versioner
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.navigationItem.leftBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
//hjälp från http://stackoverflow.com/questions/4317810/how-to-capture-tap-gesture-on-mkmapview med hur man hanterar taps

    self.inputRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (handleGesture:)];
    //antal touches required
    self.inputRecognizer.numberOfTapsRequired = 1;
    self.inputRecognizer.numberOfTouchesRequired = 1;
    
    [self.map addGestureRecognizer:self.inputRecognizer];
    
    self.inputRecognizer.enabled = NO;
    
}
//hjälp från http://stackoverflow.com/questions/4317810/how-to-capture-tap-gesture-on-mkmapview
//med gesture recognizer för att hantera taps
- (void) handleGesture: (UIGestureRecognizer *) gestureRecognizer {
    
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    
    CGPoint touchPoint = [gestureRecognizer locationInView: self.map];
    CLLocationCoordinate2D touchMapCoordinate = [self.map convertPoint:touchPoint toCoordinateFromView:self.map];
    
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    //sätter pin coordinate till var använderaren trycker på skärmen (touchMapCoordinate)
    pin.coordinate = touchMapCoordinate;
    pin.title = @"You were here";
    
    [self.map addAnnotation:pin];
    
}

//ändra maptype med smart lösning från screencast där man tar värdet från selectedSegmentIndex
- (IBAction)changeMapType:(UISegmentedControl *)sender {
    self.map.mapType = sender.selectedSegmentIndex;
    
}
//ändra pin on eller off på UISegmenten med samma lösning som ändra maptype
- (IBAction)pinActivate:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.inputRecognizer.enabled = NO;
    }else if (sender.selectedSegmentIndex == 1){
        self.inputRecognizer.enabled = YES;
    }
}



@end
