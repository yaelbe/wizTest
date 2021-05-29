//
//  PhotosService.swift
//  WizTest
//
//  Created by Yael Bilu Eran on 14/12/2020.
//


import Alamofire


class PhotosService {
    
    static let shared = PhotosService()
    
    let apiKeyValue : String
    let pixabayApi  : String
    let limit       : Int
    
    let apiKey         = "key"
    let textKey        = "q"
    let perPageKey     = "per_page"
    let pageKey        = "page"
    
    init() {
        guard let secretConstantsPlistFilePath: String = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
              let config: [String: AnyObject] = NSDictionary(contentsOfFile: secretConstantsPlistFilePath) as? [String : AnyObject],
              let apisecretKeyValue = config["PixabaySdkApiKey"] as? String,
              let apiBaseurl = config["api"] as? String,
              let apiLimit = config["limit"] as? Int
        else { fatalError("No way! The app must have this plist file with the mandatory keys") }
        
        pixabayApi  = apiBaseurl
        apiKeyValue = apisecretKeyValue
        limit       = apiLimit
    }
    
    func getPhotos(page: Int, completion: @escaping (_ photos: [Photo], _ sucsses:Bool)->Void) {
        
        let parameters : [String: Any] = [
            apiKey:             apiKeyValue,
            perPageKey:         limit,
            pageKey:            page
        ]
        
        if (!NetworkService.shared.isNetworkReachable()){
            completion([],false)
            return
        }
        
        AF.request(pixabayApi, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                guard let results = value as? [String: Any],
                      let photosArray = results["hits"] as? [[String:Any]]
                else {
                    completion([],false)
                    return }
                completion(photosArray.map({ Photo(with: $0) }), true)
            case .failure(let error):
                print(error)
                completion([],false)
            }
        }
    }
}

