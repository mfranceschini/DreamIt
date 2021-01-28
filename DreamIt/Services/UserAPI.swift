//
//  UserAPI.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-27.
//

import Foundation
import Firebase

class UserAPI {
    
    let db = Firestore.firestore()
    
    func saveUserProfile(_ userData: LoggedUserModel, _ completion: @escaping (Error?) -> Void) {
        db.collection("usersProfiles").addDocument(data: [
            "userID": userData.uid,
            "name": userData.firstName,
            "lastName": userData.lastName,
            "country": userData.country,
            "portfolioUrl": userData.portfolioURL,
            "profileType": userData.profileType.rawValue
        ]) { err in
            completion(err)
        }
    }
    
    func getUserProfile(_ completion: @escaping (LoggedUserModel?) -> Void) {
        if let userId = getUserID() {
            db.collection("usersProfiles").whereField("userID", isEqualTo: userId).limit(to: 1).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var userProfile: LoggedUserModel?
                    for document in querySnapshot!.documents {
                        userProfile = self.decodeUserProfile(document.data())
                    }
                    completion(userProfile ?? nil)
                }
            }
        }
        
    }
    
    private func decodeUserProfile(_ dict: [String:Any]) -> LoggedUserModel {
        let id = dict["userID"] as? String ?? ""
        let firstName = dict["firstName"] as? String ?? ""
        let lastName = dict["lastName"] as? String ?? ""
        let profileType = dict["profileType"] as? String ?? ""
        var enumProfileType: ProfileTypes = ProfileTypes.Creator
        
        switch profileType {
        case "Creator":
            enumProfileType = ProfileTypes.Creator
        case "Implementer":
            enumProfileType = ProfileTypes.Implementer
        default:
            enumProfileType = ProfileTypes.Creator
        }
        
        let email = dict["email"] as? String ?? ""
        let country = dict["country"] as? String ?? ""
        let phoneNumber = dict["phoneNumber"] as? String ?? ""
        let portfolioURL = dict["portfolioURL"] as? String ?? ""
        
        return LoggedUserModel(
            uid: id,
            firstName: firstName,
            lastName: lastName,
            profileType: enumProfileType,
            email: email,
            country: country,
            phoneNumber: phoneNumber,
            portfolioURL: portfolioURL
        )
    }
    
}
