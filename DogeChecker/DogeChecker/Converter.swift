//
//  Converter.swift
//  DogeChecker
//
//  Created by Anirudh Bharadwaj on 1/17/18.
//  Copyright © 2018 Anirudh Bharadwaj. All rights reserved.
//

import UIKit
struct Api: Decodable {
    let price_usd: String
    //init(json: [String: Any]) {
        //price_usd = json["price_usd"] as? String ?? "0.007"
    }

  let decoder = JSONDecoder()

class Converter: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var convertAmount: UITextField!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var usdWorth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        rate.text = ""
        usdWorth.text = ""
        let jsonUrlString = "https://api.coinmarketcap.com/v1/ticker/dogecoin/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let doge = try? decoder.decode([Api].self, from: data)
                if let doge = doge {
                    let dogeee = doge.first!
                    self.rate.text! = dogeee.price_usd
                }
            }
            catch let jsonErr{
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertAmount.resignFirstResponder()
        return (true)
    }
    
    }


    
    
    
    
    


