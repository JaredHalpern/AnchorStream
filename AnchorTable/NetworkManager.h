//
//  NetworkManager.h
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (NetworkManager *)sharedManager;
- (void)getEndpointWithCompletion:(void(^)(NSMutableArray *result))completion;

@end