//
//  PokemonController.swift
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

@objc (PokemonController)
class PokemonController: NSObject {
    
    let baseURL = URL(string:"")!
    
    @objc var pokemons: [SBOPokemon] = []
    
    @objc static let shared = PokemonController()
    
    
    @objc func getPokemon(completion: @escaping ([SBOPokemon?], Error?) -> Void) {
        let requestURL = baseURL
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("error getting Pokemon \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { NSLog("error returning data")
                completion(nil, nil)
                return
      
                }
            do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
            let pokemonDictionaries = dictionary["results"] as! [[String: Any]]
            for pokemonDictionary in pokemonDictionaries {
                let pokemons = SBOPokemon(dictionary: pokemonDictionary)
                self.pokemons.append(pokemon)
            }
            completion(self.pokemons, nil)
        }
            catch {
                    NSLog("Error decoding random users JSON \(error)")
                                   completion(nil, error)
                                   return
                }
            }.resume()

    }
 @objc func fillInPerson(person: SBOPokemon) {
    let randomIndex = Int(arc4random_uniform(999));
    let requestURL = baseURL
    URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
        if let error = error {
            NSLog("Error getting Users \(error)")
            return
        }
        guard let data = data else {
            NSLog("Error returning data")
            return
        }
         do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                let pokemonDictionaries = dictionary["name"] as! [[String: Any]]
                let pokemonDictionary = pokemonDictionaries[randomIndex]
                let identifier = pokemonDictionary["identifier"] as! Identifier
                let abilities = pokemonDictionary["abilities"]["ability"]["name"] as! String
                let pictureObject = pokemonDictionary["sprites"] as! [String: Any]
                let largeImageString = pictureObject["front_default"] as! String
                pokemon.identifier = identifier
              pokemon.abilities = abilities
                let largeImageData = try! Data(contentsOf: URL(string: largeImageString)!)
                
                let image = UIImage(data: largeImageData)!
                pokemon.sprite = image
                  
            } catch {
                NSLog("error decoding random users JSON \(error)")
                    return
                }
                
            }.resume()
        
}
}
