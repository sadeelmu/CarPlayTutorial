//
//  CarPlaySceneDelegate.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 06/11/2023.
//

import Foundation
import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
    var interfaceController: CPInterfaceController?
    var radios = [Radio]()
    let radioListTemplate: CPListTemplate = CPListTemplate(title: "Radios", sections: [])
    let favoriteRadiosListTemplate: CPListTemplate = CPListTemplate(title: "Favorites", sections: [])
    
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
        
        let item = CPListItem(text: "Fuel Stations", detailText: "Home")
        item.accessoryType = .disclosureIndicator
        let section = CPListSection(items: [item])
        let listTemplate = CPListTemplate(title: "Section", sections: [section])
        // Set root
        self.interfaceController?.setRootTemplate(listTemplate, animated: true, completion: {_, _ in })
    }
    
    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
    
    func application(_ application:UIApplication, configurationForConnection connectingScenceSession:UISceneSession, options:UIScene.ConnectionOptions) -> UISceneConfiguration{
        
        if(connectingScenceSession.role == UISceneSession.Role.carTemplateApplication){
            let scene = UISceneConfiguration(name: "CarPlay", sessionRole: connectingScenceSession.role)
            scene.delegateClass = CarPlaySceneDelegate.self
            return scene
        }
        else {
            return UISceneConfiguration(name:"Default Configuration", sessionRole: connectingScenceSession.role)
        }
    }
}


