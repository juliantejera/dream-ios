//
//  AuthenticationNetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct AuthenticationNetworkManager {
    private let client: NetworkClient
    private let relativePath: String
    private var path: String {
        return "\(client.basePath)\(relativePath)"
    }
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "auth"
    }
    
    func register(user: AccountRegistrationViewModel, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        let serializer = AccountRegistrationViewModelSerializer()
        let parameters: [String: Any] = serializer.serialize(from: user)
        client.request(method: .post, path: path, parameters: parameters) { (result) in
            callback(result)
        }
    }
    
    func signIn(user: SignInViewModel, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        let serializer = SignInViewModelSerializer()
        let parameters = serializer.serialize(from: user)
        let signInPath = "\(path)/sign_in"
        client.request(method: .post, path: signInPath, parameters: parameters) { (result) in
            callback(result)
        }
    }
    
    func forgotPassword(email: String, callback: @escaping (NetworkClientResult<String>) -> Void) {
        let parameters = ["email": email, "redirect_url": "dream://"]
        let forgotPasswordPath = "\(path)/password"
        client.request(method: .post, path: forgotPasswordPath, parameters: parameters) { (result) in
            switch result {
            case .success(let response):
                callback(self.parseForgotPassword(response: response))
            case .failure(let errors):
                callback(.failure(errors))
            }
        }
    }
    
    private func parseForgotPassword(response: Any) -> NetworkClientResult<String> {
        if let dictionary = response as? [AnyHashable: Any], let message = ForgotPasswordParser().parse(from: dictionary) {
            return .success(message)
        }
        
        return .failure([DreamNetworkClientError.unparsableModel.localizedDescription])
    }
}
