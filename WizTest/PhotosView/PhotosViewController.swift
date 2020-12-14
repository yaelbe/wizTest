//
//  PhotosViewController.swift
//  WizTest
//
//  Created by Yael Bilu Eran on 14/12/2020.
//


import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //TODO: need to add this to view model
    private lazy var photos = [Photo]()
    private var currentPage: Int = 1
    private var lastCount = 0

    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pixabay Gallery"
        NetworkService.shared.startNetworkReachabilityObserver()
//        photosCollectionView.collectionViewLayout = LeftAlignFlowLayout()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        getPhotos(completion: nil)
    }
    
    //TODO: need to add this to view model
    func getPhotos(completion: ((_ success: Bool) -> Void)?) -> Void {
        //guard let searchText = searchText else { return }
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        PhotosService.shared.getPhotos(page: currentPage, completion: { [weak self] photos , success in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            if self?.currentPage == 1 {
                if((self?.photos.count ?? 0) > 0){ //scroll to start if this is a new serch
                    self?.photosCollectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                }
                self?.photos.removeAll()
                
            }
            self?.lastCount = photos.count
            self?.photos.append(contentsOf: photos)
            if self?.currentPage == 1 {
                self?.photosCollectionView?.reloadData()
            } else {
                self?.insertPhotos()
            }
            
            if(!success){
                let alert = UIAlertController(title: "No Internet Connection", message: "Retry later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK 👍", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
            completion?(success)
        })
        
    }
    
    private func insertPhotos()  {
        var indexPaths = [IndexPath]()
        for i in self.lastCount..<photos.count {
            let indexPath = IndexPath(item: i, section: 0)
            indexPaths.append(indexPath)
        }
        photosCollectionView?.insertItems(at: indexPaths)
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.delegate = self
        
        cell.setUp(with: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchReusableView", for: indexPath)
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (photos.count - 4) {
            currentPage += 1
            getPhotos(completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let numberOfRows = 5
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let totalSpace = flowLayout.sectionInset.top
                + flowLayout.sectionInset.bottom
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfRows - 1))
            let size = (collectionView.bounds.height - totalSpace) / CGFloat(numberOfRows)
            let currentPhoto = photos[indexPath.row]
            let width = CGFloat(currentPhoto.webformatWidth ?? 1)
            let height = CGFloat(currentPhoto.webformatHeight ?? 1)
            let ratio = CGFloat(width/height)
            
            return CGSize(width: Int(size * ratio), height: Int(size))
        } else {
            // default size.
            return CGSize(width: 90, height: 90)
        }
    }
}


extension PhotosViewController: PhotoCellDelegate {
    func shareButtonTapped(cell: PhotoCollectionViewCell) {
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [cell.photoUrl ?? "Share"], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}



