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
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .fill
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = 0
        labelsStackView.addArrangedSubview(amountLabel)
        labelsStackView.addArrangedSubview(currencyLabel)
        labelsStackView.addArrangedSubview(createdLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.topMargin)
            make.left.equalTo(contentView.snp.leftMargin)
            make.right.equalTo(contentView.snp.rightMargin)
            make.bottom.equalTo(contentView.snp.bottomMargin)
        }
    }
    func bindViewWith(viewModel: PaymentCellVM) {
        let payment = viewModel.payment
        let trimmed = "\(payment.amount)"
        let removeCharacter: Set<Character> = ["(",")"]
        var amountText = trimmed.trimmingCharacters(in: .letters)
        amountText.removeAll(where: {removeCharacter.contains($0) })
        amountText = amountText.replacingOccurrences(of: "\"", with: "", options: .regularExpression, range: nil)
        amountLabel.text = "Amount: \(amountText)"
        currencyLabel.text = "Currency: \(payment.currency ?? "")"
        createdLabel.text = "Created: \(payment.created)"
        descriptionLabel.text = "Description: \(payment.desc)"
    }
}
