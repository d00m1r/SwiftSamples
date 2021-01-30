//: [Previous](@previous)
//DispatchGroup позволяет реализовать ожидание основанное на счетчике, который можно увеличивать и уменьшать с разных потоков
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class DispatchGroupTest1 {
    let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)
    let groupA = DispatchGroup()
    
    func loadInfo (){
        groupA.notify(queue: .main){//если вызвать на той же очереди, то выполнится сразу
            print("A was finished", Thread.current)
        }
        self.groupA.enter()//счетчик groupA + 1
        queue.async {
            sleep(1)
            print("A: 1", Thread.current)
            self.groupA.leave()//счетчик groupA - 1
        }
        
        self.groupA.enter()
        queue.async {
            sleep(1)
            print("A: 2",Thread.current)
            self.groupA.leave()
        }
        
        groupA.wait()//ждет когда счетчик groupА обнулится
        print("A finish", Thread.current)
    }
}
DispatchGroupTest1().loadInfo()

//Подгружаем изображения группой
let imageURLs = ["https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/kimetsu-no-yaiba-kamado-tanjiro-chapardeur.jpg", "https://i.pinimg.com/564x/f1/f6/45/f1f645b150647ff57316b3b375227725.jpg","https://images-na.ssl-images-amazon.com/images/I/61aaBviAFLL._AC_SL1334_.jpg","https://i.pinimg.com/originals/35/99/8e/35998eb2055f916097a584862dfc8545.jpg"]
var images = [UIImage]()
var view = EightImages(frame: CGRect(x: 0, y: 0, width: 200, height: 400))

class EightImages: UIView {
    var imagesViews = [UIImageView]()
    override init(frame: CGRect){
        super.init(frame: frame)
        imagesViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        imagesViews.append(UIImageView(frame: CGRect(x: 0, y: 200, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 100, y: 200, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        imagesViews.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        
        for i in 0...7{
            imagesViews[i].backgroundColor = .gray
            imagesViews[i].contentMode = .scaleAspectFit
            self.addSubview(imagesViews[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    complitionQueue: DispatchQueue,
                    complition: @escaping (UIImage?, Error?)->()){
    runQueue.async {
        do{
            let data = try Data(contentsOf: imageURL)
            complitionQueue.async { complition(UIImage(data: data), nil) }
        } catch let error { complitionQueue.async { complition(nil,  error) } }
    }
}
func asyncGroup(){
    let group = DispatchGroup()
    for i in 0...3 {
        group.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!, runQueue: .global(qos: .utility), complitionQueue: .main) { (image, error) in
            guard let result = image else { return }
            images.append(result)
            group.leave()
        }
    }
    group.notify(queue: .main){
        for i in 0...3{
            view.imagesViews[i].image = images[i]
        }
    }
}

func asyncURLSession(){
    for i in 4...7{
        let url = URL(string:imageURLs[i-4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async{
                view.imagesViews[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
asyncGroup()
asyncURLSession()
PlaygroundPage.current.liveView = view
//: [Next](@next)
