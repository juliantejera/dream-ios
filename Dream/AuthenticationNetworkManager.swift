//
//  AuthenticationNetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct AuthenticationNetworkManager: NetworkManager {
    let client: NetworkClient
    let relativePath: String

    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "auth"
    }
    
    func register(user: AccountRegistrationViewModel, callback: @escaping (NetworkClientResult<Data>) -> Void) {
        let serializer = AccountRegistrationViewModelSerializer()
        let parameters: [String: Any] = serializer.serialize(from: user)
        client.request(method: .post, path: path, parameters: parameters, httpBody: nil) { (result) in
            callback(result)
        }
    }
    
    func signIn(user: SignInViewModel, callback: @escaping (NetworkClientResult<CurrentUser>) -> Void) {
        let serializer = SignInViewModelSerializer()
        let parameters = serializer.serialize(from: user)
        let signInPath = "\(path)/sign_in"
        
        client.request(method: .post, path: signInPath, parameters: parameters, httpBody: nil) { (result: NetworkClientResult<SignInResponseContainer>) in
            switch result {
            case .success(let container):
                callback(.success(container.user))
            case .failure(let errors):
                callback(.failure(errors))
            }
        }
    }

    func forgotPassword(email: String, callback: @escaping (NetworkClientResult<ForgotPasswordModel>) -> Void) {
        let parameters = ["email": email, "redirect_url": "dream://"]
        let forgotPasswordPath = "\(path)/password"
        client.request(method: .post, path: forgotPasswordPath, parameters: parameters, httpBody: nil) { (result: NetworkClientResult<ForgotPasswordModel>) in
            callback(result)
        }
    }

}
