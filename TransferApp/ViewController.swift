

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
    // (от B к A)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контролер, в который происходит переход (от А к B)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        
        // передаём данные к следующему экрану (от А к B)
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
        }
    
    // Обновляем данные в текстовой метке (от B к A)
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }

}

