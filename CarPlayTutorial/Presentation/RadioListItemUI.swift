//
//  RadioListCellUI.swift
//  CarPlayTutorial
//
//  Created by Sadel Muwahed on 13/11/2023.
//

import Foundation
import UIKit

struct RadioListItemUI{
    let radioTitle:String
    let radioSubtitle:String
    let radioImageView:UIImage
    let radioIsFavorite:Bool
    let radio: Radio?
    
    init(radioTitle: String, radioSubtitle: String, radioImageView: UIImage, radioIsFavorite: Bool, radio: Radio? = nil) {
        self.radioTitle = radioTitle
        self.radioSubtitle = radioSubtitle
        self.radioImageView = radioImageView
        self.radioIsFavorite = radioIsFavorite
        self.radio = radio
    }
}
