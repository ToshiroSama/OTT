//
//  SettingCell.swift
//  OTT
//
//  Created by Alisher Djuraev on 20/04/22.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    static var identifier = "SettingCell"
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.sizeName.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.nameLabel.textColor = self.isSelected ? UIColor.rgb(red: 10, green: 132, blue: 255) : UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 14),
            iconImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
