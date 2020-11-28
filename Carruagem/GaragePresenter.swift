import UIKit
/// Herdar de AnyObject fará com que apenas classes possam ser criadas conforme este protocolo. Obs.: class está deprecated
protocol GaragePresenterDelegate: AnyObject {
    func fetchSuccess()
}

class GaragePresenter {
    
    private let garageService: CarTemplateService
    weak var delegate: GaragePresenterDelegate? /// weak em delegate evita memory leak pois evita retenção de ciclos
    
    var carData = [CarData]()
    var manufactureYear = [ManufactureYear]()
    var carDetail: CarDetail?
    var carImages = ["car0", "car1", "car2", "car3", "car4", "car5", "car6", "car7", "car8", "car9"]
    
    init(garageService: CarTemplateService = CarTemplateService()) {
        self.garageService = garageService
    }
    
//MARK: - Functions
    
    func getCarTemplate() {
        self.garageService.carModelService(to: Endpoint.fetchCarModel.rawValue) { response in
            
            switch response{
            case .success(let carModel):
                self.modelMapper(carModel: carModel)
                self.delegate?.fetchSuccess()
                break
            case .failure:
                break
            }
            
        }
    }
    
    func getCarYear(by modelCode: String) {
        self.garageService.carYearService(to: Endpoint.fetchCarYear(modelCode: modelCode).rawValue) { response in
            
            switch response{
            case .success(let manufactureYear):
                self.yearMapper(manufactureYear: manufactureYear)
                self.delegate?.fetchSuccess()
                break
            case .failure:
                break
            }
            
        }
    }
    
    func getCarDescription(by modelCode: String, yearCode: String) {
        self.garageService.carDetailService(to: Endpoint.fetchCarDetail(modelCode: modelCode, yearCode: yearCode).rawValue) { response in
            
            switch response{
            case .success(let carDetail):
                self.detailMapper(carDetail: carDetail)
                self.delegate?.fetchSuccess()
                break
            case .failure:
                break
            }
        }

    }
    
    func getCarImage() -> String {
        if let carImage = self.carImages.randomElement() {
            return carImage
        }
        return "car0"
    }
}

//MARK: - ObjectMappers
extension GaragePresenter {
    
    func modelMapper(carModel: CarModel) {
        let carDataFilter = carModel.template.filter {
            $0.name.isEmpty == false
        }
        for value in carDataFilter {
            self.carData.append(value)
        }
    }
    
    func yearMapper(manufactureYear: [ManufactureYear]) {
        self.manufactureYear = manufactureYear
    }
    
    func detailMapper(carDetail: CarDetail) {
        self.carDetail = carDetail
    }
}

//MARK: - Cells Builders

extension GaragePresenter {
    
    func numberOfModelsRows() -> Int{
        return carData.count
    }
    
    func modelForRow(at indexPath: IndexPath) -> GenericCellTableViewCell.Data{
        let data = GenericCellTableViewCell.Data(name: self.carData[indexPath.row].name, code: "\(carData[indexPath.row].code)", image: self.getCarImage())
        return data
    }
    
    func numberOfYearRows() -> Int{
        return manufactureYear.count
    }
    
    func yearForRow(at indexPath: IndexPath) -> GenericCellTableViewCell.Data{
        let data = GenericCellTableViewCell.Data(name: self.manufactureYear[indexPath.row].name, code: "\(manufactureYear[indexPath.row].code)")
        return data
    }
    
    func getCarDetail() -> CarDetailViewController.Data {
        let data = CarDetailViewController.Data(value: self.carDetail?.value, brand: self.carDetail?.brand, model: self.carDetail?.model, modelYear: self.carDetail?.modelYear, fuel: self.carDetail?.fuel, fipeCode: self.carDetail?.fipeCode, referenceMonth: self.carDetail?.referenceMonth, vehicleType: self.carDetail?.vehicleType, fuelInitials: self.carDetail?.fuelInitials)
        return data
    }
    
}

