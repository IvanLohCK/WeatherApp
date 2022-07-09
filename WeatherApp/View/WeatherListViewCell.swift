//
//  WeatherListViewCell.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import UIKit

class WeatherListViewCell: UITableViewCell {

    @IBOutlet weak var areaNameTxt: UILabel!
    @IBOutlet weak var regionNameTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .init(white: 1, alpha: 0.3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
