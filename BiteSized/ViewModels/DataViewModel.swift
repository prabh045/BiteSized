//
//  DataViewModel.swift
//  BiteSized
//
//  Created by Prabhdeep Singh on 05/09/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import os.log

class DataViewModel {
    
    private var dataModel: DataModel?
    var dataArray = Box([DataComponents]())
    
    func retrieveData() {
        DataService.fetchData { (dataModel) in
            guard let dataModel = dataModel else {
                os_log(.debug, log: .default, "Data Model Absent")
                return
            }
            self.dataArray.value = dataModel.data
        }
    }
}
