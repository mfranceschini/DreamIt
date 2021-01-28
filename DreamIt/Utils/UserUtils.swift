//
//  UserUtils.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-27.
//

import Foundation
import Firebase
import FirebaseAuth
import LocalAuthentication

public func saveUserInfo(_ userData: AuthDataResult) {
    UserDefaults.standard.setValue(userData.user.uid, forKey: "userID")
    UserDefaults.standard.setValue(userData.user.displayName, forKey: "displayName")
    UserDefaults.standard.setValue(userData.user.photoURL, forKey: "photoURL")
    UserDefaults.standard.setValue(userData.user.email, forKey: "email")
}

public func isUserLoggedIn() -> Bool {
    let userId = UserDefaults.standard.string(forKey: "userID")
    if userId != nil {
        return true
    }
    return false
}

public func doLogout(_ completion: @escaping (Bool) -> Void) {
    do {
        try Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "displayName")
        UserDefaults.standard.removeObject(forKey: "photoURL")
        UserDefaults.standard.removeObject(forKey: "email")
        completion(isUserLoggedIn())
    } catch {
        completion(isUserLoggedIn())
    }
}

public func getUserID() -> String? {
    return UserDefaults.standard.string(forKey: "userID")
}
