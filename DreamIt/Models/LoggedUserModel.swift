//
//  LoggedUserModel.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-12-14.
//

import SwiftUI

enum ProfileTypes: String {
    case Creator
    case Implementer
}

struct LoggedUserModel {
    var firstName: String
    var lastName: String
    var profileType: ProfileTypes
    var email: String
    var country: String
    var phoneNumber: String
    var portfolioURL: String
}
