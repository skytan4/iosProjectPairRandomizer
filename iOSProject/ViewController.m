//
//  ViewController.m
//  iOSProject
//
//  Created by Skyler Tanner on 8/12/15.
//  Copyright (c) 2015 Skyler Tanner. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "PlayerController.h"
#import "Stack.h"
@import UIKit;

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *playersArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.playersArray = [PlayerController sharedInstance].players;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)randomizeButtonPushed:(id)sender {
    PlayerController *playerController = [PlayerController new];
    
    self.playersArray = [playerController randomizeMethod:[PlayerController sharedInstance].players];
    
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"editPlayerSegue"]) {
        
        //creates a index path that is equal to the cell that is selected.
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSInteger index = path.section *2 + path.row;
        //specifies an instance of the view we are segueing to.
        DetailViewController *detailViewController = segue.destinationViewController;
        
        //creates a new entry and sets it to the sharedInstance classes --> entries array --> index where the user clicked on this tableView.
        Player *player = [PlayerController sharedInstance].players[index];
        
        //sets the detailViewController instances entry = to the entry that was selected.
        detailViewController.player = player;
        
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([PlayerController sharedInstance].players.count == 1) {
        return 1;
    }
    return [PlayerController sharedInstance].players.count/2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([PlayerController sharedInstance].players.count == 1) {
        if (section == 0) {
            return 1;
        }
    }
    if ([PlayerController sharedInstance].players.count > 1) {
        if ([PlayerController sharedInstance].players.count % 2 == 0) {
            return 2;
        } else if ([PlayerController sharedInstance].players.count % 2 == 1){
            if (section == [PlayerController sharedInstance].players.count/2 - 1) {
                return 3;
            } else {
                return 2;
            };
        }
    }
    
    return 2;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"Pair %ld", section+1];
    return title;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NSInteger index = indexPath.section *2 + indexPath.row;
    
    Player *player = self.playersArray[index];
    
    cell.textLabel.text = player.playerName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Mentor: %@",player.mentor];

    
    return cell;
}

@end
