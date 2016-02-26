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

@end
