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
    func dismissKeyboard() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
        }
        
        @objc private func dismissKeyboardTouchOutside() {
           view.endEditing(true)
        }
    func showAlert(title:String, message: String,completion: @escaping () -> Void = {}){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK",style:.default) { (_)
            in completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
@objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
       return
    }
  self.view.frame.origin.y = 0 - keyboardSize.height
}
@objc func keyboardWillHiden(notification: NSNotification) {
    if  ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
        self.view.frame.origin.y = 0
    }
}

}

