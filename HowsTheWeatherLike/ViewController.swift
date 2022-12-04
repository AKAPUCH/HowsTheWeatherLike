//
//  ViewController.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/03.
//

import UIKit

class ViewController: UIViewController {
    
    //변수 정의
    
    var countries : [NationWeatherM] = []
    var weatherDetail : [NationWeatherD] = []
    
    lazy var table : UITableView = {
       let tableSettings = UITableView()

        return tableSettings
    }()
    
    
    
    //functions
    
    func tableSetup() {
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    func getJsonData() {
        let jsonDecoder : JSONDecoder = JSONDecoder()
        
        guard let dataAsset1 : NSDataAsset = NSDataAsset.init(name: "countries" ) else {return}
        
        do{
            self.countries = try jsonDecoder.decode([NationWeatherM].self, from: dataAsset1.data)
        }catch {
            print(error.localizedDescription)
        }
        self.table.reloadData()
    }
    
    //override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableSetup()
    }
    
    override func loadView() {
        view.backgroundColor = .white
        view.addSubview(table)
        tableSetup()
        getJsonData()
    }


}

//extension(delegate)

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell ?? CustomCell()
        
        cell.bind(model: countries[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}


