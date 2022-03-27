//
//  NavigationCell.swift
//  OTT
//
//  Created by Alisher Djuraev on 22/03/22.
//

import UIKit

class NavigationCell: UICollectionViewCell {
    
    public var navLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.navLabel.textColor = self.isSelected ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.navLabel.textColor = self.isHighlighted ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    // refactor this
    private func navStack() {
        let stackView = UIStackView(arrangedSubviews: [navLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        navStack()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navLabel.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error (code:) has not been implemented")
    }
}
