//
//  PhotoCollectionViewCell.swift
//  WizTest
//
//  Created by Yael Bilu Eran on 14/12/2020.
//

import UIKit
import Kingfisher

protocol PhotoCellDelegate : class {
    func shareButtonTapped(cell: PhotoCollectionViewCell)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoUrl : String?
    weak var delegate : PhotoCellDelegate?
    static let identifier: String = "PhotoCollectionViewCell"
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoUrl = nil
        photoImageView.image = nil
    }
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: Bundle(for: self))
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func setUp(with photo:Photo) -> Void {
        if let imageUrl = photo.webformatURL, let url = URL(string: imageUrl) {
            photoUrl = imageUrl
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { [weak self] (image, error, cacheType, resourceUrl) in
                if resourceUrl?.absoluteString == self?.photoUrl {
                    self?.photoImageView.image = image
                }
            }
        }
    }
}

