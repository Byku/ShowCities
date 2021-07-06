//
//  CountryDetailsViewController.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine
import UIKit

class CountryDetailsViewController: ObservedViewController, ViewModelBindable {
    typealias ViewModel = CountryDetailsViewModelType
    var viewModel: ViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    lazy var countryDetailsView = view as! CountryDetailsView
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        view = CountryDetailsView()
    }
}

extension CountryDetailsViewController {
    func bind(viewModel: ViewModel) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = CountryDetailsViewModelInput()
        let output = viewModel.transform(input: input)
        
        output.sink { state in
            self.render(state)
        }
        .store(in: &subscriptions)
    }
    
    func render(_ state: CountryDetailsState) {
        switch state {
        case .idle: break
        }
    }
}

extension CountryDetailsViewController {
    // MARK: a little bit of bad code
    // TODO: fix it
    
    func showCapitalCityName(with viewModel: CountryViewModelProtocol) {
        countryDetailsView.titleLabel.text = "Страна: \(viewModel.countryName)"
        countryDetailsView.subTitleLable.text = "Столица: \(viewModel.capitalCityName)"
    }
}
