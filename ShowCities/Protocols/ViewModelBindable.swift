//
//  ViewModelBindable.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Foundation

protocol ViewModelBindable {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
    func bind(viewModel: ViewModel)
}

extension ViewModelBindable {
    func bindViewModel() {
        bind(viewModel: viewModel)
    }
}
