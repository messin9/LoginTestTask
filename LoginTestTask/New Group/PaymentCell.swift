//
//  PaymentCell.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 18.10.2021.
//
import UIKit
import SnapKit

class PaymentCell: UITableViewCell {
    
    static let cellIdentifier = "PaymentCell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let amountLabel = UILabel()
    private let currencyLabel = UILabel()
    private let createdLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let labelsStackView = UIStackView()
    
    private func setupConstraints() {
        contentView.addSubview(labelsStackView)
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fill
        labelsStackView.spacing = 4
        labelsStackView.addArrangedSubview(amountLabel)
        labelsStackView.addArrangedSubview(currencyLabel)
        labelsStackView.addArrangedSubview(createdLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin)
            make.left.equalTo(contentView.snp.leftMargin)
        }
    }
    
    func bindViewWith(viewModel: PaymentCellVM) {
        let payment = viewModel.payment
        amountLabel.text = "Amount: \(payment.amount)"
        currencyLabel.text = "Currency: \(payment.currency ?? "")"
        createdLabel.text = "Created: \(payment.created)"
        descriptionLabel.text = "Description: \(payment.desc)"
    }
    
}
