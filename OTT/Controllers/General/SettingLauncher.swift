//
//  SettingLauncher.swift
//  OTT
//
//  Created by Alisher Djuraev on 20/04/22.
//

import UIKit

class SettingLauncher: NSObject {
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let cellHeight: CGFloat = 45
    let settings: [Setting] = {
        let firstDimension = Setting(sizeName: .firstDimension, imageName: "checkmark")
        let secondDimension = Setting(sizeName: .secondDimension, imageName: "checkmark")
        let thirdDimension = Setting(sizeName: .thirdDimension, imageName: "checkmark")
        let fourthDimension = Setting(sizeName: .fourthDimension, imageName: "checkmark")
        return [firstDimension, secondDimension, thirdDimension, fourthDimension]
    }()
    
    override init() {
        super.init()
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    var channelViewController: ChannelViewController?
    
    @objc func showSettings() {
        // Show menu
        if let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive}).first(where: {$0 is UIWindowScene}).flatMap({$0 as? UIWindowScene})?.windows.first(where: \.isKeyWindow)
        {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive}).first(where: {$0 is UIWindowScene}).flatMap({$0 as? UIWindowScene})?.windows.first(where: \.isKeyWindow) {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) {(completed: Bool) in
            if !setting.isKind(of: UITapGestureRecognizer.self) && setting.sizeName.rawValue != "" {
                self.channelViewController?.showControllerForSetting(setting: setting)
            }
        }
    }
}

extension SettingLauncher: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
}
