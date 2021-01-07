//: A UIKit based Playground for presenting user interface
//https://stackoverflow.com/questions/26180822/how-to-add-constraints-programmatically-using-swift
//ссылка на размещение с помощью autolayout программно(разные способы)
import UIKit
import PlaygroundSupport

class SimpleView: UIView {
    
    var isReversed = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    private let greenSubview: UIView = UIView(frame: .zero)
    private let tintSubview: UIView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        isHidden = false
        alpha = 1.0
        clipsToBounds = true
        
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        isExclusiveTouch = true
        
        let anotherView = UIView(frame: .zero)
        insertSubview(anotherView, at: 0)
        bringSubviewToFront(anotherView)
        
        anotherView.removeFromSuperview()
        
        greenSubview.backgroundColor = .green
        tintSubview.backgroundColor = tintColor
        
        greenSubview.frame = CGRect(x: 5.0, y: 5.0, width: 10.0, height: 7.0)
        tintSubview.frame = CGRect(x: 15.0, y: 15.0, width: 5.0, height: 15.0)
        
        addSubview(greenSubview)
        addSubview(tintSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        print("awakeFromNib()")
        super.awakeFromNib()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        print("willMove(toSuperview:)")
        super.willMove(toSuperview: newSuperview)
    }
    
    override func didMoveToSuperview() {
        print("didMoveToSuperview()")
        super.didMoveToSuperview()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        print("willMove(toWindow:)")
        super.willMove(toWindow: newWindow)
    }
    
    override func didMoveToWindow() {
        print("didMoveToWindow()")
        super.didMoveToWindow()
    }
    
    override func removeFromSuperview() {
        print("removeFromSuperview()")
        super.removeFromSuperview()
    }
    
    override func setNeedsLayout() {
        print("setNeedsLayout()")
        super.setNeedsLayout()
    }
    override func layoutIfNeeded() {
        print("layoutIfNeeded()")
        super.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        print("layoutSubviews()")
        super.layoutSubviews()
        
        if isReversed {
            greenSubview.frame = CGRect(x: 5.0, y: 5.0, width: 10.0, height: 7.0)
            tintSubview.frame = CGRect(x: 15.0, y: 15.0, width: 5.0, height: 15.0)
        } else {
            tintSubview.frame = CGRect(x: 5.0, y: 5.0, width: 10.0, height: 7.0)
            greenSubview.frame = CGRect(x: 15.0, y: 15.0, width: 5.0, height: 15.0)
        }
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("draw()")
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.red.cgColor)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(4.0)
            context.addEllipse(in: CGRect(x: 100.0, y: 2.0, width: 20.0, height: 30.0))
            context.drawPath(using: .fillStroke)
        }
    }
    
    override func setNeedsDisplay() {
        print("setNeedsDisplay()")
        super.setNeedsDisplay()
    }
    
    override func setNeedsDisplay(_ rect: CGRect) {
        print("setNeedsDisplay(_ rect:)")
        super.setNeedsDisplay(rect)
    }
    
    override func tintColorDidChange() {
        print("tintColorDidChange()")
        super.tintColorDidChange()
        
        tintSubview.backgroundColor = tintColor
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("hitTest()")
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("point()")
        return super.point(inside: point, with: event)
    }
}

class MyViewController : UIViewController {
    var clicks = 0{
        didSet{
            clicksLabel.text = "click's: \(clicks)"
        }
    }
    let clicksLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    let simpleView: SimpleView = {
        let view = SimpleView(frame: CGRect(x: 50.0, y: 50, width: 150.0, height: 70.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (reverseButton, tintColorButton) = initButtons()
        
        //let clicksLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        clicksLabel.text = "click's: \(clicks)"
        clicksLabel.backgroundColor = .lightGray
        
        self.view.addSubview(clicksLabel)
        self.view.addSubview(reverseButton)
        self.view.addSubview(tintColorButton)
        
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reverseButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reverseButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        reverseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tintColorButton.translatesAutoresizingMaskIntoConstraints = false
        tintColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tintColorButton.topAnchor.constraint(equalTo: reverseButton.bottomAnchor, constant: 20).isActive = true
        tintColorButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        tintColorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func initButtons() -> (UIButton, UIButton) {
        let reverseButton = UIButton(frame: CGRect(x: 20, y: 150, width: 200, height: 50))
        reverseButton.setTitle("reverse button", for: .normal)
        reverseButton.backgroundColor = .lightGray
        reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
        
        let tintColorButton = UIButton(frame: CGRect(x: 240, y: 150, width: 200, height: 50))
        tintColorButton.setTitle("tint color", for: .normal)
        tintColorButton.backgroundColor = .lightGray
        tintColorButton.addTarget(self, action: #selector(changeTintColorButtonPressed), for: .touchUpInside)
        
        return (reverseButton, tintColorButton)
    }
    @objc func reverseButtonPressed(_ sender: UIButton) {
        self.clicks += 1
        simpleView.isReversed = !simpleView.isReversed
    }
    @objc func changeTintColorButtonPressed(_ sender: UIButton) {
        self.clicks += 1
        if view.tintColor == .red {
            view.tintColor = .green
        } else {
            view.tintColor = .red
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(simpleView)
    }
    
    override func viewDidLayoutSubviews() {//views заданы, повороты и тд
        super.viewDidLayoutSubviews()
        //simpleView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        //simpleView.transform = CGAffineTransform(rotationAngle: 0.5).concatenating(CGAffineTransform(scaleX: 0.1, y: 0.1))
        //simpleView.transform = CGAffineTransform.identity
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
