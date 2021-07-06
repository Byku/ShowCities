//
//  CountriesCell.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import UIKit
import SnapKit

private extension CountryCell {
    // MARK: Constants

    enum Constants {
        static let smallOffset: CGFloat = 8
        static let largeOffset: CGFloat = 16
        static let textColor: UIColor = .black
        
        static let cornerRadius: CGFloat = 4
    }
}

final class CountryCell: UITableViewCell {
    static let identifier = String(describing: CountryCell.self)

    var viewModel: CountryViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    // MARK: View Hierarchy

    private lazy var titleLabel: UILabel = createTitleLabel()

    // MARK: LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initState()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CountryCell {
    // MARK: Private

    func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.countryName
        titleLabel.sizeToFit()
    }

    func initState() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner]
            
        backgroundColor = .clear

        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.smallOffset)
            $0.left.equalToSuperview().offset(Constants.largeOffset)
            $0.right.equalToSuperview().inset(Constants.largeOffset)
            $0.bottom.equalToSuperview().inset(Constants.smallOffset)
        }
    }
}

private extension CountryCell {
    // MARK: View factory methods
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = Constants.textColor
        label.lineBreakMode = .byTruncatingTail
        return label
    }
}

extension CountryCell {
    // MARK: public method

    func setViewModel(_ viewModel: CountryViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func colorizeBackground(byRow line: Int) {
        contentView.backgroundColor = line % 2 == 1 ? .lightGray : .white
    }
}
