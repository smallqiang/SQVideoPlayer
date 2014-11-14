//
//  MainTableViewCell.h
//  SQVideoPlayer
//
//  Created by ChenYaoqiang on 14-11-5.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQMovieViewController.h"

#define CELL_HEIGHT 190.0f

@interface MainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) SQMovieViewController *moviePlayer;

- (void)showMovieView;

- (void)showImageView;

@end
