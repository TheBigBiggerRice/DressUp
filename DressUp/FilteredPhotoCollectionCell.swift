//
//  FilteredPhotoCollectionCell.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class FilteredPhotoCollectionCell: UICollectionViewCell {
  
  var viewModel: FilteredPhotoCollectionCellViewModel? {
    didSet {
      guard let vm = viewModel else {
        return
      }
      let imageURL = URL(string: vm.imageURL)
      filteredImageView.kf.setImage(with: imageURL)
      //filteredImageView.imageFromUrl(urlString: vm.imageURL)
    }
  }
  
  let filteredImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    return view
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  init() {
    super.init(frame: .zero)
    initialize()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  private func initialize() {
    filteredImageView.addToAndConstrain(insideSuper: contentView)
  }
  
}

//extension UIImageView {
//  public func imageFromUrl(urlString: String) {
//    if let url = URL(string: urlString) {
//      let request = URLRequest(url: url)
//      NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: .main, completionHandler: { (response, data, error) in
//        if let imageData = data as NSData? {
//          self.image = UIImage(data: imageData as Data)
//        }
//      })
//    }
//  }
//}
