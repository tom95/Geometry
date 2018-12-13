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
	
	^ self newVertices: { or . (cor x , or y). cor. (or x , cor y) }
]

{ #category : #'instance creation' }
GRectangle class >> origin: originPoint extent: extentPoint [
	"Answer an instance of me whose top left corner is originPoint and width by height is extentPoint. Note that extentPoint should be non negative since it represents the size of the rectangle"

	^ self
		origin: originPoint
		corner: (originPoint x + (extentPoint x max: 0)) @ (originPoint y + (extentPoint y max: 0))
]

{ #category : #accessing }
GRectangle >> area [
	"Answer the receiver's area, the product of width and height."

	^ self width * self height max: 0
]

{ #category : #accessing }
GRectangle >> bottom [
	"Answer the position of the receiver's bottom horizontal line."

	^ self corner y
]

{ #category : #accessing }
GRectangle >> bottomCenter [
	"Answer the point at the center of the bottom horizontal line of the 
	receiver."

	^ self center x @ self bottom
]

{ #category : #accessing }
GRectangle >> bottomLeft [
	"Answer the point at the left edge of the bottom horizontal line of the 
	receiver."

	^ self origin x @ self corner y
]

{ #category : #accessing }
GRectangle >> bottomRight [
	"Answer the point at the right edge of the bottom horizontal line of the 
	receiver."

	^ self corner
]

{ #category : #accessing }
GRectangle >> center [
	"Answer the point at the center of the receiver."

	^ (self topLeft segment: self bottomRight) midPoint
]

{ #category : #accessing }
GRectangle >> corner [
	"Answer the point at the bottom right corner of the receiver."

	| or |
	or := 0 , 0.
	^ self vertices fold: [ :ver1 :ver2 | ((ver1 distanceTo: or) > (ver2 distanceTo: or)) ifTrue: [ ver1 ] ifFalse: [ ver2 ] ]
]

{ #category : #accessing }
GRectangle >> corners [
	"Return an array of corner points in the order of a quadrilateral spec for WarpBlt."

	^ Array
		with: self topLeft
		with: self bottomLeft
		with: self bottomRight
		with: self topRight
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
	"Answer a point with the receiver's width @ the receiver's height."

	^ (self corner coordinates - self origin coordinates) asGVector
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

	^ self corner y - self origin y
]

{ #category : #testing }
GRectangle >> includesRect: aRect [
	"Answer whether aRect is within the receiver."

	^ aRect origin >= self origin and: [ aRect corner <= self corner ]
]

{ #category : #accessing }
GRectangle >> innerCorners [
	"Return an array of inner corner points,
	ie, the most extreme pixels included,
	in the order of a quadrilateral spec for WarpBlt"

	| r1 |
	r1 := self topLeft corner: self bottomRight - (1 @ 1).
	^ Array
		with: r1 topLeft
		with: r1 bottomLeft
		with: r1 bottomRight
		with: r1 topRight
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
GRectangle >> left [
	"Answer the position of the receiver's left vertical line."

	^ self origin x
]

{ #category : #accessing }
GRectangle >> leftCenter [
	"Answer the point at the center of the receiver's left vertical line."

	^ self left @ self center y
]

{ #category : #accessing }
GRectangle >> origin [
	"Answer the point at the top left corner of the receiver."

	| or |
	or := 0 , 0.
	^ self vertices fold: [ :ver1 :ver2 | ((ver1 distanceTo: or) < (ver2 distanceTo: or)) ifTrue: [ ver1 ] ifFalse: [ ver2 ] ]
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
GRectangle >> top [
	"Answer the position of the receiver's top horizontal line."

	^ self origin y
]

{ #category : #accessing }
GRectangle >> topCenter [
	"Answer the point at the center of the receiver's top horizontal line."

	^ self center x @ self top
]

{ #category : #accessing }
GRectangle >> topLeft [
	"Answer the point at the top left corner of the receiver's top horizontal line."

	^ self origin
]

{ #category : #accessing }
GRectangle >> topRight [
	"Answer the point at the top right corner of the receiver's top horizontal 
	line."

	^ self corner x @ self origin y
]

{ #category : #accessing }
GRectangle >> width [
	"Answer the width of the receiver."

	^ self corner x - self origin x
]
