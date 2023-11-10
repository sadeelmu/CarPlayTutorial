//
//  RadioListCell.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 07/11/2023.
//

import Foundation
import UIKit

class RadioListCell: UITableViewCell {

    var currentRadio: Radio? = nil // I'd not advise business logic here, I suggest use IndexPath to have track of which radio was selected

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        radioImageView.image = nil
    }
    
    func configureWith(radio: Radio) {
        currentRadio = radio
        
        titleLabel.text = radio.title
        subtitleLabel.text = radio.subtitle
        radioImageView.image = UIImage(named: radio.imageUrl)


        // I'd advise sending the bool value isFavorite here instead of having the logic in a View layer
        let favoriteImage = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid}) ? UIImage(named: "favorite") : UIImage(named: "favorite_border")
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.isSelected = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid})
    }
    
    @IBAction func favorite(button: UIButton) {

        //here we can setup a delegate to update the view controller instead of working on the logic here
        guard let radio = currentRadio else { return }
        if button.isSelected == true {
            button.isSelected = false
            button.setImage(UIImage(named: "favorite_border"), for: .normal)
        } else {
            button.isSelected = true
            button.setImage(UIImage(named: "favorite"), for: .normal)
        }
        DataManager.shared.updateFavoriteRadios(radio: radio)
        
        //maintain a favorite radios list inside the DataManager.
        NotificationCenter.default.post(name: .updateFavoriteRadiosNotification, object: nil)
    }
    
}
