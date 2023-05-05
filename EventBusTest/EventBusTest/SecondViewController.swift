import UIKit

class SecondViewController: UIViewController {
    private var button: UIButton = {
        let b = UIButton()
        b.setTitle("change", for: .normal)
        b.setTitleColor(.red, for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRect(x: (view.frame.size.width - 80)/2, y: (view.frame.size.height - 40)/2, width: 80, height: 40)
        button.addTarget(self, action: #selector(post), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func post() {
        dismiss(animated: true)
        let event = UpdateButtonTextEvent()
        event.text = "change"
        EventBus.Post(event)
    }
}
