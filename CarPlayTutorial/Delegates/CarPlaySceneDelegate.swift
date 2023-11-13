//
//  CarPlaySceneDelegate.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 06/11/2023.
//

import Foundation
import CarPlay

//should seprate
class CarPlaySceneDelegate: UIResponder{
    
    //our properties
    var interfaceController: CPInterfaceController?
    var radios = [Radio]()
    let radioListTemplate: CPListTemplate = CPListTemplate(title: "Radios", sections: [])
    let favoriteRadiosListTemplate: CPListTemplate = CPListTemplate(title: "Favorites", sections: [])
    
    //method to update the list according to favorites
    func updateRadioList(onlyWithFavorites:Bool) -> CPListSection{
        var radioItems = [CPListItem]()
        for radio in (onlyWithFavorites ? DataManager.shared.favoriteRadios : radios){
            let item = CPListItem(text: radio.title, detailText: radio.subtitle)
            item.accessoryType = .disclosureIndicator
            item.setImage(UIImage(named: radio.imageSquareUrl))
            item.handler = { [weak self] item, completion in
                guard let strongSelf = self else { return }
                strongSelf.favoriteAlert(radio: radio, completion: completion)
            }
            radioItems.append(item)
        }
        return CPListSection(items: radioItems)
    }
    
    //method to bring up alert when user interacts with favorites
    func favoriteAlert(radio: Radio, completion: @escaping () -> Void) {
        let okAlertAction: CPAlertAction = CPAlertAction(title: "Ok", style: .default) { _ in
            DataManager.shared.updateFavoriteRadios(radio: radio)
            NotificationCenter.default.post(name: .updateFavoriteRadiosNotification, object: nil)
            self.interfaceController?.dismissTemplate(animated: true, completion: { _, _ in })
        }
        let titleAlert = DataManager.shared.favoriteRadios.contains(where: {$0.uid == radio.uid}) ? "Remove from favorite" : "Add to favorite"
        let alertTemplate: CPAlertTemplate = CPAlertTemplate(titleVariants: [titleAlert], actions: [okAlertAction])
        self.interfaceController?.presentTemplate(alertTemplate, animated: true, completion: { _, _ in
            completion()
        })
    }
}

extension CarPlaySceneDelegate: CPTemplateApplicationSceneDelegate{
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        self.interfaceController?.delegate = self
        
        NotificationCenter.default.addObserver(forName: .updateFavoriteRadiosNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.favoriteRadiosListTemplate.updateSections([strongSelf.updateRadioList(onlyWithFavorites: false)])
        }
        
        DataManager.shared.getRadios { currentRadios in
            self.radios = currentRadios ?? []
        }
        
        //create the radio list
        radioListTemplate.updateSections([updateRadioList(onlyWithFavorites:false)])
        radioListTemplate.tabImage = UIImage(named: "radio")

        //create fav
        favoriteRadiosListTemplate.updateSections([updateRadioList(onlyWithFavorites: true)])
        favoriteRadiosListTemplate.tabImage = UIImage(named: "half_favorite")
        
        //create tap bar
        let tabBar = CPTabBarTemplate.init(templates: [radioListTemplate, favoriteRadiosListTemplate])
        tabBar.delegate = self
        self.interfaceController?.setRootTemplate(tabBar, animated: true, completion: {_, _ in
        })
    }
    
    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}

extension CarPlaySceneDelegate: CPTabBarTemplateDelegate{
    func tabBarTemplate(_ tabBarTemplate: CPTabBarTemplate, didSelect selectedTemplate: CPTemplate){
        
    }
}

//controller for interface
//in correct arch the extension would be their own classes 
extension CarPlaySceneDelegate: CPInterfaceControllerDelegate {

    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillAppear", aTemplate)
        
        if aTemplate == favoriteRadiosListTemplate {
            favoriteRadiosListTemplate.updateSections([updateRadioList(onlyWithFavorites: true)])
        }
    }

    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidAppear", aTemplate)
    }

    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateWillDisappear", aTemplate)
    }

    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        print("templateDidDisappear", aTemplate)
    }
}
