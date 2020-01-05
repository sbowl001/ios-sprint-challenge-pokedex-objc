//
//  PokemonController.swift
//  Pokemon Objc
//
//  Created by Stephanie Bowles on 12/23/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

@objc(PokemonController)

class PokemonController: NSObject {
    
    
//    var pokemons = [Pokemon]()
    
    let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon/")!
    
//    @objc var pokemons: [SBOPokemon]()
    
    @objc static let shared = PokemonController()
    
    
    @objc func getPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
       var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "250")]
        
        guard let requestURL = urlComponents?.url else { fatalError("Pokemon url could not be constructed")}
             var request = URLRequest(url: requestURL)
             request.httpMethod = "GET"
        
        
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
                
                
            let results = dictionary["results"] as! [[String: Any]]
                //what is this using?
             let pokemon = results.compactMap { Pokemon(dictionary: $0) }
      //looking this up as forloop didn't work. Explanation?
            completion(pokemon, nil)
        }
            catch {
                    NSLog("Error decoding random users JSON \(error)")
                                   completion(nil, error)
                                   return
                }
            }.resume()

    }
 @objc func fillInPerson(for pokemon: Pokemon) {
 
    
    
    var urlComponents = URLComponents(url: baseURL.appendingPathComponent(pokemon.pokemonName!), resolvingAgainstBaseURL: true)
    
    guard let requestURL = urlComponents?.url else { return }
    var request = URLRequest(url: requestURL)
    request.httpMethod = "GET"
    //do I actually need the "GET"? Moin's randomUser solution didn't and still worked
    
    URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
        if let error = error {
            NSLog("Error fetching data \(error)")
            return
        }
        guard let data = data else {
            NSLog("Error returning data")
            return
        }
         do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
             
              
                let identifier = dictionary["id"] as! Int
                pokemon.identifier = Int32(identifier)
                
                let abilities = dictionary["abilities"] as! [[String : Any]]
            var allAbilities: [String] = []
            for abilityDictionary in abilities {
                let ability = abilityDictionary["ability"] as! [String: Any]
                let abilityName = ability["name"] as! String
                allAbilities.append(abilityName)
            }
            pokemon.abilities = allAbilities
            
            
                let pictureObject = dictionary["sprites"] as! [String: Any]
                let imageString = pictureObject["front_default"] as! String
                
                let imageData = try! Data(contentsOf: URL(string: imageString)!)
            
                let image = UIImage(data: imageData)!
                 
                pokemon.pokemonSprite = image
                    
                    
 
            } catch {
                NSLog("error decoding random users JSON \(error)")
                    return
                }
                
            }.resume()
        
}
}
