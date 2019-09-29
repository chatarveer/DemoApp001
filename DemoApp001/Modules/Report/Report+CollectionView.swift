//
//  Report+CollectionView.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

extension ReportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.selectedIndex(indexPath: indexPath)
    }
}

extension ReportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        guard let count = self.presenter?.arrayDamagedImages?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCollectionViewCell", for: indexPath) as? ReportCollectionViewCell,
            let arrayDamagedImages = self.presenter?.arrayDamagedImages
            else { return UICollectionViewCell() }
        
        let object = arrayDamagedImages[indexPath.row]
        cell.configureCell(object: object)
        
        return cell
    }
}

extension ReportViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 12.0
        let spacing: CGFloat = 12.0
        
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionViewDamageArea{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    }
}
