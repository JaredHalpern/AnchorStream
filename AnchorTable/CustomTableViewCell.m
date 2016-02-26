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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)userDidTapPlayWithWaveId:(id)sender {
    if (self.delegate) {
        [self.delegate userDidTapPlayWithWaveId:self.waveId];
    }
}

@end
