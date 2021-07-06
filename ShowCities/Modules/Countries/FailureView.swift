//
//  FailureView.swift
//  ShowCities
//
//  Created by Дмитрий Иванов on 05.07.2021.
//

import UIKit

private extension FailureView {
    // MARK: Constants

    enum Constants {
        static let titleText: String = "Ой! Ошибка."
        static let subtitleText: String = "Неизвестная ошибка"
        static let buttonLabelText: String = "Повторить загрузку"
        
        static let buttonCornerRadius: CGFloat = 8
        static let buttonBgColor: UIColor = .lightGray
        static let buttonTextColor: UIColor = .darkGray
        static let bgColor: UIColor = .white
        
        static let largeOffset = 80
        static let mediumOffset = 24
        static let labelHeight = 32
        static let buttonHeight = 50
        static let buttonWidth = 150
    }
}

class FailureView: UIView {
    lazy var titleLabel = createTitleLabel()
    lazy var subTitleLable = createSubtitleLabel()
    lazy var retryButton = createButton()
    
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
        addSubview(retryButton)
    }
    
    func layoutViews() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.largeOffset)
            $0.trailing.equalToSuperview().inset(Constants.largeOffset)
            $0.height.equalTo(Constants.labelHeight)
        }
        
        subTitleLable.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.mediumOffset)
            $0.left.right.equalTo(titleLabel)
        }
        
        retryButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLable.snp.bottom).offset(Constants.mediumOffset)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.buttonHeight)
            $0.width.equalTo(Constants.buttonWidth)
        }
    }
}

private extension FailureView {
    // MARK: View factory methods
    
    func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = Constants.titleText
        label.numberOfLines = 1
        return label
    }
    
    func createSubtitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }
    
    func createButton() -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(Constants.buttonLabelText, for: .normal)
        button.backgroundColor = Constants.buttonBgColor
        button.setTitleColor(Constants.buttonTextColor, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        return button
    }
}

extension FailureView {
    func setError(_ errorText: String?) {
        subTitleLable.text = errorText ?? Constants.subtitleText
    }
}
