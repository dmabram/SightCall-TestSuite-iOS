//
//  CallerViewController.m
//  SightCallClient
//
//  Created by Ihawk on 4/25/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallerViewController.h"
#import "RTccCallManager.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"
#import "CallsGenerator.h"
#import "CallsReceiver.h"
#import "Auth.h"

#import "CallManager1.h"
#import "CallManager2.h"
#import "CallManager3.h"
#import "CallManager4.h"

@interface CallerViewController ()


@end

@implementation CallerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSArray*)managerClasses{
	return @[[CallManager1 class], [CallManager4 class], [CallManager3 class], [CallManager2 class]];
}


-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	_contactTextField.text = [self defaultContactID];
	_testTimeTextField.text = [NSString stringWithFormat:@"%@", @([self defaultTestDuration])];
	_callTimeTextField.text = [NSString stringWithFormat:@"%@", @([self defaultCallDuration])];
	_callsIntervalTextField.text = [NSString stringWithFormat:@"%@", @([self defaultDelayBeforeCall])];
}

-(NSString*)defaultUserID{
	return @"andrey";
}

-(NSString*)defaultContactID{
	return @"andreyDiet";
}

-(double)defaultCallDuration{
	return 10;
}

-(double)defaultDelayBeforeCall{
	return 40;
}

-(double)defaultTestDuration{
	return 30*60;
}

-(CallsTester*)callsTester{
	NSString * contactID = [_contactTextField text];
	double callDuration = [[_callTimeTextField text] doubleValue];
	double testDuration = [[_testTimeTextField text] doubleValue];
	double callsInterval = [[_callsIntervalTextField text] doubleValue];
	
	return [[CallsGenerator alloc] initWithManager:self.cm
									  callDuration:callDuration delayBeforeNextCall:callsInterval testDuration:testDuration
										 contactID:contactID];
}

@end
