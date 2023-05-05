import UIKit

class ViewController: UIViewController {
    private var button: UIButton = {
        let b = UIButton()
        b.setTitle("test", for: .normal)
        b.setTitleColor(.red, for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRect(x: (view.frame.size.width - 80)/2, y: (view.frame.size.height - 40)/2, width: 80, height: 40)
        button.addTarget(self, action: #selector(gotoNext), for: .touchUpInside)
        view.addSubview(button)
        EventBus.Register(self) { [weak self]  eventInfo  in
            self?.onEventUpdateButton(eventInfo)
        }
    }
    
    private func onEventUpdateButton(_ event: UpdateButtonTextEvent) {
        button.setTitle(event.text, for: .normal)
    }
    @objc private func gotoNext() {
        present(SecondViewController(), animated: true, completion: nil)

    }
    
    
}

