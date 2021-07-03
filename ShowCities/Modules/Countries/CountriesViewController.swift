//
//  CountriesViewController.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import Combine
import UIKit

class CountriesViewController: ObservedViewController, ViewModelBindable {
    typealias ViewModel = CountriesViewModelType
    var viewModel: ViewModel {
        didSet {
            bindViewModel()
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    lazy var countriesView = view as! CountriesView
    
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
        
        view = CountriesView()
    }
}

extension CountriesViewController {
    func bind(viewModel: ViewModel) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = CountriesViewModelInput()
        
        let output = viewModel.transform(input: input)
        
        output.sink { state in
            self.render(state)
        }
        .store(in: &subscriptions)
    }
    
    func render(_ state: CountriesState) {
        switch state {
        case .idle:
            view.backgroundColor = .gray
        }
    }
}
