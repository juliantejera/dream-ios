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
    
    func register(user: AccountRegistrationViewModel, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        let serializer = AccountRegistrationViewModelSerializer()
        let parameters: [String: Any] = serializer.serialize(from: user)
        client.request(method: .post, path: path, parameters: parameters) { (result) in
            callback(result)
        }
    }
    
    func signIn(user: SignInViewModel, callback: @escaping (NetworkClientResult<CurrentUser>) -> Void) {
        let serializer = SignInViewModelSerializer()
        let parameters = serializer.serialize(from: user)
        let signInPath = "\(path)/sign_in"
        client.request(method: .post, path: signInPath, parameters: parameters) { (result) in
            switch result {
            case .success(let response):
                callback(self.parseSignIn(response: response))
            case .failure(let errors):
                callback(.failure(errors))
            }
        }
    }
    
    private func parseSignIn(response: Any) -> NetworkClientResult<CurrentUser> {
        let parser = CurrentUserParser()
        if let dictionary = response as? [AnyHashable: Any], let dataDictionary = dictionary["data"] as? [AnyHashable: Any], let currentUser = parser.parse(from: dataDictionary) {
            return .success(currentUser)
        }
        
        return .failure([DreamNetworkClientError.unparsableModel.localizedDescription])
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
