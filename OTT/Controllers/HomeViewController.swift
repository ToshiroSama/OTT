//
//  HomeViewController.swift
//  OTT
//
//  Created by Alisher Djuraev on 18/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var navData: [HeaderTypes] = [
        HeaderTypes(navChannel: "ВСЕ"),
        HeaderTypes(navChannel: "НОВОСТИ"),
        HeaderTypes(navChannel: "СПОРТ"),
        HeaderTypes(navChannel: "ПРИРОДА")
    ]
    
    var channels: [Channel] = [
        Channel(id: 0, title: "ZorTV", image: "zortv"),
        Channel(id: 1, title: "Madaniyat va Marifat", image: "madaniyat"),
        Channel(id: 2, title: "MilliyTV", image: "milliy"),
        Channel(id: 3, title: "My5", image: "my5"),
        Channel(id: 4, title: "Россия24", image: "russia24"),
        Channel(id: 5, title: "Sevimli", image: "sevimli"),
        Channel(id: 6, title: "НТВ", image: "ntv"),
        Channel(id: 7, title: "National Geographic", image: "natgeo"),
        Channel(id: 8, title: "Euro News", image: "euronews"),
        Channel(id: 9, title: "Первый Канал", image: "ort")
    ]
    
    // MARK: - Connecting the two collection views
    
    // Calling the two collection views
    public let navigationCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NavigationCell.self, forCellWithReuseIdentifier: "Cell1")
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public let channelCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChannelCell.self, forCellWithReuseIdentifier: "Cell2")
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Title
    
    private let ottLabel: UILabel = {
        let label = UILabel()
        label.text = "ott"
        label.text = label.text?.uppercased()
        label.textColor = UIColor(red: 153/255, green: 255/255, blue: 102/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "primary"
        label.text = label.text?.uppercased()
        label.textColor = UIColor.systemBackground
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Adding two labels into the Horizontal Stack View with customized constraints
    private func headerTitles() {
        let headerTitleStackView = UIStackView(arrangedSubviews: [ottLabel, primaryLabel])
        headerTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        headerTitleStackView.alignment = .leading
        headerTitleStackView.spacing = 5
        view.addSubview(headerTitleStackView)
        
        NSLayoutConstraint.activate([
            headerTitleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTitleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerTitleStackView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }

    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .label
        headerTitles()
        view.addSubview(navigationCV)
        view.addSubview(channelCV)
        
        // Customization the constraints of two collection views
        navigationCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        navigationCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        navigationCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        navigationCV.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        channelCV.topAnchor.constraint(equalTo: navigationCV.bottomAnchor, constant: 20).isActive = true
        channelCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        channelCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        channelCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
                    
        // Load collection view data
        navigationCV.delegate = self
        navigationCV.dataSource = self
        
        channelCV.delegate = self
        channelCV.dataSource = self
        
    }
}
