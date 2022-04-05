//
//  HomeVC+exten.swift
//  OTT
//
//  Created by Alisher Djuraev on 22/03/22.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuBar.navigationCV {
            return menuBar.navData.count
        }
        
        return self.filteredChannels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuBar.navigationCV {
            guard let navCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? NavigationCell else {
                return UICollectionViewCell()
            }
            
            // Set up Nav cell
            let data = menuBar.navData[indexPath.row]
            navCell.navLabel.text = data.rawValue
            return navCell
            
        } else {
            guard let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as? ChannelCell else {
                return UICollectionViewCell()
            }
            channelCell.channel = self.filteredChannels[indexPath.item]
            return channelCell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuBar.navigationCV {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            let x = CGFloat(indexPath.item) * self.view.frame.width / CGFloat(menuBar.navData.count)
            self.leadingConstraint.constant = x
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            }
            if indexPath.item == 0 {
                self.filteredChannels = self.channels
            } else {
                let indexed = menuBar.navData[indexPath.item]
                self.filteredChannels = self.channels.filter { $0.headerType == indexed }
            }
            self.channelCV.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.channelCV {
            let insets = collectionView.contentInset.left + collectionView.contentInset.right
            let layout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
            let margins = layout.minimumInteritemSpacing
            let width = collectionView.frame.width * 0.5 - (margins + insets)
            return CGSize(width: width, height: 100.0)
        } else {
            return CGSize(width: 100.0, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        collectionView == menuBar.navigationCV ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionView == menuBar.navigationCV ? 0 : 10
    }
    
}
    
