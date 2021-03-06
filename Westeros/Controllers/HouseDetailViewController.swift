//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Sergio Cabrera on 12/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    
    // Mark: - Properties
    var house: House
    
    // Mark: - Initialization
    init(house: House) {
        // Primero, limpias tu propio desorder
        self.house = house
        // Llamas a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = house.name.rawValue
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        houseNameLabel.text = "House \(house.name.rawValue)"
        sigilImageView.image = house.sigil.image
        wordsLabel.text = house.words
        title = house.name.rawValue
        
        let backItem = UIBarButtonItem()
        backItem.title = house.name.rawValue
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let members = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))

        navigationItem.rightBarButtonItems = [wikiButton, members]
    }
    
    @objc func displayWiki() {
        // Creamos el WikiVC
        let wikiViewController = WikiViewController(model: house)
        
        // Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers() {
        // Creamos el VC
        let memberListViewController = MemberListViewController(members: house.sortedMembers)

        // Hacemos Push
        navigationController?.pushViewController(memberListViewController, animated: true)
        
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        let collapsed = splitViewController?.isCollapsed ?? true
        
        self.house = house
        syncModelWithView()
        
        if (collapsed) {
            navigationController?.popToViewController(self, animated: true)
        }
    }
}














