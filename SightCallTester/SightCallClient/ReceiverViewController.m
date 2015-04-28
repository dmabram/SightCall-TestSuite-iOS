//
//  ReceiverViewController.m
//  SightCallClient
//
//  Created by Ihawk on 4/25/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "ReceiverViewController.h"
#import "RTccCallManager.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"
#import "CallsGenerator.h"
#import "CallsReceiver.h"
#import "Auth.h"

#import "CallManager1.h"
#import "CallReceiver1.h"
#import "CallReceiver2.h"
#import "CallReceiverNoReset1.h"
#import "CallReceiver3.h"
#import "CallReceiver4.h"

@interface ReceiverViewController ()

@end

@implementation ReceiverViewController

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

-(NSString*)defaultUserID{
	return @"andreyDiet";
}


-(NSArray*)managerClasses{
	return @[[CallReceiver1 class], [CallReceiver4 class], [CallReceiver3 class], [CallReceiver2 class], [CallReceiverNoReset1 class]];
}

-(CallsTester*)callsTester{
	return [[CallsReceiver alloc] initWithManager:self.cm];
}


@end
