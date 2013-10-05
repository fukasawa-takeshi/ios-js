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
    
    [self invokeJavaScriptFromObjC];
    [self invokeJavaScriptFunctionFromObjC];
    [self invokeObjeCFromJavaScript];

}
// --- Objective-CからJavaScriptを呼び出し
- (void)invokeJavaScriptFromObjC
{
    // JSContextオブジェクトを作成
    JSContext *context = [[JSContext alloc] init];
    // 計算
    JSValue *result = [context evaluateScript:@"1 + 2;"];
    
    // 結果
    NSLog(@"1 + 2 = %d", [result toInt32]);
}

- (void)invokeJavaScriptFunctionFromObjC
{
    // JSContextオブジェクトを作成
    JSContext *context = [[JSContext alloc] init];
    // JavaScriptを評価
    [context evaluateScript:@"function multiply(a, b){return a * b;}"];
    // multiply ファンクションをJSValueインスタンスに
    JSValue *multiply = context[@"multiply"];
    // multiply用に引数を定義
    NSArray *args = @[[NSNumber numberWithInt:2],[NSNumber numberWithInt:3]];
    // multiply ファンクションを引数付きで呼び出し(引数無しの場合は callWithArguments の引数を nil に)
    JSValue *result = [multiply callWithArguments:args];
    
    // 結果
    NSLog(@"2 * 3 = %d", [result toInt32]);
}

- (void)invokeObjeCFromJavaScript
{
    // JSContextオブジェクトを作成
    JSContext *context = [[JSContext alloc] init];
    // Blocks を定義して JSContext に設定
    context[@"multiply"] = ^(int a,int b)
    {
        return a * b;
    };
    
    NSString * jsCode = @"multiply(2,4);";
    // multiply ファンクションを呼び出し
    JSValue * result = [context evaluateScript:jsCode];
    
    // 結果
    NSLog(@"2 * 4 = %d", [result toInt32]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end