import UIKit

@IBDesignable
class xib: UIView{
    
    @IBOutlet weak var clicks: UILabel!
    var clicksNumber = 0{
        didSet{
            clicks.text = "click's number: \(clicksNumber)"
        }
    }
    @IBAction func buttonClick(_ sender: Any) {
        clicksNumber += 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView(){
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    private func loadViewFromXib()->UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "xib", bundle: bundle)
        let view =  nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
