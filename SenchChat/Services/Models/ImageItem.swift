//
//  ImageItem.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 24.03.22.
//

import UIKit
import MessageKit

struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
      
}
