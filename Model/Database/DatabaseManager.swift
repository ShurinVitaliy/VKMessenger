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

class FriendDataManager {
    let realm = try! Realm()
    
    func getFriends() -> [Friend]{
        var friends: [Friend] = []
        let friendsDatabase = realm.objects(FriendDatabase.self)
        for friendDatabase in friendsDatabase {
            //TODO: As I mentioned it will be better to use protocols so you don't need to map Friend to FriendDatabase. Instead you will have Friend protocol and two different implementation of this protocol
            let friend = Friend.init(first_name: friendDatabase.first_name, id: friendDatabase.id, last_name: friendDatabase.last_name, online: friendDatabase.online, photo_100: friendDatabase.photo_100)
            friends.append(friend)
        }
        return friends
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

class FriendDatabase: Object {
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
