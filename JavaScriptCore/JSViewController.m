//
//  JSViewController.m
//  JavaScriptCore
//
//  Created by HI00003 on 2013/09/16.
//  Copyright (c) 2013年 classmethod, inc. All rights reserved.
//

#import "JSViewController.h"

@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self invokeExploreObjects];
    [self invokeUnderscoreJs];
    [self invokeJquery];

}

- (void)invokeUnderscoreJs
{
    // JSContextオブジェクトを作成
    JSContext *context = [[JSContext alloc] init];
    
    // underscore.js を NSString として読み込み
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"underscore-min" ofType:@"js"];
    NSString *us = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    // JavaScriptを評価
    [context evaluateScript:us];
    JSValue *result = [context evaluateScript:@"_.isString(3);"];

    NSLog(@"%@", result);
}

- (void)invokeJquery
{
    // JSContextオブジェクトを作成
    JSContext *context = [[JSContext alloc] init];
    
    // jQuery を NSString として読み込み
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jquery-2.0.3.min" ofType:@"js"];
    NSString *jq = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    // JavaScriptを評価
    [context evaluateScript:jq];
    JSValue *result = [context evaluateScript:@"$.now()"];
    
    NSLog(@"%@", result);
}
-(void)invokeExploreObjects
{
    JSContext *context = [[JSContext alloc]init];
    JSValue *result;
    result = [context evaluateScript:@"window"];
    NSLog(@"window = %@", result);
    result = [context evaluateScript:@"XMLHttpRequest"];
    NSLog(@"XMLHttpRequest = %@", result);
    result = [context evaluateScript:@"var all=''; for(var s in this){all += s + ','} all;"];
    NSLog(@"this = %@", result);
    result = [context evaluateScript:@"Array"];
    NSLog(@"Array = %@", result);
    result = [context evaluateScript:@"new Date()"];
    NSLog(@"new Date() = %@", result);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end