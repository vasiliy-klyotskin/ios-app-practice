//
//  ListPokemonItemUIComposer.swift
//  Pokepedia-iOS-App
//
//  Created by Vasiliy Klyotskin on 6/2/23.
//

import Pokepedia_iOS
import Pokepedia
import Combine
import UIKit

enum ListPokemonItemUIComposer {
    private typealias PresentationAdapter = ResourceLoadingPresentationAdapter<ListPokemonItemImage, WeakProxy<ListPokemonItemViewController>>
    
    static func compose(
        item: PokemonListItem,
        loader: @escaping () -> AnyPublisher<ListPokemonItemImage, Error>,
        onSelection: @escaping () -> Void
    ) -> ListPokemonItemViewController {
        let loadingAdapter = PresentationAdapter(loader: loader)
        let viewModel = PokemonListPresenter.map(
            item: item,
            colorMapping: UIColor.fromHex
        )
        let controller = ListPokemonItemViewController(
            viewModel: viewModel,
            onImageRequest: loadingAdapter.load,
            onCancelRequest: loadingAdapter.cancel,
            onSelection: onSelection
        )
        loadingAdapter.presenter = .init(
            view: WeakProxy(controller),
            errorView: WeakProxy(controller),
            loadingView: WeakProxy(controller),
            mapping: UIImage.tryFrom
        )
        return controller
    }
}
