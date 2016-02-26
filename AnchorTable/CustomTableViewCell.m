//
//  CustomTableViewCell.m
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetButtonState:) name:kNotificationResetAllButtonStates object:nil];
}

- (IBAction)userDidTapPlayWithWaveId:(id)sender {
    BOOL newSelectedState = !self.playButton.selected;
    
    [self.playButton setSelected:newSelectedState];
    
    if (self.delegate) {
        if (newSelectedState) {
            [self.delegate userDidTapPlayWithWaveId:self.waveId];
        } else {
            [self.delegate userDidPause];
        }

    }
}

#pragma mark -

- (void)resetButtonState:(NSNotification *)note {

    NSDictionary *payloadDict = note.userInfo;

    if ([payloadDict[@"waveId"] integerValue] != self.waveId) {
        [self.playButton setSelected:NO];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
