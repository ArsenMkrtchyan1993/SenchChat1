//
//  UIView + Extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 05.03.22.
//

import UIKit

extension UIViewController {
    
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type,white value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("cant cost  \(cellType)")}
        cell.configure(whit: value)
        return cell
    }
}
