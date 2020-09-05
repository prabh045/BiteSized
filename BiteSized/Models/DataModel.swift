//
//  DataModel.swift
//  BiteSized
//
//  Created by Prabhdeep Singh on 04/09/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct DataModel: Decodable {
    var data: Array<DataComponents>
}

struct DataComponents: Decodable {
    var id: String
    var text: String
}
