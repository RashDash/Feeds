//
//  ItemsController.swift
//  GridAssignment
//
//  Created by Bhushan on 22/04/21.
//

import UIKit

class ItemsController: UIViewController {

    var viewModel = ItemsViewModel()
    var selectedPath : IndexPath?
    
    @IBOutlet var listView : UITableView!{
        didSet{
            listView.dataSource = self
            listView.delegate = self
            listView.register(UINib(nibName: ImageCell.identifier, bundle: nil), forCellReuseIdentifier: ImageCell.identifier)
            listView.register(UINib(nibName: VideoCell.identifier, bundle: nil), forCellReuseIdentifier: VideoCell.identifier)
            listView.tableFooterView = UIView()
            listView.separatorStyle = .none
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stryds.json"
        initViewModel()
    }

    private func initViewModel() {
        listView.alpha = 0.0
        viewModel = ItemsViewModel()

        viewModel.reloadTableViewClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.listView.reloadData()
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.listView.alpha = 0.0
                    })
                }else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.listView.alpha = 1.0
                    })
                }
                
                self?.listView.reloadData()
            }
        }

        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


