//
//  ChannelCell.swift
//  OTT
//
//  Created by Alisher Djuraev on 22/03/22.
//

import UIKit

class ChannelCell: UICollectionViewCell {
    
    static let identifier = "ChannelCell"
    
    lazy var channelImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10.0
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [channelImage]))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.embedSubviews()
        self.setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5

        channelImage.frame = contentView.bounds
    }
    
    fileprivate func embedSubviews() {
        self.backgroundColor = .white
        contentView.addSubview(channelImage)
        contentView.addSubview(stackView)
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        channelImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
