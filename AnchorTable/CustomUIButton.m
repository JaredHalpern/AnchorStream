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
        
        [self setImage:[UIImage imageNamed:@"playbutton.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"pausebutton.png"] forState:UIControlStateSelected];
    }
    return self;
}

@end
