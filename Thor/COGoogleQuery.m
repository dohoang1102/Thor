//
//  COGoogleQuery.m
//  Thor
//
//  Created by Erik Aigner on 20.04.11.
//  Copyright 2011 chocomoko.com. All rights reserved.
//

#import "COGoogleQuery.h"


@implementation COGoogleQuery

- (id)init {
  self = [super init];
  if (self) {
    m_webView = [[WebView alloc] initWithFrame:NSZeroRect
                                     frameName:nil
                                     groupName:nil];
    
    [m_webView setFrameLoadDelegate:self];
    [m_webView setShouldUpdateWhileOffscreen:NO];
    
    // Define a matching predicate list for torrent links
    m_matchingPredicates = [[NSArray alloc] initWithObjects:
                   [NSPredicate predicateWithFormat:@"not SELF contains[c] 'google'"],
                   [NSPredicate predicateWithFormat:@"SELF endswith[c] '.torrent'"],
                   nil];
  }
  return self;
}

- (void)dealloc {
  [m_webView release];
  [m_matchingPredicates release];
  [super dealloc];
}

- (void)query:(NSString *)query start:(NSUInteger)start {
  NSMutableString *googleQuery = [NSMutableString stringWithString:@"http://www.google.com/search?q="];
  [googleQuery appendString:query];
  [googleQuery appendString:@"%2Bext%3Atorrent"];
  [googleQuery appendFormat:@"&start=%i", start];
  
  NSURL *url = [NSURL URLWithString:googleQuery];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  NSLog(@"query: string: %@, url: %@", googleQuery, [url absoluteString]);
  
  [[m_webView mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
  DOMDocument *document = [frame DOMDocument];
  DOMNodeList *anchors = [document getElementsByTagName:@"a"];
  NSMutableArray *torrentLinks = [NSMutableArray array];
  
  for (int i=0; i<anchors.length; i++) {
    DOMHTMLAnchorElement *anchor = (DOMHTMLAnchorElement *)[anchors item:i];
    NSString *href = [anchor href];
    BOOL doesNotMatch = NO;
    for (NSPredicate *predicate in m_matchingPredicates) {
      if (![predicate evaluateWithObject:href]) {
        doesNotMatch = YES;
        break;
      }
    }
    if (!doesNotMatch) {
      [torrentLinks addObject:href];
    }
  }
  
  NSLog(@"%@", torrentLinks);
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
  NSLog(@"error: %@", error);
}

@end
