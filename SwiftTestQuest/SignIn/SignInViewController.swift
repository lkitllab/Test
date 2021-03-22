//
//  ViewController.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    var coordinator: SignInCoordinator?
    
    var model: SignInViewModel? {
        didSet { bindModel()}
    }
    
    private let loginTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    private let passwordTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.isSecureTextEntry = true
        textFiled.borderStyle = .roundedRect
        return textFiled
    }()
    
    private let loginLabel: UILabel = {
        let textFiled = UILabel()
        textFiled.text = "Sign In"
        return textFiled
    }()
    
    private let passwordLabel: UILabel = {
        let textFiled = UILabel()
        textFiled.text = "Password"
        return textFiled
    }()
    
    private let signInButton: UIButton  = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        constructView()
    }

    private func bindModel() {
        
        guard let model = model else {return}
        
        signInButton.rx.tap.asObservable()
            .bind(to: model.input.signInDidTap)
            .disposed(by: bag)
        
        loginTextField.rx.text.asObservable()
            .compactMap{$0}
            .bind(to: model.input.login)
            .disposed(by: bag)
        
        passwordTextField.rx.text
            .compactMap{$0}
            .bind(to: model.input.password)
            .disposed(by: bag)
        
        model.output.signInErrorObservable
            .bind(onNext: {[weak self] in self?.alert(message: $0)})
            .disposed(by: bag)
        
        model.output.signInResultObservable
            .bind(onNext: {[weak self] in self?.coordinator?.login()})
            .disposed(by: bag)
    }
    
    private func alert(message: String = "Something goes wrong!", title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
      }

    private func constructView() {

        func verticalContainer(_ views: [UIView]) -> UIStackView {
            let container = UIStackView(arrangedSubviews: views)
            container.spacing = 4
            container.axis = .vertical
            return container
        }

        let labels = verticalContainer([loginLabel, passwordLabel])
        let fields = verticalContainer([loginTextField, passwordTextField])

        let container = UIStackView(arrangedSubviews: [labels, fields])
        container.translatesAutoresizingMaskIntoConstraints = false
        container.distribution = .fillProportionally
        container.axis = .horizontal

        signInButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)
        view.addSubview(signInButton)

        NSLayoutConstraint.activate([
            fields.widthAnchor.constraint(equalToConstant: 220),
            container.widthAnchor.constraint(equalToConstant: 300),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 50)
        ])
    }
}
