//
//  ViewController.swift
//  Concentration_Programmatic
//
//  Created by Smeet Kathiria on 5/20/20.
//  Copyright © 2020 Smeet Kathiria. All rights reserved.
//

import UIKit

typealias Emojis = [String]

/// Enum representing all the possible card themes.
enum Theme: Int {
  
  case Foods, Faces, Sports, Animals, Fruits, Balls
  
  /// The color of the back of the card
  var cardColor: UIColor {
    switch self {
    case .Foods:
      return #colorLiteral(red: 0.6706523895, green: 0.2718360722, blue: 0, alpha: 1)
      
    case .Faces:
      return #colorLiteral(red: 0.4817671776, green: 0.1368642449, blue: 0.6649351716, alpha: 1)
      
    case .Sports:
      return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
      
    case .Animals:
      return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
      
    case .Fruits:
      return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
      
    case .Balls:
      return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
  }
  
  
  /// The emojis used by this theme
  var emojis: Emojis {
    switch self {
    case .Foods:
      return ["🍔", "🍟", "🌭", "🥓", "🥬", "🥒", "🥑", "🍕"]
      
    case .Faces:
      return ["😀", "🙄", "😡", "🤢", "🤡", "😱", "😍", "🤠"]
      
    case .Sports:
      return ["🏌🏼", "🤼‍♂️", "🥋", "🏹", "🥊", "🏊", "🤾🏿‍♂️", "🏇🏿"]
      
    case .Animals:
      return ["🦒", "🐋", "🦁", "🐬", "🐓", "🐈", "🕊", "🐙"]
      
    case .Fruits:
      return ["🍌", "🍍", "🍆", "🍠", "🍉", "🍇", "🥝", "🍒"]
      
    case .Balls:
      return ["⚽️", "🏀", "🏈", "🥎", "🏐", "🏉", "🎱", "⚾️"]
    }
  }
  
  /// The count of possible themes.
  static var count: Int {
    return Theme.Balls.rawValue + 1
  }
  
  static func getRandom() -> Theme {
    return Theme(rawValue: Theme.count.arc4random)!
  }
  
}

let spacingUseSystem = CGFloat()

class ViewController: UIViewController {

    
    var gradientLayer: CAGradientLayer!

    var flipLabel : UILabel!
    var scoreLabel : UILabel!
    var newGameButton : CustomButton!
   // var newGameButtonView : UIView!
    var hStackArr : [UIStackView]!
    var emojiButtonArr : [CustomButton]!
    var hStack1 : UIStackView!
   var vStack1 : UIStackView!

    
    var newGameButton1 : CustomButton!
    var newGameButton2 : CustomButton!
    var newGameButton3 : CustomButton!
    var newGameButton4 : CustomButton!
    
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    

   /// The model encapsulating the concentration game's logic.
      private lazy var concentration = Concentration(numberOfPairs: (emojiButtonArr.count / 2))
      
      /// The randomly picked theme.
      /// The theme is chosen every time a new game starts.
      private var pickedTheme: Theme!
      

    override func loadView() {
         view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.isOpaque = false
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score:\(0)"
        scoreLabel.textAlignment = .center
        scoreLabel.numberOfLines = 1;
        scoreLabel.adjustsFontSizeToFitWidth = true;
        scoreLabel.adjustsFontForContentSizeCategory = true
        scoreLabel.font = scoreLabel.font.withSize(35)
        scoreLabel.textColor = .white

        
        flipLabel = UILabel()
        flipLabel.translatesAutoresizingMaskIntoConstraints = false
        flipLabel.text = "Flips:\(0)"
        flipLabel.textAlignment = .center
        flipLabel.numberOfLines = 1;
        flipLabel.adjustsFontSizeToFitWidth = true;
        flipLabel.font = flipLabel.font.withSize(35)
        flipLabel.textColor = .white

        flipLabel.adjustsFontForContentSizeCategory = true
        
        
        
        hStack1 = UIStackView()
        hStack1.translatesAutoresizingMaskIntoConstraints = false
        hStack1.distribution = .fillEqually
        hStack1.axis = .horizontal
        hStack1.alignment = .fill
        hStack1.contentMode = .scaleToFill
        hStack1.addArrangedSubview(flipLabel)
        hStack1.addArrangedSubview(scoreLabel)
        
// array that holds horizontal stack views for emoji buttons
        
        hStackArr = [UIStackView]()
        for _ in 0..<4 {
        let hstack = UIStackView()
            hstack.translatesAutoresizingMaskIntoConstraints = false
            hstack.distribution = .fillEqually
            hstack.axis = .horizontal
            hstack.alignment = .fill
            hstack.contentMode = .scaleToFill
            hstack.spacing = 10
            hStackArr.append(hstack)
        }

        
        let newGameButtonWidth = 160
        newGameButton = CustomButton()
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.isUserInteractionEnabled = true
        newGameButton.setTitle("New Game", for: .normal)
        
        
        

     // created 16 button for emojis
        emojiButtonArr = [CustomButton]()
        for _ in 0..<16 {
            let ea = CustomButton()
         //   ea.translatesAutoresizingMaskIntoConstraints = false
            ea.isUserInteractionEnabled = true
            ea.setTitle("1", for: .normal)
            emojiButtonArr.append(ea)
        }
        
        
       //
        for i in 0..<emojiButtonArr.count {
           
            emojiButtonArr[i].translatesAutoresizingMaskIntoConstraints = false
            emojiButtonArr[i].isUserInteractionEnabled = true
            emojiButtonArr[i].setTitle("", for: .normal)
            
           emojiButtonArr[i].titleLabel?.font = UIFont(name: "GillSans-Italic", size: 50)
        
        }
//        for button in 0..<4 {
//            hStack1.addArrangedSubview(emojiButton[button])
//        }
        for a in 0..<4 {
            hStackArr[0].addArrangedSubview(emojiButtonArr[a])
        }
        for b in 4..<8 {
             hStackArr[1].addArrangedSubview(emojiButtonArr[b])
        }
        for c in 8..<12 {
             hStackArr[2].addArrangedSubview(emojiButtonArr[c])
        }
        for d in 12..<16 {
             hStackArr[3].addArrangedSubview(emojiButtonArr[d])
        }
        
        
        
        // created dictionary for upper three horizontal stack view which will go inside the vertical stack view
            vStack1 = UIStackView()
             vStack1.translatesAutoresizingMaskIntoConstraints = false
             vStack1.distribution = .fillEqually
             vStack1.axis = .vertical
             vStack1.alignment = .fill
             vStack1.contentMode = .scaleToFill
            vStack1.spacing = 10
        
        
        
      // added three horizontal stack view to store button
        for hstackItem in 0..<4 {
            vStack1.addArrangedSubview( hStackArr[hstackItem])
       }

        view.addSubview(newGameButton)
        view.addSubview(hStack1)
        view.addSubview(vStack1)
          // view.addSubview(newGameButtonView)
      //  newGameButtonView.addSubview(newGameButton)
        
        sharedConstraints.append(contentsOf: [
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
             newGameButton.widthAnchor.constraint(equalToConstant: CGFloat(newGameButtonWidth)),
             
            
             hStack1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
             hStack1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            hStack1.heightAnchor.constraint(equalToConstant: 42),

            
             hStack1.topAnchor.constraint(greaterThanOrEqualTo: vStack1.bottomAnchor, constant: 16),
             
             
             
             
             vStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
             
        ])

        compactConstraints.append(contentsOf: [
            vStack1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            newGameButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,constant: -10),
             vStack1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 16),
              hStack1.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -30),
             vStack1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -16),
            

        ])

        regularConstraints.append(contentsOf: [
            vStack1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            newGameButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 35.0),
             vStack1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 100),
             vStack1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -100),
              hStack1.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -15)
            

        ])
        
        
        
        
        
        
        
        
//        NSLayoutConstraint.activate([
//
//            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            newGameButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,constant: -10),
//            newGameButton.widthAnchor.constraint(equalToConstant: CGFloat(newGameButtonWidth)),
//
//
//
//            hStack1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
//            hStack1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
//            hStack1.heightAnchor.constraint(equalToConstant: 42),
//            hStack1.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -30),
//            hStack1.topAnchor.constraint(greaterThanOrEqualTo: vStack1.bottomAnchor, constant: 16),
//
//
//
//            vStack1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
//            vStack1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            vStack1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            vStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//
//
//
//        ])
        
       

        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }


        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
           
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer.frame = self.view.bounds

    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        createGradientLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    
    
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        let color2 = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)

        gradientLayer.colors = [color2.cgColor, color1.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    // MARK: Imperatives
    
    /// The map between a card and the emoji used with it.
    /// This is the dictionary responsible for mapping
    /// which emoji is going to be displayed by which card.
    private var cardsAndEmojisMap = [Card : String]()
    
    /// Method used to randomly choose the game's theme.
    private func chooseRandomTheme() {
      pickedTheme = Theme.getRandom()
  //    view.backgroundColor = pickedTheme.backgroundColor
      
      cardsAndEmojisMap = [:]
      var emojis = pickedTheme.emojis
      
      for card in concentration.cards {
        if cardsAndEmojisMap[card] == nil {
          cardsAndEmojisMap[card] = emojis.remove(at: emojis.count.arc4random)
        }
      }
      
      displayCards()
    }
    
    /// Method used to refresh the scores and flips UI labels.
    private func displayLabels() {
      flipLabel.text = "Flips: \(concentration.flipsCount)"
      scoreLabel.text = "Score: \(concentration.score)"
    }
    
    /// Method in charge of displaying each card's state
    /// with the assciated card button.
    private func displayCards() {
      for (index, cardButton) in emojiButtonArr.enumerated() {
        guard concentration.cards.indices.contains(index) else { continue }
        
        let card = concentration.cards[index]
        
        if card.isFaceUp {
          cardButton.setTitle(cardsAndEmojisMap[card], for: .normal)
          cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
          cardButton.setTitle("", for: .normal)
          cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : pickedTheme.cardColor
        }
      }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        chooseRandomTheme()
        addActionToNewGameButton(with: newGameButton)
        
        for button in 0..<16 {
            addActionToEmojiGameButton(with: emojiButtonArr[button])
        }
        
        traitCollectionDidChange( UIScreen.main.traitCollection)

    }
    func addActionToNewGameButton(with button : CustomButton) {
           button.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
       }
    
    @objc func newGameButtonTapped(sender :CustomButton!) {
       chooseRandomTheme()
        concentration.resetGame()
        displayCards()
        displayLabels()
        sender.shake()
       }
    
    func addActionToEmojiGameButton(with button : CustomButton) {
         button.addTarget(self, action: #selector(emojiGameButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func emojiGameButtonTapped(sender :CustomButton!){
        guard let index = emojiButtonArr.firstIndex(of: sender) else { return }
        
        concentration.flipCard(at: index)
        
        displayCards()
        displayLabels()
        sender.shake()

        
    }
    
}

extension Int {
  
  /// A facility property for accessing a random
  /// value from the current Int instance.
  var arc4random: Int {
    return Int(arc4random_uniform(UInt32(self)))
  }
}
