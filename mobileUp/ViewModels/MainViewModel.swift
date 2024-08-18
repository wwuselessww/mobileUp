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
    @Published var videoArr: [String] = []
    @Published var photoImagesArr: [UIImage] = []
    @Published var chosenCollection: ChosenCollection = .photo
    @Published var token = ""
    @Published var error = ""

    var cachedImages =  NSCache<NSString, UIImage>()
    func getToken() async {
        do {
            let data = try KeychainManager.fetch(service: "mobileup", account: "useless")
            if let data = data {
                token = String(decoding: data, as: UTF8.self)
                print(token)
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
                array.append("\(i.id)")
            }
            self.albumsArr = array
        } catch {
            print("getAlbums",error)
        }
    }
    
    func getPhotosFromAlbum(id albumId: String) async -> [PhotosItem] {
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
            var arrOfPhotos = await getPhotosFromAlbum(id: i)
            for photo in arrOfPhotos {
                tempArr.append(photo.orig_photo.url)
//                print("photo.orig_photo.url", photo.orig_photo.url)
//                print(" ")
            }
        }
        photoArr = tempArr
        
    }
    
    func getPhoto(urlString: String) async -> UIImage{
        if let imageFromCache = cachedImages.object(forKey: urlString as NSString) {
            return imageFromCache
        }
        guard let url = URL(string: urlString) else {fatalError("error in image")}
        var image: UIImage?
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            image = UIImage(data: data)
        } catch {
            print("getPhoto", error)
            return .placeholder
        }
        if let resImage = image {
            cachedImages.setObject(resImage, forKey: urlString as NSString)
            return resImage
        } else {
            return .placeholder
        }
            
        }
    
    func getVideos() async {
        var tempArr: [String] = []
        do {
            var urlComponents = URLComponents(string: "https://api.vk.com/method/video.get")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "owner_id", value: "-128666765"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.199"),
            ]
            
            guard let url = urlComponents?.url else {fatalError("no url")}
            let (data, _) = try await URLSession.shared.data(from: url)
            let res = try JSONDecoder().decode(VideoModel.self, from: data)
            
            for item in res.response.items {
                
                tempArr.append(item.image.last?.url ?? "")
            }
            videoArr = tempArr
            print(videoArr)
        } catch {
            print("getVideos",error)
        }
    }
    
    }
