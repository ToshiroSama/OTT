//
//  HomeVC+exten.swift
//  OTT
//
//  Created by Alisher Djuraev on 22/03/22.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.navigationCV {
            return navData.count
        }
        
        return self.channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.navigationCV {
            guard let navCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? NavigationCell else {
                return UICollectionViewCell()
            }
            
            // Set up Nav cell
            let data = navData[indexPath.row]
            navCell.navLabel.text = data.navChannel
            return navCell
            
        } else {
            guard let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as? ChannelCell else {
                return UICollectionViewCell()
            }
            
            // Set up Channel cell
            let data = channels[indexPath.row]
            channelCell.channelImage.image = UIImage(named: data.image)
            channelCell.backgroundColor = .white
            return channelCell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.navigationCV {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
        collectionView == self.navigationCV ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionView == self.navigationCV ? 0 : 10
    }
    
}
    