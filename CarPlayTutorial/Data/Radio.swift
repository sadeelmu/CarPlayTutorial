//
//  Radio.swift
//  CarPlayTutorial
//
//  Created by Sadeel Muwahed on 07/11/2023.
//

import Foundation

struct Radio:Decodable{
    let uid: String
    let title: String
    let subtitle:String
    let desc:String
    let imageUrl:String
    let imageSquareUrl:String
    let audioUrl:String
    let linkUrl:String
    let wikipediaUrl:String
    let isFavorited:Bool?
}
