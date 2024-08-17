//
//  MainViewModel.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//en

import UIKit

class MainViewModel: ObservableObject {
    @Published var albumsArr: [String] = []
    @Published var photoArr: [String] = []
    @Published var photoImagesArr: [UIImage] = []
    @Published var token = ""
    @Published var error = ""
    private var cachedImages =  NSCache<NSString, UIImage>()
    func getToken() async {
        do {
            let data = try KeychainManager.fetch(service: "mobileup", account: "useless")
            if let data = data {
                token = String(decoding: data, as: UTF8.self)
            }
        } catch {
           print("no token", error)
        }
    }
    
    func checkToken() async {
        var urlComponents = URLComponents(string: "https://api.vk.com/method/account.getProfileInfo")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.199")
        ]
        guard let url = urlComponents?.url else {fatalError("errr")}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let res = try JSONDecoder().decode(InfoModel.self, from: data)
            print(res)
        } catch {
            print(error)
        }
    }
    
    func getAlbums() async{
        var array: [String] = []
        do {
            var urlComponents = URLComponents(string: "https://api.vk.com/method/photos.getAlbums")
            urlComponents?.queryItems = [
                URLQueryItem(name: "owner_id", value: "-128666765"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.199")
            ]
            guard let url = urlComponents?.url else {fatalError("no url")}
            let (data, _) = try await URLSession.shared.data(from: url)
            let res = try JSONDecoder().decode(AlbumsModel.self, from: data)
            for i in res.response.items {
                print(i.id)
                array.append("\(i.id)")
                
            }
            self.albumsArr = array
        } catch {
            print("getAlbums",error)
        }
    }
    
    func getPhotosFromAlbumby(id albumId: String) async -> [PhotosItem] {
        do {
            var urlComponents = URLComponents(string: "https://api.vk.com/method/photos.get")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "owner_id", value: "-128666765"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.199"),
                URLQueryItem(name: "album_id", value: albumId)
            ]
            
            guard let url = urlComponents?.url else {fatalError("no url")}
            let (data, _) = try await URLSession.shared.data(from: url)
            let res = try JSONDecoder().decode(PhotosModel.self, from: data)
            
            return res.response.items
            
        } catch {
            print("getAlbums",error)
        }
        return []
    }
    
    func getAllPhotos() async {
        var tempArr: [String] = []
        for i in albumsArr {
            var arrOfPhotos = await getPhotosFromAlbumby(id: i)
            for photo in arrOfPhotos {
                tempArr.append(photo.orig_photo.url)
            }
        }
        photoArr = tempArr
        
    }
    
    func getPhoto(url: String) async -> UIImage{
        guard let url = URL(string: url) else {fatalError("error in image")}
        var image: UIImage?
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
             image = UIImage(data: data)
        } catch {
            print("getPhoto", error)
        }
        return image!
    }
    
    func prefetchPhotos() async {
        
    }
    
}
