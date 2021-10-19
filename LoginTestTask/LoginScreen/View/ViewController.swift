//
//  ViewController.swift
//  LoginTestTask
//
//  Created by Алексей Мотин on 17.10.2021.
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let logo = UIImageView()
    let loginTF = UITextField()
    let passwordTF = UITextField()
    private let loginButton = UIButton()
    private let textFieldsStackView = UIStackView()
    private var viewModel: LoginViewModel
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavBar()
        setupLogo()
        setupTextFields()
        setupLoginButton()
        setupTextFieldsStackView()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Login"
        navigationItem.backButtonTitle = "Log out"

    }
    
    private func setupTextFields() {
        loginTF.autocorrectionType = .no
        loginTF.autocapitalizationType = .none
        loginTF.spellCheckingType = .no
        passwordTF.autocorrectionType = .no
        passwordTF.autocapitalizationType = .none
        passwordTF.spellCheckingType = .no
        loginTF.placeholder = "Enter your login"
        passwordTF.placeholder = "Enter you password"
        passwordTF.isSecureTextEntry = true
        loginTF.borderStyle = .roundedRect
        passwordTF.borderStyle = .roundedRect
        loginTF.layer.cornerRadius = 10
        passwordTF.layer.cornerRadius = 10
        loginTF.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 16)
            make.height.equalTo(30)
        }
        passwordTF.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width - 16)
            make.height.equalTo(30)
        }
    }
    
    private func setupTextFieldsStackView() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .fill
        textFieldsStackView.distribution = .fill
        textFieldsStackView.spacing = 8
        loginTF.backgroundColor = .white
        passwordTF.backgroundColor = .white
        textFieldsStackView.addArrangedSubview(loginTF)
        textFieldsStackView.addArrangedSubview(passwordTF)
        textFieldsStackView.addArrangedSubview(loginButton)
        textFieldsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc private func loginAction() {
        viewModel.authorize(login: loginTF.text, password: passwordTF.text)
        bindViewModelEvent()
    }
    
    private func bindViewModelEvent() {
        viewModel.onLoginSucceed = { [weak self] in
//            let viewModel = self?.viewModel.getViewModel()
//            let vc = PaymentsVC(viewModel: viewModel!)
            DispatchQueue.main.async {
                self?.showPayments()
//                vc.viewModel.getPayments()
//                vc.configureTableView()
                
            }
        }
        viewModel.onLoginFailure = { error in
            print("alert showed")
            DispatchQueue.main.async {
                self.setupLoginErrorAlert()
            }
        }
    }
    
    private func showPayments() {
        let viewModel = self.viewModel.getViewModel()
        let vc = PaymentsVC(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupLoginErrorAlert() {
        let alert = UIAlertController(title: "Login error", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setupLogo() {
        view.addSubview(logo)
        logo.layer.masksToBounds = true
        logo.layer.cornerRadius = 10
        logo.image = UIImage(named: "logo")
        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.topMargin).inset(40)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}
