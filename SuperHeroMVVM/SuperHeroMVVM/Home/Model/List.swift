//
//  List.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 12/05/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let list = try? newJSONDecoder().decode(List.self, from: jsonData)

import Foundation

// MARK: - ListElement
struct ListElement: Codable {
    let id: Int
    let name, slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: Images
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender: Gender
    let race: String?
    let height, weight: [String]
    let eyeColor, hairColor: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance, publisher: String
    let alignment: Alignment
}

enum Alignment: String, Codable {
    case bad = "bad"
    case empty = "-"
    case good = "good"
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String
}

// MARK: - Images
struct Images: Codable {
    let xs, sm, md, lg: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability: Int
    let power, combat: Int
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}

typealias List = [ListElement]
