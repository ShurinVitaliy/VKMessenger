//
//  CustomIL.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/30/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

//TODO: Общий коментарий по тому как нужно было реализвать отпишу здесь. Напишу на русском чтобы точно было понятно :) Во первых мы с тобой говорили про принцип единой ответсвенности (Single responsibility principle) в котором говорится что каждый класс должен отвечать только за один вид деятельности. В нашем случае у нас получается три таких класса: 1 кеш (он умеет кешировать объект и доставать объект из кеша), 2 это загрузчик(он умеет загружать картинку по URL) и 3 это менеджер (он умеет работать с кешем и загрузчиком. Притом он работает с абстрактынм кешем и загрузчиком (по пртоколу) в последствии ты можешь написать кеш на основе базы данных и при этом логика менеджера не поменяется ты просто передашь ему другой тип кеша.) Так вот у менеджера есть метод загрузить картинку по урлу и два свойства кеш и загрузчик. В методе загрузки должны быть следующая логика: ты смотришь картинку в кеше если ее там нет то грузишь ее с помощью загрузчика и складываешь в кеш и возварщаешь, если картинка есть в кеше то возвращаешь ее сразу и не нужно ничего грузить из сети.

class CustomImageLoade{
    //TODO: Are you sure that documents directory is the right place to store cached images? What other directories do we have? WHat is the difference between them? Think about this and we will discuss this once I'll be back from a sick leave.
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //TODO: Why image loader is working with Friend? I think we should use URL. Think and explain me why URL is better.
    func getImage(friend: Friend ,loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) {
        let url = URL(string: friend.photo_50!)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let imageView = UIImage(data: data!)
                loadCompleteWithResult(imageView ?? #imageLiteral(resourceName: "defaultImage.png"))
            }
        }.resume()
    }
    
    //TODO: This should be a private API
    func loadCacheImage(nameOfImage: String) -> UIImage? {
        let filePath = documentsURL.appendingPathComponent("\(nameOfImage).jpg").path
        if FileManager.default.fileExists(atPath: filePath) {
            print(filePath)
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }
    
    //TODO: This should be a private api
    func uploadCacheImage(image: UIImage, nameOfImage: String) {
        do {
            let fileURL = documentsURL.appendingPathComponent("\(nameOfImage).jpg")
            print(fileURL)
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("error")
        }
    }
    
    func deleteCacheImage() {
        let fileManager = FileManager.default
        guard let filePaths = try? fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
}
