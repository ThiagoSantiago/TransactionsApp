//
//  GrenericResponse.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

class GenericResponse: Decodable {
    var errorCode: String?
    var message: String?
}
