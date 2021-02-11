//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true //асинхронные запросы продолжают работать, даже когда main поток заканчивает свою работу

//ПРИМЕР 1 с космонавтами, получение данных из открытого api
struct AstronautsInfo: Decodable{
    let message: String
    let number: Int
    let people: [Astronaut]
}
struct Astronaut: Decodable{
    let name: String
    let craft: String
}

func fetchData(){
    let url = URL(string: "http://api.open-notify.org/astros.json")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard error == nil else {
            print(error?.localizedDescription ?? "no description")
            return
        }
        if let response = response as? HTTPURLResponse{
            switch response.statusCode {
            case 200..<300:
                break
            default:
                print(response.statusCode)
            }
        }
        guard data != nil else {return}
        guard let humansInSpace = try? JSONDecoder().decode(AstronautsInfo.self, from: data!) else {
            print("error: can't parse info")
            return
        }
        print("\n\tПРИМЕР 1:")
        print("There are \(humansInSpace.number) humans in space")
        let uniqueSpacecrafts = Set(humansInSpace.people.map{$0.craft})
        print("Spacecrafts: \(uniqueSpacecrafts.joined(separator: ","))")
        let astronautsNames = Array(humansInSpace.people.map{$0.name})
        print("Names: \n", astronautsNames.joined(separator: ",\n"))
    }
    task.resume()
}
fetchData()

//ПРИМЕР 2 простое кодирование и декодирование
let jsonString = """
{
    "firstName": "Geralt",
    "last_name":  "Gwynbleidd",
    "homeland":    "of Rivia"
}
"""
struct User: Codable {
    var firstName: String
    var lastName: String
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName = "last_name"
        case country = "homeland"
    }
}
func decodeFromString(){
    guard let jsonData = jsonString.data(using: .utf8) else { // Respond to error
        return }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let user = try JSONDecoder().decode(User.self, from: jsonData)
        print(user.firstName)
        print(user.country)
    } catch {
        print(error.localizedDescription)
    }
}

func encodeToString(){
    let user = User(firstName: "Bob", lastName: "and Alice", country: "England")
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.keyEncodingStrategy = .convertToSnakeCase
    
    do {
        let jsonData = try encoder.encode(user)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print(error.localizedDescription)
    }
}
print("\n\tПРИМЕР 2:")
decodeFromString()
encodeToString()

//ПРИМЕР 3 использование вложенных типов в случае с более сложной JSON структурой
let jsonStringComplex = """
{
    "users":
    [
        {
            "first_name": "Arthur",
            "last_name": "Dent"
        }, {
            "first_name": "Zaphod",
            "last_name": "Beeblebrox"
        }, {
            "first_name": "Marvin",
            "last_name": "Forest"
        }
    ]
}
"""
struct Response: Codable//Использование вложенных типов - отличный универсальный подход к сложным структурам данных JSON
{
    struct User: Codable {
        var first_name: String
        var last_name: String
    }
    var users: [User]?
}

func encode(){//в случае, если бы у нас просто был массив объектов User в JSON, то .. .decode([User].self, from..)
    guard let jsonData = jsonStringComplex.data(using: .utf8) else { return }
    guard let response = try? JSONDecoder().decode(Response.self, from: jsonData)
    else {
        print("error: can't parse info")
        return
    }
    guard response.users != nil else {print("nil")
        return}
    for user in response.users! {
        print(user.first_name, user.last_name)
    }
}
print("\n\tПРИМЕР 3:")
encode()
//: [Next](@next)
