

import UIKit

protocol UpdatingDataController: AnyObject {
    var updatingData: String { get set }
}


class SecondViewController: UIViewController, UpdatingDataController {
    var updatingData: String = ""
    @IBOutlet var dataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    // обновляем данные в текстовом поле
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach {
            ViewController in (ViewController as? UpdatableDataController)?.updatedData = dataTextField.text ?? ""
        }
    }
}
