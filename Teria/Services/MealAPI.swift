import Foundation
import Alamofire
import SwiftyJSON

struct MealAPI {
    static func getSchool(schoolName: String, completion: @escaping (JSON) -> ()) {
        let _url = "https://open.neis.go.kr/hub/schoolInfo?Type=json&key=d374573af8d34cddaf4e4c250b995c8c&SCHUL_NM=" + schoolName
        let encoded = _url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let url = URL(string: encoded)!
      
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type": "application/json"]
      )
      .validate()
      .responseData { response in
          switch response.result {
          case .success(let value):
              let json = JSON(value)
              let result = json["schoolInfo"][1]["row"][0]
              completion(result)
              
          case .failure(let error):
              print(error)
          }
      }
    }
}
