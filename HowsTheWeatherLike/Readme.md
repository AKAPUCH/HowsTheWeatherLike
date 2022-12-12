# 부스트코스 프로젝트 C : Weather Today 


## 이번에 새롭게 배운 것들



<details><summary>1. 테이블 뷰 구현</summary>
공식문서를 보면서 테이블을 만들어봤다.<br>

```
    lazy var table : UITableView = {
       let tableSettings = UITableView()
        tableSettings.translatesAutoresizingMaskIntoConstraints = false
        tableSettings.fillerRowHeight = 50
        // ios 15이상부터는 cell의 개수만큼만 구분선 생성. 따로 프로퍼티값을 지정해 구분선을 미리 그려줘야함.
        return tableSettings
    }()

    func tableSetup() {
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
```
처음에 공식문서 가이드라인대로 테이블을 생성하였을 때는 이상하게 비어있는 cell에 대해서는 구분선이 존재하지 않았다. 뭔가 설정을 잘못한건가? 하고 한참을 검색했고</br>
</br>**ios15 이상부터 UITableView의 fillerRowHeight 프로퍼티 값을 설정해줘야 구분선이 생긴다는 것을 알게되었다.**</br>
</br> 또 알게된 재밌는 사실은 테이블은 datasource가 필수적이고 각 row에 cell이라는 contentview를 삽입하여 그 형태를 결정하게 된다.  이 때 각 row마다 cell 객체를 매번 재생성해주면 메모리 낭비가 심하기 때문에 Queue 자료구조를 사용하여 사용했던 셀을 집어넣고 **다음번에 사용할 셀이 같다면 재사용하게 된다.**
```
let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as UITableViewCell
```
이외에도 필요한 섹션의 수를 반환하기 위한 numberOfRowsInSection, 각 행의 길이를 지정해주는 heightForRowAt, 행이 선택되었을 때 할 동작을 지정해주는 didSelectRowAt 같은 delegate 함수를 구현하여 사용하였다.

</details>


<details><summary> 2. Custom TableViewCell
</summary>
2번째 테이블 화면에서 라벨을 세 개 쓰게되어 UITableWindowCell로 새로운 customCell을 만들어줬다.
</br>테이블에서 사용할 때 새로 만든 식별자만 기존의 식별자와 갈아껴주면 되고 크게 어려운 점은 없었다.
</details>


<details><summary> 3. SwiftUI Preview를 통한 UI 미리보기
</summary>
리액트처럼 수정사항이 바로바로 보이는 방법이 없을까 하다가 preview 코드를 발견했다.

```
import SWIFTUI
....

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

```
해당 코드를 통해 스토리보드없이 구현할 때도 수정사항을 즉시 확인할 수 있어 좋았다.
</details>


<details><summary>4. Status Bar, Navigation Bar 설정
</summary>
프로젝트 예시 사진을 확인했을 때 구현사항으로는 네비게이션 바의 배경이 파란색, 제목 추가 및 바 아이템 흰색 속성이 있었다. 이것도 테이블 뷰처럼 ios 15에서 변경사항이 있어 구글링한 정보만으로는 속성 변경이 불가능했다.

```
        let appearance = UINavigationBarAppearance() //ios 15이상부터는 해당 객체의 프로퍼티로 UI변경가능
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance // 스크롤할 때 적용
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        //스크롤 멈춘상태에 적용
```
UINavigationBarAppearance 객체를 통해서 실제 네비게이션 속성을 조정할 수 있었다.

</details>


<details><summary> 5. JSON 데이터 디코딩
</summary>
Asset의 JSON 데이터를 읽어들여 미리 만들어뒀던 구조체 형태로 디코딩해주었다. 변환 후 테이블의 정보 새로고침 함수를 호출하여 UITableViewDelegate의 구현 함수들이 동작함으로써 테이블에 셀을 넣을 수 있었다.

```
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
```

</details>



<details><summary>6. SnapKit
</summary>
기존의 Anchor 기반의 오토 레이아웃 코드는 중복되는 부분이 많았고 일일이 active로 활성화시켜줘야 했다. 전체 레이아웃을 한데 묶어서는 불가능하지만 모든 방위의 레이아웃이 같을 때 쓰는 edge, 비율로 설정할 수 있는 multiplied등 훨씬 더 간편하고 직관적으로 UI를 설정할 수 있게되었다.
</details>


---
## 향후 추가하거나 개선해보고 싶은 것들

1. segue를 통해서 화면전환 해보기
2. 현재 preview는 시작화면에서만 가능. 각 viewController에 대해서 적용할 방법이 있지않을까?
3. 싱글톤 패턴 외 다른 방법으로 화면간 데이터 전달 방법 생각해보기
