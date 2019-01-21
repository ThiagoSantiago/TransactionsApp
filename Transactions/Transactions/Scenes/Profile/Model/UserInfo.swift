//
//  UserInfo.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

struct UserInfo {
    var name: String
    var surname: String
    var birthdate: String
    var nationality: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case birthdate = "Birthdate"
        case nationality = "Nationality"
    }
}

extension UserInfo: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        surname = try values.decode(String.self, forKey: .surname)
        birthdate = try values.decode(String.self, forKey: .birthdate)
        nationality = try values.decode(String.self, forKey: .nationality)
    }
}

extension UserInfo: Equatable {
    
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        return lhs.name == rhs.name &&
            lhs.surname == rhs.surname &&
            lhs.birthdate == rhs.birthdate &&
            lhs.nationality == rhs.nationality
    }
}
