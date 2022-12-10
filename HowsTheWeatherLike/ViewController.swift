//
//  ViewController.swift
//  HowsTheWeatherLike
//
//  Created by 최우태 on 2022/12/03.
//

import UIKit
import SwiftUI
import SnapKit
class ViewController: UIViewController {
    
    //변수 정의
    let weatherInfo : WeatherInfo = WeatherInfo.shared
    var countries : [NationWeatherM] = []
    
    
    lazy var table : UITableView = {
       let tableSettings = UITableView()
        tableSettings.translatesAutoresizingMaskIntoConstraints = false
        tableSettings.fillerRowHeight = 50
        // ios 15이상부터는 cell의 개수만큼만 구분선 생성. 따로 프로퍼티값을 지정해 구분선을 미리 그려줘야함.
        return tableSettings
    }()

    
    //functions
    
    func tableSetup() {
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
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
    
    func setConstraint() {
        table.snp.makeConstraints{cons in
            cons.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setNavi() {
//        navigationController?.navigationBar.barStyle = .black // 상태바 항목들 색 흰색변경(다크모드를 위한)
        self.navigationController?.navigationBar.topItem?.title = "세계 날씨"

        let appearance = UINavigationBarAppearance() //ios 15이상부터는 해당 객체의 프로퍼티로 UI변경가능
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance // 스크롤할 때 적용
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        //스크롤 멈춘상태에 적용
    }
    //override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getJsonData()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setNavi()
        tableSetup()
        view.addSubview(table)
        setConstraint()
    }
    
    

}

//extension(delegate)

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as UITableViewCell
    let model =  countries[indexPath.row]
        cell.textLabel?.text = model.korean_name
        cell.imageView?.image = UIImage.init(named: "flag_\(model.asset_name)")
        cell.accessoryType = .disclosureIndicator
        
        //커스텀셀 없이 기본 셀 사용
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentInfo = countries[indexPath.row]
        weatherInfo.registerKorean_Name(currentInfo.korean_name)
        weatherInfo.registerAsset_Name(currentInfo.asset_name)
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    
        
    
    
    
    
}

#if DEBUG
struct ViewControllerRepresentation : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation()
    }
}
#endif


