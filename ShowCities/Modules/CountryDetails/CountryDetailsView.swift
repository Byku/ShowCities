//
//  CountryDetailsView.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 03.07.2021.
//

import UIKit

private extension CountryDetailsView {
    // MARK: Constants

    enum Constants {
        static let titleText: String = "Страна: "
        static let subtitleText: String = "Столица: "
        
        static let bgColor: UIColor = .white
        static let textColor: UIColor = .black
        
        static let largeOffset = 80
        static let mediumOffset = 24
        static let labelHeight = 32
    }
}

class CountryDetailsView: UIView {
    lazy var titleLabel = createTitleLabel()
    lazy var subTitleLable = createSubtitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        backgroundColor = Constants.bgColor
        
        addSubview(titleLabel)
        addSubview(subTitleLable)
    }
    
    func layoutViews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.largeOffset)
            $0.leading.equalToSuperview().offset(Constants.mediumOffset)
            $0.trailing.equalToSuperview().inset(Constants.mediumOffset)
            $0.height.equalTo(Constants.labelHeight)
        }
        
        subTitleLable.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.mediumOffset)
            $0.left.right.equalTo(titleLabel)
        }
    }
}

private extension CountryDetailsView {
    // MARK: View factory methods
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = Constants.textColor
        label.text = Constants.titleText
        label.numberOfLines = 1
        return label
    }
    
    func createSubtitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = Constants.textColor
        label.text = Constants.subtitleText
        label.numberOfLines = 1
        return label
    }
}
