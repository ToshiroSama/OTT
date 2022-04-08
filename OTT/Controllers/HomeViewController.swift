//
//  HomeViewController.swift
//  OTT
//
//  Created by Alisher Djuraev on 18/03/22.
//

import UIKit

class HomeViewController: UIViewController {
   
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.delegate = self
        return mb
    }()
    
    lazy var channelCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ChannelCell.self, forCellWithReuseIdentifier: ChannelCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var filteredChannels: [ChannelItems] = [] {
        didSet {
            self.channelCV.reloadData()
        }
    }

    // MARK: - Title
    
    private let ottLabel: UILabel = {
        let label = UILabel()
        label.text = "ott"
        label.text = label.text?.uppercased()
        label.textColor = UIColor.rgb(red: 153, green: 255, blue: 102)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let platformLabel: UILabel = {
        let label = UILabel()
        label.text = "platform"
        label.text = label.text?.uppercased()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Adding two labels into the Horizontal Stack View with customized constraints
    private func headerTitles() {
        let headerTitleStackView = UIStackView(arrangedSubviews: [ottLabel, platformLabel])
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
        headerTitles()
        view.addSubview(channelCV)
        
        channelCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        channelCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        channelCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        channelCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        channelCV.delegate = self
        channelCV.dataSource = self
        
        self.filteredChannels = ChannelService.shared.channels
        setupBarMenu()
    }
    
    private func setupBarMenu() {

        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(60)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChannels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCell.identifier, for: indexPath) as? ChannelCell else {
            return UICollectionViewCell()
        }
        
        let model = filteredChannels[indexPath.item]
        let urlString = model.image
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell.channelImage.image = image
        } else {
            cell.channelImage.image = UIImage(named: "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        let layout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let margins = layout.minimumInteritemSpacing
        let width = collectionView.frame.width * 0.5 - (margins + insets)
        return CGSize(width: width, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension HomeViewController: MenuBarDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        self.filteredChannels = {
            if indexPath.item == 0 {
                return ChannelService.shared.channels
            } else {
                return ChannelService.shared.channels.filter { $0.headerType == HeaderType.allCases[indexPath.item] }
            }
        }()
    }
}
