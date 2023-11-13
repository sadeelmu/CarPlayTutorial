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
    var radios = [RadioListItemUI]() //an empty array of radioListCellUI
    var radioPresenter:RadioListPresentProtocol?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RadioListCell", bundle: Bundle.main), forCellReuseIdentifier: "RadioListCell")
        //we need a delegate for the view to interact with the presenter
        //so the presenter updates the view
        //but for now we do not need itå
        //first time loading
        radioPresenter?.getRadio{ radios in
            self.radios = radios ?? []
            tableView.reloadData() //so tableview reloads and shows data
        }
    }
}
//controller is part of the view layer
extension RadioListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RadioListCell = tableView.dequeueReusableCell(withIdentifier: "RadioListCell", for: indexPath) as! RadioListCell
        cell.configureWith(radioModel: radios[indexPath.row], at: indexPath, delegate: self)
        return cell
    }
}

extension RadioListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("radio", radios[indexPath.row])
    }
}

extension RadioListViewController: RadioListCellDelegate{
    func favoriteButtonSelected(_ indexPath: IndexPath) {
        radioPresenter?.favoriteButtonSelected(indexPath.row)
    }
}
