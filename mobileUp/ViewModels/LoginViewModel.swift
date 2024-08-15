//
//  LoginViewModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 15.08.24.
//

import Foundation

class LoginViewModel {
    func checkToken() async -> Bool{
        do {
            if let token = try KeychainManager.fetch(service: KeychainCreds.service, account: KeychainCreds.account) {
                var urlComponents = URLComponents(string: "https://api.vk.com/method/account.getProfileInfo")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "access_token", value: String(decoding: token, as: UTF8.self)),
                    URLQueryItem(name: "v", value: "5.199")
                ]
                guard let url = urlComponents?.url else {fatalError("errr")}
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let res = try JSONDecoder().decode(InfoModel.self, from: data)
                print("res", res)
                if res.response != nil {
                    print("Cool")
                    return true
                } else {
                    print("bad(")
                    do {
                        try KeychainManager.delete(service: KeychainCreds.service, account: KeychainCreds.account)
                    } catch {
                        print(error)
                    }
                }
                
            } else {
                print("Token was not found")
            }
        } catch {
            print(error)
        }
        return false
    }
}
