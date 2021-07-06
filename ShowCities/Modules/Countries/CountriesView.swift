//
//  CountriesView.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import UIKit
import SnapKit

private extension CountriesView {
    // MARK: Constants

    enum Constants {
        static let smallOffset: CGFloat = 16
    }
}

class CountriesView: UIView {
    
    lazy var tableView = createTableView()
    lazy var failureView = FailureView()
    lazy var loadingView = LoadingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        backgroundColor = .white
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(failureView)
        loadingView.isHidden = true
        failureView.isHidden = true
    }
    
    func layoutViews() {
        tableView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(Constants.smallOffset)
            $0.right.bottom.equalToSuperview().inset(Constants.smallOffset)
        }
        
        failureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
}

private extension CountriesView {
    // MARK: View factory methods
    
    func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
        
        return tableView
    }
}

extension CountriesView {
    // MARK: public methods
    
    func showFailureView(_ error: Error) {
        failureView.setError(error.localizedDescription)
        failureView.isHidden = false
    }
    
    func hideFailureView() {
        failureView.isHidden = true
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }
}
