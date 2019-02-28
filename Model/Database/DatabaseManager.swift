//
//  DatabaseManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/21/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol Friend {
    var first_name: String {get set}
    var id: Int {get set}
    var last_name: String {get set}
    var online: Int {get set}
    var photo_100: String {get set}
}

class FriendDataManager {
    let realm = try! Realm()
    
    func getFriends() -> [Friend] {
        let friendsDatabase = Array(realm.objects(FriendDatabase.self))
        return friendsDatabase
    }
    
    func setFriends(friends: [Friend]) {
        var friendsDatabase: [FriendDatabase] = []
        try! realm.write {
            realm.deleteAll()
        }
        
        for friend in friends {
            let currentFriend = FriendDatabase(first_name: friend.first_name, id: friend.id, last_name: friend.last_name, online: friend.online, photo_100: friend.photo_100)
            friendsDatabase.append(currentFriend)
        }

        try! realm.write {
            realm.add(friendsDatabase)
        }
    }
}

class FriendDatabase: Object, Friend {
    @objc dynamic var first_name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var last_name: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var photo_100: String = ""
    
    convenience init(first_name: String, id: Int, last_name: String,  online: Int, photo_100: String) {
        self.init()
        self.first_name = first_name
        self.id = id
        self.last_name = last_name
        self.online = online
        self.photo_100 = photo_100
    }

    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
