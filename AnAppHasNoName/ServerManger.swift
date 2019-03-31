//
//  ServerManger.swift
//  AnAppHasNoName
//
//  Created by Amjad on 07/01/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ServerManger {
    
    static let sharedInstance: ServerManger = {
        let instance = ServerManger()
        return instance
    }()
    
    private static let ref  = Database.database().reference()
    
    //MARK: - Authentication API
    var CURRENT_USER: FirebaseAuth.User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        return nil
    }
    
    static func logOut(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let logoutError {
            onError(logoutError.localizedDescription)
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    static func signUp(username: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let uid = user?.user.uid
            self.setUserInfomation(username: username, email: email, uid: uid!, onSuccess: onSuccess)
        }
    }
    
    static func setUserInfomation(username: String, email: String, uid: String, onSuccess: @escaping () -> Void){
        ref.child(Config.MANAGE_USERS_ENDPOINT).child(uid).setValue(["username": username , "email": email])
        onSuccess()
    }
    
    //MARK: - Item API
    static func sendDataToDatabase(type: String, name: String, imageData: Data, caption: String, date: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        guard let currentUser = sharedInstance.CURRENT_USER else {
            return
        }
        
        var dict = [String: Any]()
        
        //TODO: Create a separate method for uploading image
        let imageId = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(Config.ITEM_IMAGES_ENDPOINT).child(imageId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                return
            }
            
            storageRef.downloadURL(completion: { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                let imageUrl = downloadURL.absoluteString
                let currentUserId = currentUser.uid
                dict = ["uid": currentUserId, "name": name, "imageUrl": imageUrl, "caption": caption, "seasonsCount": 0, "date": date] as [String : Any]
                
                if let newItemId = ref.child(type).childByAutoId() .key {
                    let newItemReference = ref.child(type).child(newItemId)
                    newItemReference.setValue(dict) { (error, ref) in
                        if error != nil {
                            onError(error?.localizedDescription)
                        }
                        onSuccess()
                        
                    }
                }
                
            })
        }
        
    }
    
    //MARK: - Common API
    
}
