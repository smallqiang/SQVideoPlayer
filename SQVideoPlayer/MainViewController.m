//
//  MainViewController.m
//  SQVideoPlayer
//
//  Created by ChenYaoqiang on 14-11-5.
//  Copyright (c) 2014年 ChenYaoqiang. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"

@interface MainViewController ()

@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"视频播放";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainTableViewCell";
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:@"MainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    [cell.playButton addTarget:self action:@selector(playOrStop:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.delegate = self;
    [cell.moviePlayer.view addGestureRecognizer:tap];
    
    NSInteger row = indexPath.row;
    cell.playButton.tag = row;
    cell.avatarIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",row+1]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select");
}

- (void)playOrStop:(UIButton *)button
{
    _currentRow = button.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    MainTableViewCell *cell = (MainTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerLoadStateChanged:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://g3.letv.cn/vod/v2/MTE3LzM0LzI4L2JjbG91ZC8xMDE3MTEvdmVyXzAwXzE2LTMxMTIwOTMyLWF2Yy0yMDAwMDAwLWFhYy0xMDM2ODgtNzM5NTktMTk2ODI5MjEtMjhlNjk5NWM3Njk5ZWE3MTUxZmI3YmU4ZjNiZTg3OGUtMTQxNTE2OTg4ODMyOC5tcDQ=?b=2129&mmsid=24591682&tm=1415178161&key=022b34a6ed4ef3619a4a38ce0466f6aa&platid=2&splatid=206&playid=0&tss=no&vtype=28&cvid=1103723502191&tag=mobile&bcloud=S7&sign=bcloud_101711&termid=2&pay=0&ostype=android&hwtype=un"];
    
    [cell.moviePlayer.moviePlayer setContentURL:url];
    [cell.moviePlayer.moviePlayer prepareToPlay];
}

- (void)moviePlayerLoadStateChanged:(NSNotification*)notification
{
    MPMoviePlayerController *moviePlayer = [notification object];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    MainTableViewCell *cell = (MainTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    if (moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        [cell showMovieView];
        _isPlaying = YES;
    }
    else
    {
        _isPlaying = NO;
    }
}

- (void)moviePlayerDidFinish:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    MainTableViewCell *cell = (MainTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    [cell showImageView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"MainTableViewCell"]) {
//        return NO;
//    }
    return  YES;
}

- (void)handleTap:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"handle");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    MainTableViewCell *cell = (MainTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    cell.moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    [self presentViewController:cell.moviePlayer animated:NO
                     completion:^{
                         
                     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
