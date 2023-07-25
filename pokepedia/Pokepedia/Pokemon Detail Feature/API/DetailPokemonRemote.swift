//
//  DetailPokemonRemote.swift
//  Pokepedia
//
//  Created by Василий Клецкин on 7/25/23.
//

import Foundation

public struct DetailPokemonRemote: Decodable {
    let imageUrl: URL
    let id: String
    let name: String
    let genus: String
    let flavorText: String
    let abilities: [Ability]
    
    struct Ability: Decodable {
        let title: String
        let subtitle: String
        let damageClass: String
        let type: String
    }
}
