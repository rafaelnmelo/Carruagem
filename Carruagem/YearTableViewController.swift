import UIKit
import Alamofire

class YearTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    private var presenter: GaragePresenter?
    var manufactureYear: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupPresenter()
        setupTableView()
        if let year = manufactureYear {
            getYear(by: year)
        }
    }
    
    private func setupTableView() {
        tableview.register(UINib(nibName: "GenericCell", bundle: nil), forCellReuseIdentifier: "GenericCellTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    private func setupPresenter() {
        presenter = GaragePresenter()
        presenter?.delegate = self
    }
    
    private func getYear(by modelCode: String) {
        presenter?.getCarYear(by: modelCode)
    }
}

extension YearTableViewController: GaragePresenterDelegate {
    func fetchSuccess() {
        tableview.reloadData()
    }
}

extension YearTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
}

extension YearTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfYearRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenericCellTableViewCell", for: indexPath) as? GenericCellTableViewCell {
            if let data = presenter?.yearForRow(at: indexPath) {
                cell.build(data: data)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
