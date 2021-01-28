//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let imageURL: URL = URL(string: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/kimetsu-no-yaiba-kamado-tanjiro-chapardeur.jpg")!

//#1
fileprivate func fetchImageClassic (){
    let queue = DispatchQueue(label: "myQueue1", qos: .utility, attributes: .concurrent)
    queue.async {
        if let data = try? Data(contentsOf: imageURL){
            DispatchQueue.main.async {
                importImage1.image = UIImage(data: data)
            }
        }
    }
}

//#2
fileprivate func fetchImageDispatchWorkItem () {
    var data: Data?
    let queue = DispatchQueue(label: "myQueue2", qos: .utility, attributes: .concurrent)
    let workItem = DispatchWorkItem {
        data = try? Data(contentsOf: imageURL)
    }
    workItem.notify(queue: .main) {
        if let imageData = data{
            importImage2.image = UIImage(data: imageData)
        }
    }
    queue.async(execute: workItem)
}

//#3
fileprivate func fetchImageURLSession() {
    let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
        if let imageData = data{
            DispatchQueue.main.async {
                importImage3.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}

var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 600))
var importImage1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var importImage2 = UIImageView(frame: CGRect(x: 0, y: 200, width: 200, height: 200))
var importImage3 = UIImageView(frame: CGRect(x: 0, y: 400, width: 200, height: 200))
importImage1.backgroundColor = .white
importImage2.backgroundColor = .gray
importImage3.backgroundColor = .black
importImage1.contentMode = .scaleAspectFit
importImage2.contentMode = .scaleAspectFit
importImage3.contentMode = .scaleAspectFit
view.addSubview(importImage1)
view.addSubview(importImage2)
view.addSubview(importImage3)
fetchImageClassic()
fetchImageURLSession()
fetchImageDispatchWorkItem()
PlaygroundPage.current.liveView = view
//: [Next](@next)
