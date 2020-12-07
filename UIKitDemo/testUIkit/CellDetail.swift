//
//  DetailCell.swift
//  testUIkit
//
//  Created by Damasya on 11/27/20.
//
import UIKit

class CellDetail: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        id = 0
        super.init(coder: aDecoder)
    }
    
    var id: Int //для передачи id в объект нашего view при переходе
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        idDetail.text = "\(id)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
