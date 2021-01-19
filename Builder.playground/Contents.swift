import UIKit
import XCPlayground
import PlaygroundSupport

protocol CellBuilder {
    static func cell(for identifier:String) -> UITableViewCell
    static func setup(cell:UITableViewCell ,with data:Any)
}

protocol CommonTableItem {
    func identifier(for indexPath:IndexPath) -> String
    func buider(for indexPath:IndexPath) -> CellBuilder.Type
    func data(for indexPath:IndexPath) -> Any
}

class CommonTableViewController:UITableViewController {
    
    var itmes:[CommonTableItem] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.itmes[indexPath.row].identifier(for: indexPath)
        let builer = self.itmes[indexPath.row].buider(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? builer.cell(for: identifier)
        let data = self.itmes[indexPath.row].data(for: indexPath)
        builer.setup(cell: cell, with: data)
        return cell;
    }
}

struct HomeSceneBannerBuilder: CellBuilder {
    static func cell(for identifier: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        return cell;
    }
    
    static func setup(cell: UITableViewCell, with data: Any) {
        guard let name = data as? String else {
            return
        }
        cell.textLabel?.text = name;
    }
}

struct HomeSceneCategoryBuilder: CellBuilder {
    static func cell(for identifier: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        return cell;
    }
    
    static func setup(cell: UITableViewCell, with data: Any) {
        guard let _datas = data as? (String,String) else {
            return
        }
        cell.textLabel?.text = _datas.0;
        cell.detailTextLabel?.text = _datas.1;
    }
}

enum HomeScene:String,CommonTableItem {
    case banner
    case category
    
    func identifier(for indexPath: IndexPath) -> String {
        return self.rawValue
    }
    
    func buider(for indexPath: IndexPath) -> CellBuilder.Type {
        switch self {
        case .banner: return HomeSceneBannerBuilder.self
        case .category: return HomeSceneCategoryBuilder.self
        }
    }
    
    func data(for indexPath: IndexPath) -> Any {
        switch self {
        case .banner: return self.rawValue
        case .category: return (self.rawValue,self.rawValue)
        }
    }
}

let vc = CommonTableViewController()
vc.itmes = [HomeScene.banner,HomeScene.category]
vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 500)
PlaygroundPage.current.liveView = vc.view
PlaygroundPage.current.needsIndefiniteExecution = true
