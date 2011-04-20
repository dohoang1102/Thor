//
//  COGoogleQuery.h
//  Thor
//
//  Created by Erik Aigner on 20.04.11.
//  Copyright 2011 chocomoko.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@interface COGoogleQuery : NSObject {
@private
  WebView *m_webView;
  NSArray *m_blacklist;
}

- (void)query:(NSString *)query;

@end
