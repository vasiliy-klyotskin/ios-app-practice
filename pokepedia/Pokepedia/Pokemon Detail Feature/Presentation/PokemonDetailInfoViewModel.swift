//
//  PokemonDetailInfoViewModel.swift
//  Pokepedia
//
//  Created by Vasiliy Klyotskin on 7/25/23.
//

import Foundation

public struct DetailPokemonInfoViewModel: Equatable {
    public let imageUrl: URL
    public let id: String
    public let name: String
    public let genus: String
    public let flavorText: String
}

public typealias DetailPokemonAbilitiesViewModel<Color: Equatable & Hashable> = [DetailPokemonAbilityViewModel<Color>]

public struct DetailPokemonAbilityViewModel<Color: Equatable & Hashable>: Equatable, Hashable {
    public let title: String
    public let subtitle: String
    public let damageClass: String
    public let damageClassColor: Color
    public let type: String
    public let typeColor: Color
}
