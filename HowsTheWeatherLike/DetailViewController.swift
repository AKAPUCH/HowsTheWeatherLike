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
        table
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
        self.navigationController?.navigationBar.topItem?.title = weatherInfo.getKorean_Name()
        var appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance =
        self.navigationController?.navigationBar.standardAppearance
        
        table.delegate = self
        table.dataSource = self
        table.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
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

extension DetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let model = weatherDetail[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.defaultContentConfiguration()?.text = model.
        return cell
    }
    
    
}

#if DEBUG
struct ViewControllerRepresentation2 : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return DetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ViewController_Previews2: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation2()
    }
}
#endif
