

import UIKit

// (от B к A)
protocol UpdatableDataController: AnyObject {
    var updatedData: String { get set }
}


class ViewController: UIViewController, UpdatableDataController {
    var updatedData: String = "Test Data"
    @IBOutlet var dataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // (от B к A) с помощю Property
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    // 1. Вариант: передаём данные с помощю Property
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контролер, в который происходит переход (от А к B)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        
        // передаём данные к следующему экрану (от А к B) с помощю Property
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
        }
    
    // Обновляем данные в текстовой метке (от B к A) с помощю Property
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }
    
    // 2. Вариант: передаём данные с помощю Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
}

