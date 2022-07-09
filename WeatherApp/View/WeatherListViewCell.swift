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
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
