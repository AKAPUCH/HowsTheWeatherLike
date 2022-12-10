//
//  LastViewController.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/10.
//

import UIKit
import SnapKit
class LastViewController: UIViewController {
    
    // MARK: - variables
    var weatherInfo : WeatherInfo = WeatherInfo.shared
    
    lazy var weather : UIImageView = {
       let settings = UIImageView()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.contentMode = .scaleAspectFit
        return settings
    }()
    
    let stack : UIStackView = {
       let settings = UIStackView()
        settings.distribution = .fillEqually
        settings.spacing = 10
        settings.axis = .vertical
        return settings
    }()
    
    let state : UILabel = {
       let settings = UILabel()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.textAlignment = .center
        return settings
    }()
    let celcius : UILabel = {
       let settings = UILabel()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.textAlignment = .center
        return settings
    }()
    let probability : UILabel = {
       let settings = UILabel()
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.textAlignment = .center
        return settings
    }()
    
    // MARK: - func
    func determineWeather() {
        let currentState = weatherInfo.getState()
        switch currentState {
        case 10: weather.image = UIImage.init(named: "sunny")
                 state.text = "해"
        case 11: weather.image = UIImage.init(named: "cloudy")
                 state.text = "구름"
        case 12: weather.image = UIImage.init(named: "rainy")
                 state.text = "비"
        case 13: weather.image = UIImage.init(named: "snowy")
                 state.text = "눈"
        default:
            print("something missed")
        }
        celcius.text = "섭씨 \(weatherInfo.getCecius())도 / 화씨 \(round(((weatherInfo.getCecius())*9/5+32)*10)/10)도"
        probability.text = "강수확률 \(weatherInfo.getRainfall_Probability())%"
        if  weatherInfo.getRainfall_Probability() >= 50 {probability.textColor = .systemOrange}
        else {probability.textColor = .black}
        
        if weatherInfo.getCecius() < 10.0 {celcius.textColor = .systemBlue}
        else {celcius.textColor = .black}
    }
    
    func setContstraints() {
        view.addSubview(weather)
        view.addSubview(stack)
        stack.addArrangedSubview(state)
        stack.addArrangedSubview(celcius)
        stack.addArrangedSubview(probability)
        
        weather.snp.makeConstraints{make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        stack.snp.makeConstraints{make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(weather.snp.bottom)
            make.height.equalTo(weather).multipliedBy(0.5)
        }
        
    }
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.title = "\(weatherInfo.getCity_Name())"
        let backButton = UIBarButtonItem()
        backButton.title = "\(weatherInfo.getKorean_Name())"
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        determineWeather()
        setContstraints()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
