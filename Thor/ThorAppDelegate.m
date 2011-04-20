//
//  ThorAppDelegate.m
//  Thor
//
//  Created by Erik Aigner on 20.04.11.
//  Copyright 2011 chocomoko.com. All rights reserved.
//

#import "ThorAppDelegate.h"

#import "COGoogleRequest.h"


@implementation ThorAppDelegate
@synthesize window;

- (NSString *)testQuery0 {
  return @"i%20am%20number%20four";
}

- (NSString *)testQuery1 {
  return @"how%20i%20met%20your%20mother";
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  
  COGoogleRequest *request = [COGoogleRequest new];
  [request query:[self testQuery1]];
}

@end
