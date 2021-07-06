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
    var viewModel: ViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    private let retryTapping = PassthroughSubject<Void, Never>()
    private let refreshEvent = PassthroughSubject<Void, Never>()
    private var currentState: CountriesState
    lazy var countriesView = view as! CountriesView
    weak var tableView: UITableView?
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.currentState = .loading
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        view = CountriesView()
        tableView = countriesView.tableView
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        countriesView.failureView.retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
}

extension CountriesViewController {
    func bind(viewModel: ViewModel) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = CountriesViewModelInput(
            lifeCycleEvent: lifecycleEvent.eraseToAnyPublisher(),
            retryTapEvent: retryTapping.eraseToAnyPublisher(),
            refreshEvent: refreshEvent.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.sink { state in
            self.render(state)
        }
        .store(in: &subscriptions)
    }
    
    func render(_ state: CountriesState) {
        switch state {
        case let .failure(error):
            countriesView.hideLoadingView()
            countriesView.showFailureView(error)
        case .ready:
            countriesView.hideLoadingView()
            countriesView.hideFailureView()
            refreshControl.endRefreshing()
            tableView?.reloadData()
        case .loading:
            countriesView.hideFailureView()
            countriesView.showLoadingView()
        }
    }
}

private extension CountriesViewController {
    @objc func refresh() {
        refreshEvent.send()
    }
    
    @objc func retryButtonTapped() {
        retryTapping.send()
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath)
        guard let countryCell = cell as? CountryCell else {
            return cell
        }
        let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
        countryCell.setViewModel(cellViewModel)
        countryCell.colorizeBackground(byRow: indexPath.row)
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellViewModel = viewModel.cellViewModel(for: indexPath.row)
        viewModel.doneSignal.send(cellViewModel)
    }
}
