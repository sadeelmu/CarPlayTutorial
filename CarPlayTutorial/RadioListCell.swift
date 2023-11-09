//
//  RadioListCell.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 07/11/2023.
//

import Foundation
import UIKit

class RadioListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var currentRadio: Radio? = nil

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
        
        let favoriteImage = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid}) ? UIImage(named: "favorite") : UIImage(named: "favorite_border")
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.isSelected = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid})
    }
    
    @IBAction func favorite(button: UIButton) {
        
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
