//
//  ReportCollectionViewCell.swift
//  DemoApp001
//
//  Created by Veer Suthar on 28/09/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageviewDamagedSide: UIImageView!
    @IBOutlet weak var labelDamagedTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func errorUI() {
        DispatchQueue.main.async { [weak self] in
            self?.imageviewDamagedSide.backgroundColor = .red
        }
    }
}

extension ReportCollectionViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let object = object as? DamagedImage else { return }
        DispatchQueue.main.async { [weak self] in
            self?.imageviewDamagedSide.image = object.image
            self?.labelDamagedTitle.text = "\(object.type.getTitle()) Side"
            if object.image != nil {
                self?.imageviewDamagedSide.backgroundColor = .black
            }
        }
    }
}
