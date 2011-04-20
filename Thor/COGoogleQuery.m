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
    m_webView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)
                                     frameName:nil
                                     groupName:nil];
    
    [m_webView setFrameLoadDelegate:self];
    [m_webView setShouldUpdateWhileOffscreen:YES];
    
    // Define a keyword blacklist for torrent links
    m_blacklist = [[NSArray alloc] initWithObjects:@"google", nil];
  }
  return self;
}

- (void)dealloc {
  [m_webView release];
  [m_blacklist release];
  [super dealloc];
}

- (NSArray *)keywordBlacklist {
  return [NSArray arrayWithObjects:@"google", nil];
}

- (void)query:(NSString *)query {
  NSMutableString *googleQuery = [NSMutableString stringWithString:@"http://www.google.com/search?q="];
  [googleQuery appendString:query];
  [googleQuery appendString:@"%2Bext%3Atorrent"];
  
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
    BOOL containsKeyword = NO;
    for (NSString *keyword in m_blacklist) {
      if ([href rangeOfString:keyword].location != NSNotFound) {
        containsKeyword = YES;
        break;
      }
    }
    if (!containsKeyword) {
      [torrentLinks addObject:href];
    }
  }
  
  NSLog(@"%@", torrentLinks);
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
  NSLog(@"error: %@", error);
}

@end
