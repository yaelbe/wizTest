////
////  PhotosViewModel.swift
////  WizTest
////
////  Created by Yael Bilu Eran on 14/12/2020.
////
//
//import Foundation
//
//class PhotosViewModel {
//    
//    private lazy var photos = [Photo]()
//    private var currentPage: Int = 1
//    private var lastCount = 0
//    
//    var photosCount: Int {
//        return photos.count
//    }
//    
//    func getPhoto(at index: Int) -> Photo {
//        return photos[index]
//    }
//    
//    func getPhotos(completion: ((_ success: Bool) -> Void)?) -> Void {
//        //guard let searchText = searchText else { return }
//        
//        PhotosService.shared.getPhotos(page: currentPage, completion: { [weak self] photos , success in
//            if self?.currentPage == 1 {
//                if((self?.photos.count ?? 0) > 0){ //scroll to start if this is a new serch
//                    self?.photosCollectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
//                }
//                self?.photos.removeAll()
//                
//            }
//            self?.lastCount = photos.count
//            self?.photos.append(contentsOf: photos)
//            if self?.currentPage == 1 {
//                self?.photosCollectionView?.reloadData()
//            } else {
//                self?.insertPhotos()
//            }
//            
//            if(!success){
//                let alert = UIAlertController(title: "No Internet Connection", message: "Retry later", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK 👍", style: .default, handler: nil))
//                self?.present(alert, animated: true)
//            }
//            completion?(success)
//        })
//        
//    }
//    
//    private func insertPhotos()  {
//        var indexPaths = [IndexPath]()
//        for i in self.lastCount..<photos.count {
//            let indexPath = IndexPath(item: i, section: 0)
//            indexPaths.append(indexPath)
//        }
//        photosCollectionView?.insertItems(at: indexPaths)
//    }
//}
//
