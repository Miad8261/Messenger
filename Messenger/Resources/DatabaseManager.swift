//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Miad Azarmehr on 2020-11-29.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    
//    synchrionous call database
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value) { (snapShot) in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "firs_tname": user.firstName,
            "last_name": user.lastName
        ])
    }
}
    
    struct ChatAppUser {
        let firstName: String
        let lastName: String
        let emailAddress: String
        
        var safeEmail: String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
        
        var profilePictureFileName: String {
            //afraz9-gmail-com_profile_picture.png
            return "\(safeEmail)_profile_picture.png"
        }
    }
