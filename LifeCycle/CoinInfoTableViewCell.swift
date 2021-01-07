//
//  CoinInfoTableViewCell.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/08.
//

import UIKit

class CoinInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        coinName.adjustsFontSizeToFitWidth = true
        coinPrice.adjustsFontSizeToFitWidth = true
        coinSymbolLabel.layer.borderWidth = 1
    }
}
