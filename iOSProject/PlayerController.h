//
//  PlayerController.h
//  iOSProject
//
//  Created by Skyler Tanner on 8/12/15.
//  Copyright (c) 2015 Skyler Tanner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerController : NSObject


//CRUD

//Create Method
- (Player *)createPlayer;

//Read/(Singleton)
@property (strong, nonatomic,readonly)NSArray *players;

+ (PlayerController *)sharedInstance;

//Update - POINTERS do it for us.

//Delete Method
- (void)removePlayer:(Player *)player;

//Save Methods
- (void)save;

- (NSArray *)randomizeMethod:(NSArray *)array;

@end
