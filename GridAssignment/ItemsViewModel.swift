//
//  AllItemsViewModel.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit

class ItemsViewModel {
    let apiService: ApiHelperProtocol

    var itemsArray = [Item]()

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    

    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?

    init(apiService: ApiHelperProtocol = ApiHelper()) {
        self.apiService = apiService
        initFetch()
    }


    func initFetch() {
        self.isLoading = true
        apiService.fetchAllItems { [weak self] (success, items, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.itemsArray = items
            }
        }
    }

   

}
