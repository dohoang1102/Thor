//
//  COGoogleQuery.h
//  Thor
//
//  Created by Erik Aigner on 20.04.11.
//  Copyright 2011 chocomoko.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@class COGoogleQuery;

typedef void (^COGoogleQueryCallback)(COGoogleQuery *query);

@interface COGoogleQuery : NSObject {
@private
  WebView               *m_webView;
  NSArray               *m_matchingPredicates;
  NSArray               *m_results;
  COGoogleQueryCallback m_callback;
}

@property (nonatomic, retain, readonly) NSArray *results;

- (void)query:(NSString *)query start:(NSUInteger)start callback:(COGoogleQueryCallback)callback;

@end
