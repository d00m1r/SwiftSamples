//: [Previous](@previous)

import UIKit
import PlaygroundSupport

class MyViewController: UIViewController{
    let data = Array(1...100)
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), style: .grouped)
        
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    
    }
}
extension MyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        if indexPath.row == 0{
            cell.accessoryType = .detailButton
        }
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("hello there")
    }
}
class TableViewCell: UITableViewCell{}

PlaygroundPage.current.liveView = MyViewController()

//: [Next](@next)
