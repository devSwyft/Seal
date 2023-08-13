import Foundation
import Alamofire
import SwiftyJSON

struct MealService {
    static func getSchool(schoolName: String, completion: @escaping (JSON) -> ()) {
        let _url = "https://open.neis.go.kr/hub/schoolInfo?Type=json&key=d374573af8d34cddaf4e4c250b995c8c&SCHUL_NM=\(schoolName)"
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
    
    static func getMeal(ATPT_OFCDC_SC_CODE: String, SD_SCHUL_CODE: String, completion: @escaping (JSON) -> ()) {
        let date = DateService.getToday()
        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&key=d374573af8d34cddaf4e4c250b995c8c&ATPT_OFCDC_SC_CODE=\(ATPT_OFCDC_SC_CODE)&SD_SCHUL_CODE=\(SD_SCHUL_CODE)&MLSV_YMD=\(date)"

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
                let result = json["mealServiceDietInfo"][1]["row"]
                completion(result)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Test
//    static func getMeal(ATPT_OFCDC_SC_CODE: String, SD_SCHUL_CODE: String, completion: @escaping (JSON) -> ()) {
//        let url = "https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&key=d374573af8d34cddaf4e4c250b995c8c&ATPT_OFCDC_SC_CODE=\(ATPT_OFCDC_SC_CODE)&SD_SCHUL_CODE=\(SD_SCHUL_CODE)&MLSV_YMD=20230718"
//
//        AF.request(url,
//                   method: .get,
//                   encoding: URLEncoding.default,
//                   headers: ["Content-Type": "application/json"]
//        )
//        .validate()
//        .responseData { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let result = json["mealServiceDietInfo"][1]["row"]
//                completion(result)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
