//
//  SortyCardView.swift
//  SortyCards
//
//  Created by Seref Bulbul on 30.08.2018.
//  Copyright © 2018 Seref Bulbul. All rights reserved.
//

import UIKit

class SortyCardView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var sortyCard: SortyCard?
    
    init(frame: CGRect, sortyCard: SortyCard) {
        super.init(frame: frame)
        
        commonInit(sortyCard: sortyCard)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit(sortyCard: SortyCard? = nil) {
        Bundle.main.loadNibNamed("SortyCardView", owner: self, options: nil)
        addSubview(self.contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.layer.cornerRadius = 10
        contentView.drawShadow()
        
        if let sortyCard = sortyCard {
            cardImageView.image = sortyCard.image
            self.tag = sortyCard.viewTag
        }
        
    }
    
}
