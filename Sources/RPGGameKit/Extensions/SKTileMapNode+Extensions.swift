//
//  SKTileMapNode+Extensions.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 04/01/2021.
//

import SpriteKit

public extension SKTileMapNode {
    
    /// Add physics body to all tiles separately
    /// - Parameter categoryMask: Category mask physics tile node for physics body (Default = 0b1111_1111)
    func createPhysicsBody(categoryMask: UInt32 = 0b1111_1111) {
        
        let tileSize = self.tileSize
        let halfWidth = CGFloat(self.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(self.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<self.numberOfColumns {
            for row in 0..<self.numberOfRows {
                if let _ = self.tileDefinition(atColumn: col, row: row) {
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                    
                    let tileNode = SKNode()
                    tileNode.position = CGPoint(x: x, y: y)
                    
                    tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 16, height: 16))
                    tileNode.physicsBody?.affectedByGravity = false
                    tileNode.physicsBody?.allowsRotation = false
                    tileNode.physicsBody?.restitution = 0.0
                    tileNode.physicsBody?.isDynamic = false
                    
                    tileNode.physicsBody?.categoryBitMask = categoryMask
                    
                    self.addChild(tileNode)
                }
            }
        }
        
    }
    
    /// Create physics body using sweet line algorithm for merging tiles together
    /// - Parameter categoryMask: Category mask physics tile node for physics body (Default = 0b1111_1111)
    /// - Source: https://stackoverflow.com/questions/47645039/connect-physicsbodies-on-tilemap-in-spritekit
    /// - Reference: https://en.wikipedia.org/wiki/Sweep_line_algorithm
    func createSweetLinePhysicsBody(categoryMask: UInt32 = 0b1111_1111) {
        
        var tileArray = [SKSpriteNode]()
        var tilePositionArray = [CGPoint]()
        
        // 1. Create an array containing all position of tile nodes
        let tilesize = self.tileSize
        let halfwidth = CGFloat(self.numberOfColumns) / 2.0 * tilesize.width
        let halfheight =  CGFloat(self.numberOfRows) / 2.0 * tilesize.height

        for col in 0 ..< self.numberOfColumns {
            for row in 0 ..< self.numberOfRows {
                if let _ = self.tileDefinition(atColumn: col, row: row) {
                    let x = round(CGFloat(col) * tilesize.width - halfwidth + (tilesize.width / 2))
                    let y = round(CGFloat(row) * tilesize.height - halfheight + (tilesize.height / 2))
                    
                    let tile = SKSpriteNode()
                    tile.position = CGPoint(x: x, y: y)
                    tile.size = CGSize(width: 16, height: 16)

                    tileArray.append(tile)
                    tilePositionArray.append(tile.position)
                }
            }
        }
        
        // 2. Find adjacent tiles
        let tileWidth = self.tileSize.width
        let tileHeight = self.tileSize.height
        let radiusTileWidth = 0.5 * tileWidth
        let radiusTileHeight = 0.5 * tileHeight

        var tileIndex: Int = 0
        var tileIndex2: Int = 0
        var index: Int = 0
        var downLeftPosition: CGPoint = .zero

        var topLeftPositions = [CGPoint]()
        var topRightPositions = [CGPoint]()

        for tilePosition in tilePositionArray {

            if (tileIndex-1 < 0) || (tilePositionArray[tileIndex - 1].y != tilePositionArray[tileIndex].y - tileHeight) {
                downLeftPosition = CGPoint(x: tilePosition.x - radiusTileWidth, y: tilePosition.y - radiusTileHeight)
            }

            if (tileIndex + 1 > tilePositionArray.count - 1) {
                
                topLeftPositions.append(downLeftPosition)
                topRightPositions.append(CGPoint(x: tilePosition.x + radiusTileWidth, y: tilePosition.y + radiusTileHeight))

            } else if (tilePositionArray[tileIndex + 1].y != tilePositionArray[tileIndex].y + tileHeight) {

                if let _ = topRightPositions.first(where: {
                    if $0 == CGPoint(x: tilePosition.x + radiusTileWidth - tileWidth, y: tilePosition.y + radiusTileHeight) {index = topRightPositions.firstIndex(of: $0)!}
                    return $0 == CGPoint(x: tilePosition.x + radiusTileWidth - tileWidth, y: tilePosition.y + radiusTileHeight)}) {

                    if topLeftPositions[index].y == downLeftPosition.y {
                        topRightPositions[index] = CGPoint(x: tilePosition.x + radiusTileWidth, y: tilePosition.y + radiusTileHeight)
                    } else {
                        topLeftPositions.append(downLeftPosition)
                        topRightPositions.append(CGPoint(x: tilePosition.x + radiusTileWidth, y: tilePosition.y + radiusTileHeight))
                    }
                    
                } else {
                    topLeftPositions.append(downLeftPosition)
                    topRightPositions.append(CGPoint(x: tilePosition.x + radiusTileWidth, y: tilePosition.y + radiusTileHeight))
                }

            }

            tileIndex+=1
            
        }
        
        // 3. Draw rectangle from adjacent tiles
        for tilePosition in topLeftPositions {

            let size = CGSize(width: abs(tilePosition.x - topRightPositions[tileIndex2].x), height: abs(tilePosition.y - topRightPositions[tileIndex2].y))
            let physicsNode = SKNode()

            physicsNode.physicsBody = SKPhysicsBody(rectangleOf: size)
            physicsNode.physicsBody?.affectedByGravity = false
            physicsNode.physicsBody?.allowsRotation = false
            physicsNode.physicsBody?.restitution = 0.0
            physicsNode.physicsBody?.isDynamic = false

            physicsNode.physicsBody?.categoryBitMask = categoryMask

            physicsNode.position.x = tilePosition.x + size.width / 2
            physicsNode.position.y = tilePosition.y + size.height / 2

            self.addChild(physicsNode)

            tileIndex2 += 1

        }
        
    }
    
}

