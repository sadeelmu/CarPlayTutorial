//
//  RadioListPresent.swift
//  CarPlayTutorial
//
//  Created by Sadel Muwahed on 10/11/2023.
//

import Foundation
import UIKit

//lets define a protocol
//cause every layer defines a protocol for the layer before it
//so the view defines the protocol for the presenter
//ui logic here
//this is a logic so it should not use indexPath as we should not access ui here. pure logic

protocol RadioListPresentProtocol{
    func getRadio(completionHandler: ([RadioListItemUI]?) -> Void)
    func favoriteButtonSelected(_ index:Int)
}

class RadioListPresent: RadioListPresentProtocol{
    let dataManager = DataManager() //data
    var radios:[Radio] = [Radio]()
    //when data comes from getRadio
    //save it onto radios
    
    
    func getRadio(completionHandler: ([RadioListItemUI]?) -> Void) {
        //call dataManager and get the radios.
        //save the Radios gotten from the dataManager onto our local radios variable defined above
        DataManager.shared.getRadios(completionHandler: {savedRadios in
            radios = savedRadios ?? []
        })
                
        //you need to map the data to RadioListItemUI
        var radioItem:[RadioListItemUI] = radios.map{radio in
            return RadioListItemUI(radioTitle: radio.title, radioSubtitle: radio.subtitle, radioImageView: UIImage(imageLiteralResourceName: radio.imageUrl), radioIsFavorite: radio.isFavorited ?? false)
        }
        //and return the data to view
        return completionHandler(radioItem)
    }
    
    func favoriteButtonSelected(_ index: Int) {
       //call dataManager to update the favorite
        //i return radios[index]
        dataManager.updateFavoriteRadios(radio: radios[index])
    }
}

//as a view what i need from the presentation is the following
//1. radiolist
//2. if the customer favorited or not favorited (actions)
//data and actions
