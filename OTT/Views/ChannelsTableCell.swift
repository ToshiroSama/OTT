//
//  ChannelsTableCell.swift
//  OTT
//
//  Created by Alisher Djuraev on 14/04/22.
//

import UIKit

class ChannelsTableCell: UITableViewCell {
    
    static var identifier = "ChannelsTableCell"
    
    var channel: ChannelItems? {
        didSet {
            if let channel = channel {
                titleLabel.text = channel.title
                subtitleLabel.text = "Без названия"
            }
        }
    }
    
   lazy var channelImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10.0
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.lightGray.cgColor
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = UIColor.rgb(red: 204, green: 204, blue: 204)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        channelImageView.frame = contentView.bounds
    }
    
    private func setupView() {
        [channelImageView, titleLabel, subtitleLabel].forEach { (result) in
            contentView.addSubview(result)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            channelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            channelImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            channelImageView.widthAnchor.constraint(equalToConstant: 120),
            channelImageView.heightAnchor.constraint(equalToConstant: 80),
            channelImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
