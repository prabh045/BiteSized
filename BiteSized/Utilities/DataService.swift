//
//  DataService.swift
//  BiteSized
//
//  Created by Prabhdeep Singh on 04/09/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import os.log

class DataService {
    
    static func fetchData(completion: @escaping (DataModel?) -> Void) {
        let urlString = "https://gist.githubusercontent.com/anishbajpai014/d482191cb4fff429333c5ec64b38c197/raw/b11f56c3177a9ddc6649288c80a004e7df41e3b9/HiringTask.json"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                os_log(.debug, log: .default, "Error Fetching data from server")
                return
            }
            
            guard let data = data else {
                os_log(.debug, log: .default, "No Data available")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                os_log(.debug, log: .default, "No Response")
                return
            }
            
            guard response.statusCode == 200 else {
                os_log(.debug, log: .default, "Wrong Status Code")
                return
            }
            
            let stringData = String(data: data, encoding: .utf8)
            let newString = String((stringData?.dropFirst())!)
            let newData = Data(newString.utf8)
            
            do {
                let dataModel = try JSONDecoder().decode(DataModel.self, from: newData)
                completion(dataModel)
            } catch {
                os_log(.info, log: .default, "Error in converting Data")
            }
            
        }.resume()
    }
    
    
}


