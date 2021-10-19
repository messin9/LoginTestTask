//
//  PaymentsViewModel.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//

import Foundation

protocol loginCheckProtocol {
//    func authorize(login: String?, password: String?, completion: @escaping(Error?) -> Void)
    func authorize(login: String?, password: String?)
    var onLoginSucceed: (() -> Void)? { set get }
    var onLoginFailure: ((Error) -> Void)? { set get }
//    var token: [String : String]? { set get }
}

 final class LoginViewModel: loginCheckProtocol {
    
    private var networkService: NetworkService
    
     init(networkService: NetworkService) {
        self.networkService = networkService
    }
     
    var token: String?
    var onLoginSucceed: (() -> Void)?
    var onLoginFailure: ((Error) -> Void)?
     
     func getViewModel() -> PaymentsDefaultVM {
         return PaymentsDefaultVM(networkService: DefaultNetworkService(), token: self.token ?? "")
     }
     
    func authorize(login: String?, password: String?) {
        var request = testPost()
        request.login = login
        request.password = password
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.token = data.response.token
                self?.onLoginSucceed?()
            case .failure(let error):
                print(error)
                self?.onLoginFailure?(error)
            }
        }
    }    
}
