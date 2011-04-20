//
//  ThorAppDelegate.h
//  Thor
//
//  Created by Erik Aigner on 20.04.11.
//  Copyright 2011 chocomoko.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ThorAppDelegate : NSObject <NSApplicationDelegate> {
@private
  NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
