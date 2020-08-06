//
//  ViewController.swift
//  URLSession
//
//  Created by Sufiandy Elmy on 06/08/20.
//  Copyright © 2020 Sufiandy Elmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

@IBOutlet weak var weatherpred: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fatchWheterPrediction ()
    }

 func fatchWheterPrediction () {
//
 guard let apiUrl = URL (string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02" ) else
            {return}
            
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                //
                guard let data = data else {return}
                do {
                    //JSON
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WheaterPredAPI.self, from: data)
                    // get data
                    let temp = weatherData.main?.temp ?? 0
                    let description = weatherData.weather?[0].description
                    //set value
                    DispatchQueue.main.async {
                        self.weatherpred.text = "\(temp)"
                    }
                    print(description)
                } catch let err {
                    print("Error", err)
                }
                
            }.resume()
        }
    }
            struct WheaterPredAPI: Codable {
                let main: Main?
                let weather: [weather]?
                private enum CodingKeys : String, CodingKey {
                    case main
                    case weather
            }
        }
            struct Main: Codable {
                let temp: Float?
                let humidity: Int?
                
                private enum CodingKeys: String, CodingKey {
                    case temp
                    case humidity
                }
            }
    struct  weather: Codable {
        let description: String?
        
        private enum CodingKeys: String, CodingKey {
            case description
            
        }
    }
