import UIKit

@IBDesignable
class xibViewSample: UIView{
    @IBOutlet weak var clicks: UILabel!
    @IBAction func buttonClick(_ sender: Any) {
        clicksNumber += 1
    }
    var clicksNumber = 0{
        didSet{
            clicks.text = "click's: \(clicksNumber)"
        }
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
        let xibView = loadFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(xibView)
    }
    private func loadFromXib()->UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "xibViewSample", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
