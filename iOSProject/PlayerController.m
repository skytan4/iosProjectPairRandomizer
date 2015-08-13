//
//  PlayerController.m
//  iOSProject
//
//  Created by Skyler Tanner on 8/12/15.
//  Copyright (c) 2015 Skyler Tanner. All rights reserved.
//

#import "PlayerController.h"
#import "Stack.h"
static NSString *allPlayersKey = @"allPlayers";

@interface PlayerController()

@property (strong, nonatomic, readwrite)NSArray *players;

@end

@implementation PlayerController

+ (PlayerController*)sharedInstance{
    static PlayerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [PlayerController new];
        
        sharedInstance.players = [NSArray new];
        
    });
    return sharedInstance;
}

#pragma mark - Create

-(Player *)createPlayer{
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    return player;
}


#pragma mark - Retrieve

-(NSArray *)players{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    
    NSError *error;
    
    NSArray *allEntries = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error fetching objects : %@", error.localizedDescription);
    }
    
    return allEntries;
}

#pragma mark - Remove
- (void)removePlayer:(Player *)player{
    [player.managedObjectContext deleteObject:player];
}

#pragma mark -save
- (void)save
{
    NSError *error;
    
    [[Stack sharedInstance].managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
}

- (NSArray *)randomizeMethod:(NSArray *)array {
    
    NSMutableArray *returnArray = [array mutableCopy];
    
    for (int x = 0; x <= array.count-1; x++) {
        int randInt = arc4random_uniform(x+1);
        [returnArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    

    return returnArray;
}
@end
