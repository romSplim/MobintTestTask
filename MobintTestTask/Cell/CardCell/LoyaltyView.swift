//
//  LoyaltyView.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

final class LoyaltyView: UIStackView {
    
    //MARK: - Properties
    private(set) var points: Int = 0 {
        didSet {
            updateWordEnding(for: &pointsLabel.text, point: points)
        }
    }
    
    private var pointsAmountLabel: UILabel = {
        var label = UILabel()
        label.font = Font.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pointsLabel: UILabel = {
        var label = UILabel()
        label.font = Font.subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cashBackLabel: UILabel = {
        var label = UILabel()
        label.text = "Кешбэк"
        label.font = Font.regular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cashBackAmountLabel: UILabel = {
        var label = UILabel()
        label.text = "100%"
        label.font = Font.subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loyaltyLevelLabel: UILabel = {
        var label = UILabel()
        label.text = "Уровень"
        label.font = Font.regular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loyaltyLabel: UILabel = {
        var label = UILabel()
        label.font = Font.subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalCashStack: UIStackView = {
        let subviews = [cashBackLabel, cashBackAmountLabel]
        var stack = UIStackView(arrangedSubviews: subviews)
        stack.spacing = Layout.yellowSpacing
        stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stack.axis = .vertical
        return stack
    }()
    
    lazy var verticalLoyaltyStack: UIStackView = {
        let subviews = [loyaltyLevelLabel, loyaltyLabel]
        var stack = UIStackView(arrangedSubviews: subviews)
        stack.spacing = Layout.yellowSpacing
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.axis = .vertical
        return stack
    }()
    
    lazy var pointsInfoStack: UIStackView = {
        let subviews = [pointsAmountLabel, pointsLabel]
        var stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.alignment = .lastBaseline
        stack.setCustomSpacing(Layout.yellowSpacing, after: pointsAmountLabel)
        return stack
    }()
    
    lazy var cashBackInfoStack: UIStackView = {
        let subviews = [verticalCashStack, verticalLoyaltyStack]
        var stack = UIStackView(arrangedSubviews: subviews)
        stack.setCustomSpacing(Layout.blueSpacing, after: verticalCashStack)
        stack.axis = .horizontal
        return stack
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        spacing = Layout.redSpacing
        axis = .vertical
        alignment = .leading
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with company: CompanyCard) {
        let loyaltyModel = company.customerMarkParameters.loyaltyLevel
        points = company.customerMarkParameters.mark
        pointsAmountLabel.text = "\(points)"
        cashBackAmountLabel.text = "\(loyaltyModel.cashToMark) %"
        loyaltyLabel.text = loyaltyModel.name
    }
    
    //MARK: - Private methods
    private func updateWordEnding(for word: inout String?, point: Int) {
        word = .getRightWordEnding(for: point) ?? ""
    }
    
    private func setupSubviews() {
        addArrangedSubview(pointsInfoStack)
        addArrangedSubview(cashBackInfoStack)
    }
}
