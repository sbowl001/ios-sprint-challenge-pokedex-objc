//
//  SBOPokemon.h
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <UIKit/UIKit.h>


//NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)

@interface SBOPokemon : NSObject
@property (nonatomic) int identifier;
@property (nonatomic, copy, nullable) NSString *pokemonName;
//@property (nonatomic, copy, nullable) NSString *url;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, nullable) UIImage *pokemonSprite;


-(nonnull instancetype) initWithName: (nullable NSString *)pokemonName identifier: (int)identifier abilities:(nullable NSString *)abilities image:(nullable UIImage *)pokemonSprite;

-(nonnull instancetype) initWithDictionary: (nonnull NSDictionary *)dictionary;
@end

//NS_ASSUME_NONNULL_END

