//
//  cicrleView.swift
//  testUIkit
//
//  Created by Damasya on 11/22/20.
//

import UIKit

class circleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = frame.width/2
    }
}
