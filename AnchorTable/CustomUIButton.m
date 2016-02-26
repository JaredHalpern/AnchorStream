//
//  CustomUIButton.m
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import "CustomUIButton.h"

@implementation CustomUIButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetButtonState:) name:kNotificationResetAllButtonStates object:nil];
        [self setImage:[UIImage imageNamed:@"playbutton.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"pausebutton.png"] forState:UIControlStateSelected];
    }
    return self;
}

//- (void)setSelected:(BOOL)selected {
//    [super setSelected:selected];
//    
//    [self setNeedsLayout];
//}

#pragma mark -

- (void)resetButtonState:(id)note {
    [self setSelected:NO];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
