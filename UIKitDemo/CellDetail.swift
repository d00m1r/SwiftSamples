//
//  CellDetail.swift
//  testUIkit
//
//  Created by Damasya on 11/27/20.
//

import UIKit

class CellDetail: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var idDetail: UILabel!
    
    var id: Int = 0 //для передачи id в объект нашего view при переходе
    
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
