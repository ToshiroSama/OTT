//
//  NavigationCell.swift
//  OTT
//
//  Created by Alisher Djuraev on 22/03/22.
//

import UIKit

class NavigationHeaderCell: UICollectionViewCell {
    
    lazy var navLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(navLabel)
        addConstraintsWithFormat(format: "H:[v0(90)]", views: navLabel)
        
        addConstraint(NSLayoutConstraint(item: navLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: navLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error (code:) has not been implemented")
    }
}
