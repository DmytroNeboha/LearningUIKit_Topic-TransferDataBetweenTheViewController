

import UIKit

protocol UpdatingDataController: AnyObject {
    var updatingData: String { get set }
}


class SecondViewController: UIViewController, UpdatingDataController {
    var updatingData: String = ""
    @IBOutlet var dataTextField: UITextField!
    var handleUpdatedDataDelegate: DataUpdateProtocol?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1. Вариант: Обновляем данные в текстовой метке (от A к B) с помощю Property
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    // обновляем данные в текстовом поле
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    // 2. Вариант: Обновляем данные в текстовой метке (от B к A) с помощю Property
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach {
            ViewController in (ViewController as? UpdatableDataController)?.updatedData = dataTextField.text ?? ""
        }
    }
    // 4.Вариант: передача данных от B к А с помощю unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toFirstScreen":
            // обрабатываем переход
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на новый экран
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        // безопасное извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    // 5. Вариант: передача данных от B к А с помощю делегирования
    @IBAction func saveDataWithDelegate (_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        // визываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
}
