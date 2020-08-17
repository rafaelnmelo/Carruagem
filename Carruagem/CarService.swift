import UIKit
import Alamofire

class CarService {
    
    // CORRIGIR: Refazer tudo :)
    
    /*
     Primeiro ponto: Centralizar os endpoints em uma Enum.
     Segundo ponto: Centralizar as chamadas em um ServiceManager.
     Terceiro ponto: Abstrair o domainURL e os seus parametros.
     Quarto ponto: Service não é responsavel por fazer o Decoder.
     Quinto ponto: onComplete é HORRIVEL, use completionHandler ou callback.
     */
    
    func getBrand(onComplete: @escaping (CarBrand?) -> Void) {
        AF.request("https://parallelum.com.br/fipe/api/v1/carros/marcas").response { response in
            guard let content = response.data, let brand = try? JSONDecoder().decode(CarBrand.self, from: content) else {
                onComplete(nil)
                return
            }
            onComplete(brand)
        }
    }
    
    func getTemplate(onComplete: @escaping (CarTemplate?) -> Void) {
        AF.request("https://parallelum.com.br/fipe/api/v1/carros/marcas/59/modelos").response { response in
            guard let content = response.data, let template = try? JSONDecoder().decode(CarTemplate.self, from: content) else {
                onComplete(nil)
                return
            }
            onComplete(template)
        }
        
    }
    
    func getYear(onComplete: @escaping (CarYear?) -> Void) {
        AF.request("https://parallelum.com.br/fipe/api/v1/carros/marcas/59/modelos/5940/anos").response { response in
            guard let content = response.data, let year = try? JSONDecoder().decode(CarYear.self, from: content) else {
                 onComplete(nil)
                 return
             }
             onComplete(year)
         }
        
    }
    
    func getValue(onComplete: @escaping (CarValue?) -> Void) {
        AF.request("https://parallelum.com.br/fipe/api/v1/carros/marcas/59/modelos/5940/anos/2014-3").response { response in
             guard let content = response.data, let carValue = try? JSONDecoder().decode(CarValue.self, from: content) else {
                 onComplete(nil)
                 return
             }
             onComplete(carValue)
         }
        
    }
}
