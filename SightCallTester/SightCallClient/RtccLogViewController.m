//
//  RtccLogViewController.m
//  SightCallClient
//
//  Created by Ihawk on 4/27/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "RtccLogViewController.h"
#import "Log.h"

@interface RtccLogViewController ()
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation RtccLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogMessage:) name:[Log onRtccLogUpdatedNotificationName] object:nil];
	_logTextView.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillDisappear:(BOOL)animated{
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//}

-(void)onLogMessage:(NSNotification*)notification{
	dispatch_async(dispatch_get_main_queue(), ^{
		_logTextView.text = [NSString stringWithFormat:@"%@\n%@",[_logTextView text], [notification object]];
	});
	
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
