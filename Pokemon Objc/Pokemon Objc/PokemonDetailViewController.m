//
//  PokemonDetailViewController.m
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "SBOPokemon.h"
#import "Pokemon_Objc-Swift.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonSprite;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [PokemonController.sharedController fillInPokemonWithPokemon:self.pokemon];
}

- (void)setPokemon:(SBOPokemon *)pokemon {
    if(pokemon != _pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
         [_pokemon removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"pokemonSprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }

    
}
-(void)updateViews {
    if(!self.pokemon || !self.isViewLoaded) {return;}
    
    self.pokemonName.text = [self.pokemon.pokemonName capitalizedString];
    self.pokemonID.text = [NSString stringWithFormat:@"%d", self.pokemon.identifier];
    self.abilitiesLabel.text = [self.pokemon.abilities componentsJoinedByString:@", "];
//    self.pokemonSprite = self.pokemon.pokemonSprite;
    [_pokemonSprite setImage:_pokemon.pokemonSprite];
//    self.pokemonSprite.image = [[UIImage alloc] initWithData:self.pokemon.pokemonSprite];
     
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
