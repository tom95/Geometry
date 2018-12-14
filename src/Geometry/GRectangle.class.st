"
I am a rectangle. See my parent for API
"
Class {
	#name : #GRectangle,
	#superclass : #GPolygon,
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GRectangle class >> center: centerPoint extent: extentPoint [
	"Answer an instance of me whose center is centerPoint and width 
	by height is extentPoint.  "

	^ self origin: centerPoint - (extentPoint / 2) extent: extentPoint
]

{ #category : #'instance creation' }
GRectangle class >> encompassing: listOfPoints [
	| topLeft bottomRight |
	topLeft := bottomRight := listOfPoints first.
	listOfPoints
		allButFirstDo: [ :p | 
			topLeft := topLeft min: p.
			bottomRight := bottomRight max: p ].
	^ self origin: topLeft corner: bottomRight
]

{ #category : #'instance creation' }
GRectangle class >> left: left right: right top: top bottom: bottom [
	"Answer an instance of me whose left, right, top, and bottom coordinates 
	are determined by the arguments."

	| origin corner |
	origin := (left min: right) @ (top min: bottom).
	corner := (left max: right) @ (top max: bottom).

	^ self origin: origin corner: corner
]

{ #category : #'instance creation' }
GRectangle class >> merging: rectangles [
	"A number of callers of merge: should use this method."

	| minX minY maxX maxY |
	minX := (rectangles collect: [ :rec | rec origin x ]) min.
	minY := (rectangles collect: [ :rec | rec origin y ]) min.
	maxX := (rectangles collect: [ :rec | rec corner x ]) max.
	maxY := (rectangles collect: [ :rec | rec corner y ]) max.

	^ self origin: minX @ minY corner: maxX @ maxY
]

{ #category : #'instance creation' }
GRectangle class >> origin: point1 corner: point2 [
	"Answer an instance of me whose corners (top left and bottom right) are 
	determined by the arguments."

	| or cor |
	or := (point1 x min: point2 x) , (point1 y min: point2 y).
	cor := (point1 x max: point2 x) , (point1 y max: point2 y).
	
	or = cor ifTrue: [ self error: 'This is not a rectangle but a point.' ].
	
	^ self vertices: { or . (cor x , or y). cor. (or x , cor y) }
]

{ #category : #'instance creation' }
GRectangle class >> origin: originPoint extent: extentPoint [
	"Answer an instance of me whose top left corner is originPoint and width by height is extentPoint. Note that extentPoint should be non negative since it represents the size of the rectangle"

	^ self
		origin: originPoint
		corner: (originPoint x + (extentPoint x max: 0)) @ (originPoint y + (extentPoint y max: 0))
]

{ #category : #'instance creation' }
GRectangle class >> vertices: aCollection [
	aCollection size = 4 ifFalse: [ self error: 'A Rectangle should have 4 vertices.' ].
	self flag: #todo. "We should also check other properties of the rectangle."

	^ super vertices: aCollection
]

{ #category : #accessing }
GRectangle >> area [
	"Answer the receiver's area, the product of width and height."

	^ self width * self height max: 0
]

{ #category : #accessing }
GRectangle >> center [
	"Answer the point at the center of the receiver."

	^ self diagonals anyOne midPoint
]

{ #category : #accessing }
GRectangle >> corner [
	"Answer the point at the bottom right corner of the receiver."

	| topLeftMost | 
	topLeftMost := Float negativeInfinity , Float negativeInfinity.
	^ self vertices fold: [ :ver1 :ver2 | ((ver1 distanceTo: topLeftMost) > (ver2 distanceTo: topLeftMost)) ifTrue: [ ver1 ] ifFalse: [ ver2 ] ]
]

{ #category : #accessing }
GRectangle >> diagonals [
	^ {((self vertices at: 1) segment: (self vertices at: 3)).
	((self vertices at: 2) segment: (self vertices at: 4))}
]

{ #category : #accessing }
GRectangle >> edges [
	^ {(GSegment with: self origin with: self origin x @ self corner y).
	(GSegment with: self origin x @ self corner y with: self corner).
	(GSegment with: self corner with: self corner x @ self origin y).
	(GSegment with: self corner x @ self origin y with: self origin)}
]

{ #category : #accessing }
GRectangle >> encompassingRectangle [
	^ self
]

{ #category : #accessing }
GRectangle >> extent [
	"Answer a vector representing the extent of my encompassing rectangle."

	| verticesCoordinates encompassingRectangleOrigin encompassingRectangleCorner |
	verticesCoordinates := self vertices collect: #coordinates.
	encompassingRectangleOrigin := verticesCoordinates fold: [:coor1 :coor2 | coor1 upperLimitsWith: coor2].
	encompassingRectangleCorner := verticesCoordinates fold: [:coor1 :coor2 | coor1 lowerLimitsWith: coor2].
	^ (encompassingRectangleOrigin - encompassingRectangleCorner) asGVector
]

{ #category : #testing }
GRectangle >> hasOnBoundary: point [
	^ self edges anySatisfy: [ :edge | edge includesPoint: point ]
]

{ #category : #testing }
GRectangle >> hasOnOneSide: point1 and: point2 [
	^ (point1 x = point2 x and: [ point1 x = self origin x or: [ point1 x = self corner x ] ])
		or: [ point1 y = point2 y and: [ point1 y = self origin y or: [ point1 y = self corner y ] ] ]
]

{ #category : #testing }
GRectangle >> hasPoint: aGPoint [
	self deprecated: 'Use #hasPoint:' transformWith: '`@receiver hasPoint: `@statements' -> '`@receiver includesPoint: `@statements'.
	^ self includesPoint: aGPoint
]

{ #category : #accessing }
GRectangle >> height [
	"Answer the height of the receiver."

	^ (self vertices at: 2) distanceTo: (self vertices at: 3)
]

{ #category : #testing }
GRectangle >> includesRect: aRect [
	"Answer whether aRect is within the receiver."

	^ aRect origin >= self origin and: [ aRect corner <= self corner ]
]

{ #category : #comparing }
GRectangle >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectRectangle: self
]

{ #category : #intersections }
GRectangle >> intersectionPointWithRay: ray [
	^ self edges collect: [ :edge | edge intersectionPointWithRay: ray ] thenReject: #isNil
]

{ #category : #intersections }
GRectangle >> intersectionPointsWithLine: line [
	| points |
	points := OrderedCollection new.
	self edges
		do: [ :edge | 
			| point |
			point := edge intersectionPointWithLine: line.
			point
				ifNotNil: [ (points noneSatisfy: [ :pi | pi =~ point ])
						ifTrue: [ points add: point ] ] ].
	^ points

	"^ self edges collect:[ :edge | edge intersectionPointWithLine: line]  
				thenReject: #isNil."
]

{ #category : #intersections }
GRectangle >> intersectionPointsWithSegment: segm [
	^ self edges collect: [ :edge | edge intersectionPointWithSegment: segm ] thenReject: #isNil
]

{ #category : #accessing }
GRectangle >> origin [
	"Answer the point at the top left corner of the receiver."

	| topLeftMost |
	topLeftMost := Float negativeInfinity , Float negativeInfinity.
	^ self vertices
		fold: [ :ver1 :ver2 | 
			(ver1 distanceTo: topLeftMost) < (ver2 distanceTo: topLeftMost)
				ifTrue: [ ver1 ]
				ifFalse: [ ver2 ] ]
]

{ #category : #accessing }
GRectangle >> right [
	"Answer the position of the receiver's right vertical line."

	^ self corner x
]

{ #category : #accessing }
GRectangle >> rightCenter [
	"Answer the point at the center of the receiver's right vertical line."

	^ self right @ self center y
]

{ #category : #transforming }
GRectangle >> scaleBy: scale [
	"Answer a Rectangle scaled by scale, a Point or a scalar."

	"scale <= 0 ifTrue: [ self error: 'Scale must be over zeo' ].

	^ self origin: origin * scale corner: corner * scale"
	
	self flag: #todo. "check if this is right"
	^ super scaleBy: scale
]

{ #category : #enumerating }
GRectangle >> sideWhichHas: point [
	^ self edges detect: [ :edge | edge includesPoint: point ]
]

{ #category : #accessing }
GRectangle >> width [
	"Answer the width of the receiver."

	^ (self vertices at: 2) distanceTo: (self vertices at: 1)
]
