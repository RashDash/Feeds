//
//  ApiHelper.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol ApiHelperProtocol {
    func fetchAllItems( complete: @escaping ( _ success: Bool, _ items: [Item],
        _ error: APIError? )->() )
}

class ApiHelper: ApiHelperProtocol {

    // Simulate a wait for fetching
    func fetchAllItems( complete: @escaping ( _ success: Bool, _ items: [Item], _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            if let localData = self.readLocalFile(forName: "Stryds") {
                let items = self.parse(jsonData: localData)
                complete(true,items, nil)
            }
        }
    }
    
    // Read local file as Data
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // Parse read Data as array of Item Model
    private func parse(jsonData: Data) -> [Item] {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode([Item].self, from: jsonData)
            print(decodedData)
            return decodedData
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
}
