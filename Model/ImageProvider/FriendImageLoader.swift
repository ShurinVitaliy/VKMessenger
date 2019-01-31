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

protocol FriendImageLoader {
    func getImage(photoURL: String, loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) -> Void
}

class CustomImageLoader: FriendImageLoader{
    func getImage(photoURL: String ,loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) {
        let url = URL(string: photoURL)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let imageView = UIImage(data: data!)
                loadCompleteWithResult(imageView ?? #imageLiteral(resourceName: "defaultImage.png"))
            }
        }.resume()
    }
}
/*
DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()+5, execute: {
    loadCompleteWithResult(imageView ?? #imageLiteral(resourceName: "defaultImage.png"))
})
*/
