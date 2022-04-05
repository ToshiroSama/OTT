//
//  HomeViewController.swift
//  OTT
//
//  Created by Alisher Djuraev on 18/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var navData: [HeaderType] = HeaderType.allCases /*[
        HeaderTypes(navChannel: "ВСЕ"),
        HeaderTypes(navChannel: "НОВОСТИ"),
        HeaderTypes(navChannel: "СПОРТ"),
        HeaderTypes(navChannel: "ПРИРОДА")
    ]*/
    
    var channels: [Channel] = [
        
        Channel(id: 0, title: "ZorTV", image: "zortv", headerType: .nature),
        Channel(id: 1, title: "Madaniyat va Marifat", image: "madaniyat", headerType: .news),
        Channel(id: 2, title: "MilliyTV", image: "milliy", headerType: .sport),
        Channel(id: 3, title: "My5", image: "my5", headerType: .nature),
        Channel(id: 4, title: "Россия24", image: "russia24", headerType: .news),
        Channel(id: 5, title: "Sevimli", image: "sevimli", headerType: .sport),
        Channel(id: 6, title: "НТВ", image: "ntv", headerType: .nature),
        Channel(id: 7, title: "National Geographic", image: "natgeo", headerType: .nature),
        Channel(id: 8, title: "Euro News", image: "euronews", headerType: .news),
        Channel(id: 9, title: "Первый Канал", image: "ort", headerType: .news)
    ]
    
    var filteredChannels: [Channel] = []
    
    // MARK: - Connecting the two collection views
    
    // Calling the two collection views
    public let navigationCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NavigationCell.self, forCellWithReuseIdentifier: "Cell1")
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private(set) var lineView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        return $0
    }(UIView())
    
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
    
    var leadingConstraint: NSLayoutConstraint!
    
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
        view.addSubview(lineView)
        view.addSubview(channelCV)
        
        // Customization the constraints of two collection views
        navigationCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        navigationCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navigationCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
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
        
        self.filteredChannels = self.channels
        
        leadingConstraint = lineView.leftAnchor.constraint(equalTo: view.leftAnchor)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            lineView.bottomAnchor.constraint(equalTo: navigationCV.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2.0),
            lineView.widthAnchor.constraint(equalToConstant: 
                                                (navigationCV.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }
}
