//
//  main.m
//  DogWalkingArtifact
//
//  Created by runingfish on 2025/7/26.
//

#import <UIKit/UIKit.h>
#import "DogAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([DogAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
