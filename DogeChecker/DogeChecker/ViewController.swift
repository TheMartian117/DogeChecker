//
//  ViewController.swift
//  DogeChecker
//
//  Created by Anirudh Bharadwaj on 1/16/18.
//  Copyright © 2018 Anirudh Bharadwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    struct Data {
        let balance: String
        init(json: [String: Any]) {
            balance = json["balance"] as? String ?? "244"
        }
    }
    
    @IBOutlet weak var Ð: UILabel!
    @IBOutlet weak var curbalance: UILabel!
    @IBOutlet weak var address: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        curbalance.text = ""
        Ð.text = ""
        self.address.delegate = self
    }
    @IBAction func Balance(_ sender: UIButton) {

        let jsonUrlString = "https://dogechain.info/api/v1/address/balance/\(address.text ?? "D66237RqYLpgmhRJK8p2mFppFuyr3LmJXF")"
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let stuff = Data(json: json as! [String : Any] )
                self.curbalance.text = stuff.balance
                self.Ð.text = "Ð"
            }
            catch let jsonErr{
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        address.resignFirstResponder()
        return (true)
    }
}

