//
//  PokemonDetailViewController.h
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class SBOPokemon;

@interface PokemonDetailViewController : UIViewController
@property (nonatomic) SBOPokemon *pokemon;
//@property (nonatomic) PokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
