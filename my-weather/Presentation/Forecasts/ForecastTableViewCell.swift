//
//  ForecastTableViewCell.swift
//  my-weather
//
//  Created by Romain Roche on 25/11/2024.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet
    private var dateLabel: UILabel!
    
    @IBOutlet
    private var weatherLabel: UILabel!
    
    @IBOutlet
    private var weatherNameLabel: UILabel!
    
    private func setup() {
        // TODO: Set labels fonts, colors... etc.
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: WeatherUIItem) {
        // TODO: Set values
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        weatherLabel.text = nil
        weatherNameLabel.text = nil
    }

}
