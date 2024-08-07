//
//  PokemonListRemoteMapper.swift
//  Pokepedia
//
//  Created by Vasiliy Klyotskin on 5/16/23.
//

import Foundation

public enum PokemonListRemoteMapper {
    public static func map(remote: PokemonListRemote) -> PokemonList {
        remote.map {
            .init(
                id: $0.id,
                name: $0.name,
                imageUrl: $0.iconUrl,
                physicalType: .init(color: $0.physicalType.color, name: $0.physicalType.name),
                specialType: $0.specialType.map { .init(color: $0.color, name: $0.name) }
            )
        }
    }
}
