//
//  CustomTableViewCell.h
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableViewCellDelegate <NSObject>
- (void)userDidTapPlayWithWaveId:(NSInteger)waveId;
@end

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton                   *playButton;
@property (nonatomic, weak) id <CustomTableViewCellDelegate>    delegate;
@property (nonatomic) NSInteger                                 userId;
@property (nonatomic) NSInteger                                 waveId;

@end
