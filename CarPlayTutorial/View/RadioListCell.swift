//
//  RadioListCell.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 07/11/2023.
//

import Foundation
import UIKit

class RadioListCell: UITableViewCell {
    var radioIndexPath:IndexPath?
    var radioDelegate:RadioListCellDelegate?
    
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
    
    func configureWith(radioModel:RadioListItemUI, at indexPath:IndexPath, delegate:RadioListCellDelegate) {
        radioIndexPath = indexPath
        radioDelegate = delegate
        
        titleLabel.text = radioModel.radioTitle
        subtitleLabel.text = radioModel.radioSubtitle
        radioImageView.image = radioModel.radioImageView
                
        let favoriteImage = radioModel.radioIsFavorite ? UIImage(named: "favorite") : UIImage(named: "favorite_border")
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.isSelected = radioModel.radioIsFavorite
    }
    
    @IBAction func favorite(button: UIButton) {
        if button.isSelected == true {
            button.isSelected = false
            button.setImage(UIImage(named: "favorite_border"), for: .normal)
        } else {
            button.isSelected = true
            button.setImage(UIImage(named: "favorite"), for: .normal)
        }
        
        guard let radioIndexPath = radioIndexPath else {return} 
        radioDelegate?.favoriteButtonSelected(radioIndexPath)
        //here we have to send back the isfavorite
    }
}

protocol RadioListCellDelegate{
    func favoriteButtonSelected(_ indexPath:IndexPath)
}
