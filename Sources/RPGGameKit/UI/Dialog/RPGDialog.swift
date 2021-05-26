//
//  RPGDialog.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 07/03/2021.
//

import SpriteKit

class RPGDialog: RPGUIElement {
    
    let uuid = UUID()
    var text: String = ""
    
    init(text: String) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        self.text = text
        
        self.buildUI()
        
        let gestureDetector = RPGGDDialog(dialog: self)
        // Save state ?
        RPGGestureDetectorService.shared.register(gestureDetector, withKey: self.uuid.uuidString)
        RPGGestureDetectorService.shared.desactivateAll()
        RPGGestureDetectorService.shared.activateGestureDetector(withKey: self.uuid.uuidString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func buildUI() {
        
        self.zPosition = 100 // Have a zPosition manager
        
        let dialogSize = CGSize(width: 200, height: 100)
        self.size = dialogSize
        
        let background = SKShapeNode(rect: CGRect(
                                        x: -dialogSize.width / 2.0,
                                        y: -dialogSize.height / 2.0,
                                        width: dialogSize.width,
                                        height: dialogSize.height), cornerRadius: 8)
        background.fillColor = .white
        self.addChild(background)
        
    }
        
    /*
     
     I need to perform code every 'showTime' seconds
     I don't know if I should run a SKAcion (that is big because of the number of characters in a string
     Or use async method to add a character
     
     https://www.hackingwithswift.com/example-code/system/how-to-run-code-after-a-delay-using-asyncafter-and-perform
     
     */
    
    /*
     Tasumo reverse-engineering
     
     1. Create a SKShapeNode (textBox)
     
     --- FOR EACH CHARACTERS OF A STRING ---
     
     2. Create a SKLabelNode(text: String(character))
        Set position according (make sure there is space between characters)
        Set alpha to 0
    
     3. Add character to textBox
     
     4. Run show animation
        Delay of delay * character index
        Fade to 1
        Run sequence
     
     */
    
    func tapped() {
        
        // Show next text or hide
        self.hide()
        
    }
    
}


/*
 
 Tasumo method but with translation
 
 ///  Draw text
 ///
 ///  - parameter text:     Text to draw
 ///  - parameter talkSide: Text drawing position
func drawText(_ talkerImageName: String?, body: String, side: TALK_SIDE) {
        var iDrawingFont: CGFloat = 0     // Determine the drawing position
        var nDrawingFont: CGFloat = 0     // Decide what number the character you are drawing

        // Character image display
        if let imageName = talkerImageName {
            characterIcon.texture = SKTexture(imageNamed: imageName)
        }
        // Hide postpone button
        nextButton.removeAllActions()
        nextButton.alpha = 0.0
        // Clear already displayed characters
        clearText()

        for character in body.characters {
            // In the text drawing area anchorpoint
            // Draw from top left
            self.setPositionX(side)
            let anchor = self.getAnchorPositionOfTextRegion(side)

            // Judgment of line feed character
            if character == Dialog.NEWLINE_CHAR {
                iDrawingFont = ceil(iDrawingFont / rowNum) * rowNum
                continue
            }

            // What line and what character to draw (0 ~)
            var nLine = floor(iDrawingFont / rowNum)
            var nChar = floor(iDrawingFont.truncatingRemainder(dividingBy: rowNum))

            if iDrawingFont / rowNum + 1 > colNum {
                // If the number of lines is exceeded, the next page
                // TODO: 一There seems to be a better way, such as sending characters line by line.
                textBox.enumerateChildNodes(withName: CHAR_LABEL_NAME, using: {
                    node, sotp in

                    let delay = SKAction.wait(
                    forDuration: TimeInterval(self.VIEW_TEXT_TIME * nDrawingFont)
                    )
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.0)
                    let seq = SKAction.sequence([delay, fadeout])
                    node.run(seq)
                })
                nDrawingFont += 1
                iDrawingFont = 0
                nLine = 0
                nChar = 0
            }

            let char = SKLabelNode(text: String(character))
            char.fontSize = FONT_SIZE
            char.name = CHAR_LABEL_NAME
            char.position = CGPoint(x: anchor.x + nChar * charRegionWidth,
                                        y: anchor.y - nLine * charRegionHeight)
            char.alpha = 0.0
            textBox.addChild(char)
            
            let delay = SKAction.wait(forDuration: TimeInterval(VIEW_TEXT_TIME * nDrawingFont))
            let fadein = SKAction.fadeAlpha(by: 1.0, duration: 0.0)
            let sound = SKAction.playSoundFileNamed("talk.wav", waitForCompletion: false)
            let seq = SKAction.sequence([delay, fadein, sound])
            char.run(seq)

            iDrawingFont += 1
            nDrawingFont += 1
        }

        // Postpone button display
        let delay = SKAction.wait(forDuration: TimeInterval(VIEW_TEXT_TIME * nDrawingFont))
        nextButton.run(SKAction.sequence([delay, buttonLoop]))
    }
*/

