//: [Previous](@previous)

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc1"
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initButton()
    }
    
    private func initButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = self.view.center
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitle("press me", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc private func buttonAction() {
        print("hello there")
        self.navigationController?.pushViewController(MySecondViewController(), animated: true)
        
    }
}

class MySecondViewController: UIViewController {
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc2"
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initImage()
    }
    private func loadImage() {
        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func initImage() {
        imageView.frame = CGRect(x: 0, y: 0, width: 350, height: 400)
        imageView.center = view.center
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
}

let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)
PlaygroundPage.current.liveView = navBar
//: [Next](@next)
