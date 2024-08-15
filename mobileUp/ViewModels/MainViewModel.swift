//
//  MainViewModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//en

import Foundation

class MainViewModel {
    func getFullInfo() async {
        var token = ""
        print("111")
        do {
            let data = try KeychainManager.fetch(service: "mobileup", account: "useless")
            if let data = data {
                token = String(decoding: data, as: UTF8.self)
                print("hehe")
            }
            print("token", token)
        } catch {
            print("error in fetcing token")
        }
        var urlComponents = URLComponents(string: "https://api.vk.com/method/account.getProfileInfo")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.199")
        ]
        guard let url = urlComponents?.url else {fatalError("errr")}
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
//            print(response)
            let res = try JSONDecoder().decode(InfoModel.self, from: data)
            print(res)
        } catch {
            print(error)
        }
    }
}
