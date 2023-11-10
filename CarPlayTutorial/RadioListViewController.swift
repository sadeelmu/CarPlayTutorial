//
//  RadioListViewController.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 07/11/2023.
//

import Foundation
import UIKit
import MediaPlayer
import AVKit

class RadioListViewController: UIViewController {
    
    var radios = [Radio]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Nib Cells
        tableView.register(UINib(nibName: "RadioListCell", bundle: Bundle.main), forCellReuseIdentifier: "RadioListCell")
        
        //Notifications
        NotificationCenter.default.addObserver(forName: .updateFavoriteRadiosNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.getRadios()
        }
        //first time loading
        getRadios()
    }
    
    func getRadios() {

        //introduce a presenter/presentation layer which handles the communication with business layer
        // read about view models or MVVM
        DataManager.shared.getRadios(completionHandler: { currentRadios in
            self.radios = currentRadios ?? []
            tableView.reloadData()
        })
    }

}

extension RadioListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RadioListCell = tableView.dequeueReusableCell(withIdentifier: "RadioListCell", for: indexPath) as! RadioListCell
        cell.configureWith(radio: radios[indexPath.row])
        return cell
    }
}

extension RadioListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("radio", radios[indexPath.row])
    }
}
