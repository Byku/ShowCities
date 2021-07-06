//
//  FailureView.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import UIKit

private extension LoadingView {
    // MARK: Constants

    enum Constants {
        static let titleText: String = "Красивая анимация загрузки..."
        
        static let bgColor: UIColor = .white
        static let textColor: UIColor = .black
        
        static let largeOffset = 80
        static let labelHeight = 64
    }
}

class LoadingView: UIView {
    lazy var titleLabel = createTitleLabel()
    
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
    }
    
    func layoutViews() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.largeOffset)
            $0.trailing.equalToSuperview().inset(Constants.largeOffset)
            $0.height.equalTo(Constants.labelHeight)
        }
    }
}

private extension LoadingView {
    // MARK: View factory methods
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = Constants.titleText
        label.textColor = Constants.textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
