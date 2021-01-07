//
//  MyCoinViewController.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/05.
//

import UIKit

class MyCoinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateInfromLabel: UILabel!
    @IBOutlet weak var coinMarketTableView: UITableView!
    let coins = ["btc", "dash", "ripple"]
    let price = [42383909, 5961, 369]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coinInfoCell = tableView.dequeueReusableCell(withIdentifier: "coinInfoCell", for: indexPath) as? CoinInfoTableViewCell
            else { return UITableViewCell() }
        coinInfoCell.coinName.text = coins[indexPath.row]
        coinInfoCell.coinSymbolLabel.text = "\(coins[indexPath.row])".capitalized
        coinInfoCell.coinPrice.text = "\(price[indexPath.row])"
        
        return coinInfoCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(someEventNotificationReceived(notification:)), name: Notification.Name(rawValue: "someeventname"), object: nil)
//        SceneDelegate().testVar = testLabel.text!
    }

    // 관심코인 수정 중 화면이 꺼질때 설정 저장
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MyCoin View viewWillDisappear")
//        NotificationCenter.default.addObserver(self, selector: #selector(disconneted), name: UIScene.willDeactivateNotification, object: nil)
//        print("Log", testLabel.text!)
        UserDefaults.standard.set("BitCoin", forKey: "myCoin")
        UserDefaults.standard.synchronize()
    }
    
    // 관심코인 수정 중 화면이 꺼질때 설정 저장
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MyCoin View viewDidDisappear")
        
    }
    
    @IBAction func deleteMyCoins(_ sender: Any) {
        
    }
    
    @IBAction func AddMyCoins(_ sender: Any) {
        
    }
    
    @objc func disconneted() {
        print("Test Message")
    }

    @objc func someEventNotificationReceived(notification: Notification) {
        if let value = notification.object as? String {
            print("DisLike")
        }
    }

    
    private func setupUI() {
        coinMarketTableView.delegate = self
        coinMarketTableView.dataSource = self
        coinMarketTableView.register(UINib(nibName: "CoinInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "coinInfoCell")
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "someeventname"), object: nil)
    }

}
