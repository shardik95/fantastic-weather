//
//  ChangeCityViewController.swift
//  weather
//
//  Created by Hardik Shah on 8/9/18.
//  Copyright © 2018 Hardik Shah. All rights reserved.
//

import UIKit

protocol changeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate: changeCityDelegate?

    @IBOutlet weak var changeCityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getWeatherPressed(_ sender: UIButton) {
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
