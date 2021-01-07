//
//  ViewController.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/05.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateInformLabel: UILabel!
    @IBOutlet weak var coinMarketTableView: UITableView!
    let coins = ["btc", "dash", "ripple"]
    let price = [42383909, 5961, 369]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coinInfoCell = tableView.dequeueReusableCell(withIdentifier: "coinInfoCell", for: indexPath) as? CoinInfoTableViewCell
            else { return UITableViewCell() }
        let coinName = coins[indexPath.row]
        let coinPrice = price[indexPath.row]
        coinInfoCell.coinName.text = coinName
        coinInfoCell.coinSymbolLabel.text = String(coinName.first ?? "B").capitalized
        coinInfoCell.coinPrice.text = "₩\(coinPrice)"
        
        return coinInfoCell
    }

    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    // 시세 정보 로딩
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("viewDidLoad")
    }
    
    // 시세 정보 갱신
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    // 로딩 완료 애니메이션
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    private func setupUI() {
        coinMarketTableView.delegate = self
        coinMarketTableView.dataSource = self
        coinMarketTableView.register(UINib(nibName: "CoinInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "coinInfoCell")
    }
    
}

