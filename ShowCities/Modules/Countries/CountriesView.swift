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
    
    private lazy var tableView = createTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(tableView)
    }
    
    func layoutViews() {
        tableView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(Constants.smallOffset)
            $0.right.bottom.equalToSuperview().inset(Constants.smallOffset)
        }
    }
        
}

private extension CountriesView {
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
