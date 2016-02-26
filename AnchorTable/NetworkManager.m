//
//  NetworkManager.m
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager ()
@property (nonatomic, strong) NSURL                     *baseURL;
@property (nonatomic, strong) AFHTTPSessionManager      *sessionManager;
@end

@implementation NetworkManager

+ (NetworkManager *)sharedManager {
    
    static NetworkManager *_sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NetworkManager alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.baseURL = [NSURL URLWithString:kBaseURLString];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)getEndpointWithCompletion:(void(^)(NSMutableArray *result))completion {
    
    // leaving the URLString blank below because this example just involves hitting the baseURL.
    [self.sessionManager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *responseArray = (NSMutableArray *)responseObject;        
        if (completion) {
            completion(responseArray);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%s - error: %@", __PRETTY_FUNCTION__, [error description]);
    }];
}

@end