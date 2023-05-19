//
//  CardCell.swift
//  MobintTestTask
//
//  Created by ramil on 10.05.2023.
//

import UIKit

protocol CardCellDelegate: AnyObject {
    func didTappedButton(_ buttonType: CardCell.ButtonType)
}

final class CardCell: UITableViewCell {
    //MARK: - Properties
    weak var delegate: CardCellDelegate?
    
    //MARK: - Private properties
    private let roundedContainerView = UIView()
    private let titleView = TitleView()
    private let loyaltyView = LoyaltyView()
    private let actionView = ActionView()
    
    private var firstSeporator = UIView()
    private var secondSeporator = UIView()
    
    private lazy var stackView: UIStackView = {
        
        let subviews = [
            titleView,
            firstSeporator,
            loyaltyView,
            secondSeporator,
            actionView
        ]
        
        var stack = UIStackView(arrangedSubviews: subviews)
        stack.spacing = Layout.yellowSpacing
        stack.setCustomSpacing(Layout.redSpacing, after: firstSeporator)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSeporators()
        setupSubviews()
        setupRoundedView()
        handleButtonAction()
        contentView.backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with company: CompanyCard) {
        let companyName = company.mobileAppDashboard.companyName
        titleView.setCompanyName(companyName)
        loyaltyView.configure(with: company)
    }
    
    func setCompanyLogo(_ image: UIImage) {
        titleView.setCompanyLogo(image)
    }
    
    //MARK: - Private methods
    private func handleButtonAction() {
        actionView.onButtonTap = { [weak self] button in
            guard let buttonType = ButtonType(rawValue: button.tag) else { return
            }
            self?.delegate?.didTappedButton(buttonType)
        }
    }
    
    private func setupRoundedView() {
        roundedContainerView.translatesAutoresizingMaskIntoConstraints = false
        roundedContainerView.backgroundColor = .systemBlue
        roundedContainerView.layer.cornerRadius = 25
        roundedContainerView.backgroundColor = .white
    }
    
    private func setupSeporators() {
        firstSeporator.backgroundColor = .gray
        secondSeporator.backgroundColor = .gray
    }
    
    private func setupSubviews() {
        contentView.addSubview(roundedContainerView)
        roundedContainerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            roundedContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.redSpacing),
            roundedContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.redSpacing),
            roundedContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.redSpacing),
            roundedContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.redSpacing / 2),
            
            stackView.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: Layout.redSpacing),
            stackView.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: Layout.redSpacing),
            stackView.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -Layout.redSpacing),
            stackView.bottomAnchor.constraint(equalTo: roundedContainerView.bottomAnchor, constant: -Layout.redSpacing),
            
            firstSeporator.heightAnchor.constraint(equalToConstant: 0.5),
            secondSeporator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

//MARK: - ButtonType
extension CardCell {
    public enum ButtonType: Int {
        case sight = 1, trash, more
        
        var name: String {
            switch self {
            case .sight: return "sight"
            case .trash: return "trash"
            case .more: return "more"
            }
        }
    }
}
