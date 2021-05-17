//
//  DetailList.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 16/05/2021.
//

import Foundation

// MARK: - DetailListElement
class DetailList: Codable {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images

    init(id: Int, name: String, slug: String, powerstats: Powerstats, appearance: Appearance, biography: Biography, work: Work, connections: Connections, images: Images) {
        self.id = id
        self.name = name
        self.slug = slug
        self.powerstats = powerstats
        self.appearance = appearance
        self.biography = biography
        self.work = work
        self.connections = connections
        self.images = images
    }
}
