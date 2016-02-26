//
//  ViewController.m
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+AFNetworking.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray        *dataSourceArray;
@property (nonatomic, strong) AVPlayer              *avPlayer;

@end

static NSString *cellIdentifier = @"cell";

@implementation ViewController

#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVPlayerItem *playerItem = nil;
    self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackComplete:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.avPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // only show rows which contain data
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak ViewController *welf = self;
    
    [[NetworkManager sharedManager] getEndpointWithCompletion:^(NSMutableArray *result) {
        welf.dataSourceArray = [result mutableCopy];
        [welf.tableView reloadData];
    }];
}

#pragma mark - CustomTableViewCellDelegate

- (void)userDidTapPlayWithWaveId:(NSInteger)waveId {
    
    // map waveId to audioURL
    // not ideal: O(n) but leave for now and optimize later
    
    for (NSDictionary *waveObject in self.dataSourceArray) {
        if ([[waveObject objectForKey:kKeyWaveId] integerValue] == waveId) {
            
            // do some data validation / sanity check here.
            
            // we've found our wave. now play it.
            [self playAudioURL:[NSURL URLWithString:[waveObject objectForKey:kKeyAudioUrl]]];
        }
    }
}

- (void)userDidPause {
    [self.avPlayer pause];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSMutableDictionary *waveDict = self.dataSourceArray[indexPath.row];
    
    NSURL *imageURL = [NSURL URLWithString:[(NSString *)waveDict valueForKey:kKeyPhotoUrl]];
    [cell.imageView setImageWithURL:imageURL placeholderImage:nil];
    
    cell.textLabel.text = [waveDict valueForKey:kKeyUserName];
    cell.userId = [[waveDict valueForKey:kKeyUserId] integerValue];
    cell.waveId = [[waveDict valueForKey:kKeyWaveId] integerValue];
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - AVPlayer

- (void)playAudioURL:(NSURL *)audioURL {
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:audioURL];

    [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [self.avPlayer play];
}

- (void)playbackComplete:(id)note {

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:kKeyNameRate]) {
        
        CGFloat rate = [change[NSKeyValueChangeNewKey] floatValue];
        
        if (rate == 0.0) {
            // Stopped
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResetAllButtonStates object:nil];
        } else if (rate == 1.0) {
            // Normal
        }
    }
}

#pragma mark - Private

- (void)dealloc {
    [self removeObserver:self forKeyPath:kKeyNameRate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



