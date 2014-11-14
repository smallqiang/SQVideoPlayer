//
//  MainTableViewCell.m
//  SQVideoPlayer
//
//  Created by ChenYaoqiang on 14-11-5.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.playerView = [[UIView alloc]initWithFrame:_avatarIV.frame];
    _playerView.backgroundColor=[UIColor clearColor];
//    [self insertSubview:_playerView belowSubview:_avatarIV];
    [self.contentView addSubview:_playerView];
    
    _moviePlayer=[[SQMovieViewController alloc]init];
    [_moviePlayer.view setFrame:_avatarIV.bounds];
    _moviePlayer.moviePlayer.shouldAutoplay=YES;
    _moviePlayer.moviePlayer.initialPlaybackTime = -1.0;
    _moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [_playerView addSubview:_moviePlayer.view];
    _playerView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showMovieView
{
    _playerView.hidden = NO;
    _avatarIV.hidden = YES;
    _playButton.hidden = YES;
}

- (void)showImageView
{
    _playerView.hidden = YES;
    _avatarIV.hidden = NO;
    _playButton.hidden = NO;
}

@end
