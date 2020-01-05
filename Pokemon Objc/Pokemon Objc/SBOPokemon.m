//
//  SBOPokemon.m
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "SBOPokemon.h"
#import <UIKit/UIKit.h>

@implementation SBOPokemon

-(nonnull instancetype) initWithName: (nonnull NSString *)pokemonName identifier: (int)identifier abilities:(nullable NSString *)abilities image:(nullable UIImage *)pokemonSprite
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _pokemonName = [pokemonName copy];
        _abilities = [abilities copy];
        _pokemonSprite = pokemonSprite;
        
    }
    return self;
}

-(instancetype) initWithDictionary: (NSDictionary *)dictionary
{
    NSString *pokemonName = dictionary[@"name"];
    
 
    return [self initWithName:pokemonName identifier:NULL abilities:NULL image:NULL];

}
 

@end
