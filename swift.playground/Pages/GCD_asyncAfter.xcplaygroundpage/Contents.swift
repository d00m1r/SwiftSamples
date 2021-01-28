//: [Previous](@previous)
// AfterBlock : готовый шаблон выполнения кода в отедельном потоке спустя некоторое время
// concurrentPerform : позволяет выполнить итеративно одну и туже closure ПАРАЛЛЕЛЬНО в любых доступных(свободных) потоках
// inactiveQueue : управление очередью (приостановка/запуск)
import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc1"
        view.backgroundColor = .white
        let seconds = 5
        afterBlock(seconds: seconds) {
            print("afterBlock's working after \(seconds) secs")
            //self.showAlert() не работает в playground
            print(Thread.current)
        }
    }
    private func showAlert(){
        let alert = UIAlertController(title: nil, message: "hello there", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    private func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(),complition: @escaping ()->()){
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
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
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc2"
        view.backgroundColor = .white
        
////        for i in 0...10000{ // UI зависает, т.к. выполняется в main потоке
////            print(i)
////        }
//        DispatchQueue.global().async { // исключаем main из "пачки" доступных потоков
//            DispatchQueue.concurrentPerform(iterations: 10000) {
//                print($0)
//                print(Thread.current)
//            }
//            print(Thread.current)
//        }
        myInactiveQueue()
    }
    
    private func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "MyQueue", attributes: [.concurrent, .initiallyInactive])
        inactiveQueue.async {//*
            for i in 0...10{
                print(i)
            }
        }
        print("not started")
        inactiveQueue.activate()//запуск *
        print("queue was activate")
        inactiveQueue.suspend()
        print("pause")
        inactiveQueue.resume()
        print("resume")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.center = view.center
        label.text = "hello there"
        label.backgroundColor = .green
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30.0)
        view.addSubview(label)
    }
}

let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)
PlaygroundPage.current.liveView = navBar

//: [Next](@next)
