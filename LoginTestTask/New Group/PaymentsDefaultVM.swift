//
//  PaymentsViewModel.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 18.10.2021.
//

import Foundation

protocol PaymentsVM {
    var payments: [Payment] { set get }
    var onFetchPaymentSucceed: (() -> Void)? { set get }
    var onFetchPaymentFailure: ((Error) -> Void)? { set get }
    func getPayments()
}

final class PaymentsDefaultVM: PaymentsVM {
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService, token: String) {
        self.networkService = networkService
        self.token = token
    }
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var token: String?
    var payments: [Payment] = []
    var onFetchPaymentSucceed: (() -> Void)?
    var onFetchPaymentFailure: ((Error) -> Void)?

    func getPayments() {
        var request = testGet()
        request.token = token ?? ""
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let payments):
                self?.payments = payments.response
                self?.onFetchPaymentSucceed?()
            case .failure(let error):
                self?.onFetchPaymentFailure?(error)
            }
        }
    }
}
