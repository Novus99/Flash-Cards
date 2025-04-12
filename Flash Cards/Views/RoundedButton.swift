import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupStyle()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            setupStyle()
        }
    }

    @IBInspectable var borderColor: UIColor = .primary  {
        didSet {
            setupStyle()
        }
    }
    
    @IBInspectable var title: UIColor = .primary {
        didSet {
            setupStyle()
        }
    }
    
    @IBInspectable var textColor: UIColor = .white {
        didSet {
            setTitleColor(textColor, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupStyle()
    }

    private func setupStyle() {
        layer.cornerRadius = cornerRadius == 0 ? frame.height / 2 : cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        addShadow()
    }

    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
        layer.masksToBounds = false
    }
}
