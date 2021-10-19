//
//  PaymentsVC.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 18.10.2021.
//
import UIKit
import SnapKit

class PaymentsVC: UIViewController {
    
    let viewModel: PaymentsDefaultVM
    
    init(viewModel: PaymentsDefaultVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
        let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        configureTableView()
        viewModel.getPayments()
        bindViewModelEvent()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(PaymentCell.self, forCellReuseIdentifier: String(describing: PaymentCell.self))
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavbar() {
        navigationItem.title = "Payments"
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchPaymentSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onFetchPaymentFailure = { error in
            print(error)
        }
    }
}

extension PaymentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PaymentCell.self), for: indexPath) as? PaymentCell else {
            return .init()
        }
        let payment = viewModel.payments[indexPath.row]
        cell.bindViewWith(viewModel: PaymentCellVM(payment: payment))
        cell.isUserInteractionEnabled = false
        return cell
    }
}
