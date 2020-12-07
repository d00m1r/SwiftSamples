//
//  ViewController.swift
//  testUIkit
//
//  Created by Damasya on 11/22/20.
//

import UIKit

class TapButtonViewController: VCLLoggingViewController {
    
    var clicksNumber = 0{
        didSet{
            clicks.text = "clicks: \(clicksNumber)"
        }
    }
    
    let blueCircleView = circleView()
    
    @IBOutlet weak var clicks: UILabel!
    @IBOutlet weak var heightOfGrayView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blueCircleView)
        blueCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        blueCircleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        blueCircleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @IBAction func ButtonClick(_ sender: UIButton) {
        clicksNumber += 1
        
        if blueCircleView.alpha == 1.0{
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveLinear,
                                                           animations: {self.blueCircleView.alpha = 0},
                                                           completion: {if $0 == .end {self.blueCircleView.alpha = 0} })
        }else{
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveLinear,
                                                           animations: {self.blueCircleView.alpha = 1},
                                                           completion: {if $0 == .end {self.blueCircleView.alpha = 1} })
        }
        if(self.heightOfGrayView.constant == 100){
            self.heightOfGrayView.constant = 300
        }else{
            self.heightOfGrayView.constant = 100
        }
        UIView.animate(withDuration: 1) {//анимируем по constraint, а не по frame
            self.view.layoutIfNeeded()
        }
    }
}
