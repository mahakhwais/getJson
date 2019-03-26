//
//  ViewController.swift
//  GetJson
//
//  Created by sss123 on 3/24/19.
//  Copyright © 2019 sss123. All rights reserved.
//

import UIKit

class ViewController:UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    // final let url = URL(string:"http://192.168.1.114:8090/meal/get-all")
   // var arrDishes = [Dishes]()
    
    var nameArray = [String]()
    var priceArray = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.namelabel.text = nameArray[indexPath.row]
        cell.pricelabel.text = "\(priceArray[indexPath.row])"
      
        return cell
    }
    
    func getData(){
      //  guard let downloadURL = url else {return}
        guard let url = URL(string:"http://192.168.1.114:8090/meal/get-all") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           // print("*2 \(data)")
            guard let responseData = data,response != nil ,error == nil else {
                print("sth is wrong !!!")
                return
            }
            if let jsonObj = try? JSONSerialization.jsonObject(with: responseData, options:.allowFragments) as? NSDictionary{
                print("******")
                print(jsonObj?.allValues as Any)
                if let dishArray = jsonObj?.value(forKey: "list") as? NSArray {
                    for dish in dishArray {
                        if let dicDish = dish as? NSDictionary{
                            if let name = dicDish.value(forKey: "name"){
                            self.nameArray.append(name as! String)
                            }
                            if let price = dicDish.value(forKey: "price"){
                                self.priceArray.append(price as! Double)
                            }
                            OperationQueue.main.addOperation({
                                self.tableView.reloadData()
                            })
                            
                            
                            print("namearray \(self.nameArray)")
                            print("pricearray \(self.priceArray)")
                }
                
              //  print(jsonObj?.value(forKey: "list"))
                }}
            }
           /* do{
                print("*3 \(responseData)")
                let arrDishess = try JSONDecoder().decode(Dishes.self, from: responseData)
                print ("downloaded")
            
        }catch{
                print("sth after download is wrong \(responseData)")
            }
            */
        }.resume()
    }
}



