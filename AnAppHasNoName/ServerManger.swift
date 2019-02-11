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

class ServerManger {
    
    static let sharedInstance: ServerManger = {
        let instance = ServerManger()
        return instance
    }()
    
    //MARK: - User Settings API
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
        let ref  = Database.database().reference()
        ref.child(Config.MANAGE_USERS_ENDPOINT).child(uid).setValue(["username": username , "email": email])
        onSuccess()
    }
    
}
