//
//  SettingHeader.swift
//  OTT
//
//  Created by Alisher Djuraev on 20/04/22.
//

import UIKit

class SettingHeader: UICollectionReusableView {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "настройки"
        label.text = label.text?.uppercased()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        let color = UIColor.rgb(red: 10, green: 132, blue: 255)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        embedSubviews()
        setConstraints()
    }
    
    fileprivate func embedSubviews() {
        addSubview(label)
        addSubview(button)
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
