//
//  MyTableViewController.swift
//  testUIkit
//
//  Created by Damasya on 11/26/20.
//

import UIKit

class MyTable: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //кол-во элементов для каждой из секций
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //надо вернуть объект для отображения n-ной ячейки таблицы
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")! as UITableViewCell
        cell.textLabel!.text = "Строка #\(indexPath.item)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //а это вызывается если юзер кликнул по какой-то ячейке
        performSegue(withIdentifier: "toDetail", sender: indexPath.item)//отправителем мы задали номер ячейки, а можно любой объект
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //а здесь нао вернуть кол-во секций(для простой таблицы это 1)
        return 1
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//вызывается перед кадым показом Detail
        let vc = segue.destination as! CellDetail
        let id = sender as! Int//сохраним отправителя в поле такого же типа в Detail
        vc.id = id
    }
}
