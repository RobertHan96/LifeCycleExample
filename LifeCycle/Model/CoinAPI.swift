//
//  API.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/08.
//

import Foundation
import SwiftyJSON
import Alamofire

struct CoinAPI {
    let baseUrl = "https://api.bithumb.com/public/orderbook/all_krw"
    let defaultCoins : [String] = ["BTC", "ETH", "BSV", "BCH", "XRP", "EOS", "LTC", "XLM", "ANW", "QTUM", "TRX", "BCD" ]
    
    
    func sendRequest(completion:@escaping ([Coin]) -> Void, isMyCoin: Bool?) {
        AF.request(baseUrl, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            switch(response.result) {
            case .success(_) :
                if let data = response.value {
                    print("Log - 코인 가격정보 조회 성공")
                    if isMyCoin == false {
                        let coinData = self.getCoinDataFromJson(inputData: response.data!)
                        completion(coinData)
                    } else {
                        let coinData = self.getMyCoinFromJson(inputData: response.data!)
                        completion(coinData)
                    }
                }
                break ;
            case .failure(_):
                print("Log - 코인 가격정보 조회 실패", response.result)
                break;

            }
        }
    }
    
    func getCoinDataFromJson(inputData : Data?) -> [Coin] {
        let defaultCoin = [Coin(name: "C", price: 100)]
        var coins : [Coin] = []
        guard let data = inputData else { return defaultCoin }
        guard let jsonData = try? JSON(data: data) else { return defaultCoin }
        let json = jsonData["data"]
        
        for (key,subJson):(String?, JSON?) in json {
            let coinName = subJson?["order_currency"].stringValue
            
            if defaultCoins.contains(coinName!) {
                let name = subJson!["order_currency"].stringValue
                let price = subJson!["bids"][0]["price"].floatValue
                let currentCoin = Coin(name: name, price: price)
                coins.append(currentCoin)
                coins.sort { (coin1, coin2) -> Bool in
                    return coin1.price > coin2.price
                }
            }
        }
        
//        for (key,subJson):(String?, JSON?) in json {
//            if let coin = subJson?["order_currency"] {
//                let name = subJson!["order_currency"].stringValue
//                let price = subJson!["bids"][0]["price"].floatValue
//                let currentCoin = Coin(name: name, price: price)
//                coins.append(currentCoin)
//                coins.sort { (coin1, coin2) -> Bool in
//                    return coin1.price > coin2.price
//                }
//            }
//        }
        return coins
    }
    
    func getMyCoinFromJson(inputData : Data?) -> [Coin] {
        let defaultCoins = [Coin(name: "C", price: 100)]
        var coins : [Coin] = []
        guard let data = inputData else { return defaultCoins }
        guard let jsonData = try? JSON(data: data) else { return defaultCoins }
        let json = jsonData["data"]
        let myCoin = MyCoin.shared.getMyCoinFromUserDefault()
        print("Log - ", myCoin)

        for (key,subJson):(String?, JSON?) in json {
            let coin = subJson?["order_currency"].stringValue
            if ((myCoin?.contains(coin!)) != nil)   {
                let name = subJson!["order_currency"].stringValue
                let price = subJson!["bids"][0]["price"].floatValue
                let currentCoin = Coin(name: name, price: price)
                coins.append(currentCoin)
                coins.sort { (coin1, coin2) -> Bool in
                    return coin1.price > coin2.price
                }
            }
        }
        return coins
    }
    
 
}
