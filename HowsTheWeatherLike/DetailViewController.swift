//
//  DetailViewController.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/09.
//

import UIKit
import SnapKit
import SwiftUI
class DetailViewController: UIViewController {
    
    //variables
    var weatherInfo : WeatherInfo = WeatherInfo.shared
    var weatherDetail : [NationWeatherD] = []
    
    let table : UITableView = {
        let settings = UITableView()
        settings.translatesAutoresizingMaskIntoConstraints = false
        return settings
    }()
    
    //func
    func setConstraint() {
        view.addSubview(table)
        table.snp.makeConstraints{make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //override func
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonDecoder = JSONDecoder()
        
        guard let jsonData : NSDataAsset = NSDataAsset.init(name: "\(weatherInfo.getAsset_Name())") else {return}
        
        do {
            weatherDetail = try jsonDecoder.decode([NationWeatherD].self, from: jsonData.data)
        }catch{
            print(error.localizedDescription)
        }
        table.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        navigationItem.title = weatherInfo.getKorean_Name()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        table.delegate = self
        table.dataSource = self
        table.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        setConstraint()
    }
    //commit

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let model = weatherDetail[indexPath.row]
        determineImage(model.state, cell)
        cell.nationLabel.text = "\(model.city_name)"
        cell.weatherLabel.text = "섭씨 \(model.celsius)도 / 화씨 \((model.celsius)*32*9/5+32)도"
        cell.rainyLabel.text = "강수확률 \(model.rainfall_probability)%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func determineImage(_ state : Int, _ cell : CustomCell) {
        switch state {
        case 10: cell.leftImageView.image = UIImage.init(named: "sunny")
        case 11: cell.leftImageView.image = UIImage.init(named: "cloudy")
        case 12: cell.leftImageView.image = UIImage.init(named: "rainy")
        case 13: cell.leftImageView.image = UIImage.init(named: "snowy")
        default:
            print("something missed")
        }
    }
}
