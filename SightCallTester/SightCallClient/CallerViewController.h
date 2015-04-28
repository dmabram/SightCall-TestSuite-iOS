//
//  CallerViewController.h
//  SightCallClient
//
//  Created by Ihawk on 4/25/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "ViewController.h"

@interface CallerViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UITextField *testTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *callTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *callsIntervalTextField;

@end
