//
//  DetailViewController.m
//  iOSProject
//
//  Created by Skyler Tanner on 8/12/15.
//  Copyright (c) 2015 Skyler Tanner. All rights reserved.
//

#import "DetailViewController.h"
#import "PlayerController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mentorTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTextField.text = self.player.playerName;
    self.mentorTextField.text = self.player.mentor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clearButtonPressed:(id)sender {
    self.nameTextField.text = @"";
    self.mentorTextField.text =@"";
}
- (IBAction)deleteButtonPressed:(id)sender {
    [[PlayerController sharedInstance]removePlayer:self.player];
    [[PlayerController sharedInstance]save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if (self.player) {
        self.player.playerName = self.nameTextField.text;
         self.player.mentor = self.mentorTextField.text;
        
    } else {
        
        //creates a new player and sets the name, and mentor information in the view.
        
        Player *player = [[PlayerController sharedInstance]createPlayer];
        player.playerName = self.nameTextField.text;
        player.mentor = self.mentorTextField.text;
        
        
        self.player = player;
//        //adds the player that was just created to the sharedInstance.
//        [[PlayerController sharedInstance]save];
    }
    //saves the entry to the persistent storage
    [[PlayerController sharedInstance]save];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
