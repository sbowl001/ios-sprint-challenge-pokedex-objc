//
//  PokemonListTableViewController.h
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon_Objc-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@class SBOPokemon;

@interface PokemonListTableViewController : UITableViewController


@property (nonatomic) PokemonController *pokemonController;

@property (nonatomic) NSArray<SBOPokemon *> *pokemon;
@end

NS_ASSUME_NONNULL_END
