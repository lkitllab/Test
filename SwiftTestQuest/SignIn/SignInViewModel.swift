//
//  LoginViewModel.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class SignInViewModel {
    
    struct Input {
        let login: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    
    struct Output {
        let signInResultObservable: Observable<Void>
        let signInErrorObservable: Observable<String>
    }
    
    let input: Input
    let output: Output
    
    private let provider: MoyaProvider<SignInService>
    
    private let loginSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let signInResultSubject = PublishSubject<Void>()
    private let signInErrorSubject = PublishSubject<String>()
    
    private var credentialsObservable: Observable<Credentials> {
        Observable.combineLatest(loginSubject.asObservable(), passwordSubject.asObservable()) {
            Credentials(login: $0, password: $1)
        }
    }
    
    private let bag = DisposeBag()
    
    init(provider: MoyaProvider<SignInService>) {
        
        self.provider = provider
        
        input = Input(login: loginSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        output = Output(signInResultObservable: signInResultSubject.asObservable(),
                        signInErrorObservable: signInErrorSubject.asObservable())
        
        signInDidTapSubject
            .withLatestFrom(credentialsObservable)
            .bind(onNext: {[weak self] in self?.signIn($0)})
            .disposed(by: bag)
        
    }
    
    private func signIn(_ credentials: Credentials) {
        guard !credentials.login.isEmpty && !credentials.password.isEmpty
        else {
            signInErrorSubject.onNext("Login and pass should have at least one symbol!")
            return
        }
        provider.request(.signIn(credentials), completion: { [weak self] result in
            switch result {
            case .success(_): self?.signInResultSubject.onNext(())
            case .failure(_): self?.signInErrorSubject.onNext("Failed to connect!")
            }
        })
    }

}
