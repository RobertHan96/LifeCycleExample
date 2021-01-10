//
//  MyCoinViewController.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/05.
//

import UIKit
import DropDown

class MyCoinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateInfromLabel: UILabel!
    @IBOutlet weak var coinMarketTableView: UITableView!
    var coins : [Coin] = []
    let myCoinInstance = MyCoin.shared

    
    private func reloadCoinData() {
        CoinAPI().sendRequest (completion: { (coin) in
            self.coins = coin
            self.coinMarketTableView.reloadData()
        }, isMyCoin: true)
    }

    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    // 시세 정보 로딩
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadCoinData()
        setupUI()
        print("viewDidLoad")
    }
    
    // 시세 정보 갱신
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        reloadCoinData()
        print("viewWillAppear")
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
    
    @IBAction func addMyCoin(_ sender: Any) {
        addMyCoin()
    }
    
    private func addMyCoin() {
        let dropdown = DropDown()
        let coinName = ["BTC", "ETH", "BSV"]
        dropdown.dataSource = coinName
        dropdown.anchorView = coinMarketTableView
        dropdown.selectedTextColor = .blue
        dropdown.show()
        
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            // 중복 체크
            // 모든 코인 영문으로 옮기기 작업
            var myCoin = myCoinInstance.getMyCoinFromUserDefault() as! [String]
            myCoin.append(item)
            myCoinInstance.setMyCoinToUserDefault(data: myCoin)
            print("Log - UserDefaults에 \(item) 코인 추가 완료")
            print(myCoin)
        }
        
    }
    
    func getMyCoinFromUserDefault() -> [String]? {
        let coin : [String]? = UserDefaults.standard.object(forKey: "myCoin") as? [String]
        return coin
    }

    func setMyCoinToUserDefault(data : [String] ) {
        UserDefaults.standard.set(data, forKey: "myCoin")
        UserDefaults.standard.synchronize()
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

extension MyCoinViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coinInfoCell = tableView.dequeueReusableCell(withIdentifier: "coinInfoCell", for: indexPath) as? CoinInfoTableViewCell
            else { return UITableViewCell() }
        let coinName = coins[indexPath.row].name
        let coinPrice = coins[indexPath.row].price
        coinInfoCell.coinName.text = coinName
        coinInfoCell.coinSymbolLabel.text = String(coinName.first ?? "B").capitalized
        coinInfoCell.coinPrice.text = "₩\(coinPrice)"
        
        return coinInfoCell
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
//            try? self.realm.write {
//                self.realm.delete((self.DateArrary?[indexPath.row])!)
//                self.historyTableVeiw.reloadData()
//            }
//
//        }
//        deleteAction.backgroundColor = .red
//        return [deleteAction]
//    }
}
