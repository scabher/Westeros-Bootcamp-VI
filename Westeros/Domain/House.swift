//
//  House.swift
//  Westeros
//
//  Created by Sergio Cabrera on 08/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person>

enum HouseName: String {
    case stark = "Stark"
    case lannister = "Lanister"
    case targaryen = "Targaryen"
}

// MARK: - House
final class House {
    let name: HouseName
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    init(name: HouseName, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        // Aqui, persons es de tipo [Person]
//        for person in persons {
//            add(person: person)
//        }
        persons.forEach{ add(person: $0) }
    }
}

// MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name.rawValue) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.rawValue.uppercased() // Alexander > Alexandre
    }
}

// MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - Sigil
final class Sigil {
    let description: String
    let image: UIImage
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}




