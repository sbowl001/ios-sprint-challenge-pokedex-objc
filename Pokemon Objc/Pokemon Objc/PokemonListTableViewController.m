//
//  PokemonListTableViewController.m
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "PokemonListTableViewController.h"
#import "SBOPokemon.h"
#import "PokemonDetailViewController.h"
#import "Pokemon_Objc-Swift.h"

@interface PokemonListTableViewController ()

@end

@implementation PokemonListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _pokemonController = [[PokemonController alloc] init];
    //why can the following be a different name?
    [PokemonController.sharedController getPokemonWithCompletion:^(NSArray<SBOPokemon *> *pokemon, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemon = pokemon;
                [self.tableView reloadData];
            });
        }
     ];
}

#pragma mark - Table view data source

 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return  self.pokemon.count;
}

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
     SBOPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
     cell.textLabel.text = pokemon.pokemonName;
    
    return cell;
}
 



 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"ShowDetail"]) {
            NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
            PokemonDetailViewController *detailVC = segue.destinationViewController;
            
            detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
        }
}
 

@end
