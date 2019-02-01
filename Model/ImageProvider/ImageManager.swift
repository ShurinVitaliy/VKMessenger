//
//  ImageManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/31/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

//TODO: Общий коментарий по тому как нужно было реализвать отпишу здесь. Напишу на русском чтобы точно было понятно :) Во первых мы с тобой говорили про принцип единой ответсвенности (Single responsibility principle) в котором говорится что каждый класс должен отвечать только за один вид деятельности. В нашем случае у нас получается три таких класса: 1 кеш (он умеет кешировать объект и доставать объект из кеша), 2 это загрузчик(он умеет загружать картинку по URL) и 3 это менеджер (он умеет работать с кешем и загрузчиком. Притом он работает с абстрактынм кешем и загрузчиком (по пртоколу) в последствии ты можешь написать кеш на основе базы данных и при этом логика менеджера не поменяется ты просто передашь ему другой тип кеша.) Так вот у менеджера есть метод загрузить картинку по урлу и два свойства кеш и загрузчик. В методе загрузки должны быть следующая логика: ты смотришь картинку в кеше если ее там нет то грузишь ее с помощью загрузчика и складываешь в кеш и возварщаешь, если картинка есть в кеше то возвращаешь ее сразу и не нужно ничего грузить из сети.

class ImageManager {
    private let imageLoader: FriendImageLoader = CustomImageLoader()
    private let imageCache: FriendImageCache = CustomImageCache()
    
    func getImage(imageURL: String, complete: @escaping(_ image: UIImage)-> Void) {
        let nameOfImage = URL(string: imageURL)?.lastPathComponent
        
        if let image = imageCache.loadCacheImage(nameOfImage: nameOfImage!) {
            DispatchQueue.global().async {
                complete(image)
            }
        } else {
            self.imageLoader.getImage(photoURL: imageURL, loadCompleteWithResult: {[weak self] (image) in
                self?.imageCache.saveCacheImage(image: image, nameOfImage: nameOfImage!)
                complete(image)
            })
        }
    }
    
    func clearCache() {
        imageCache.deleteCacheImage()
    }
}
