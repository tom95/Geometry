"
I am a rectangle. See my parent for API
"
Class {
	#name : #GRectangle,
	#superclass : #GPolygon,
	#category : #'Geometry-Shapes'
}

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
GRectangle >> diagonals [
	^ {((self vertices at: 1) segment: (self vertices at: 3)).
	((self vertices at: 2) segment: (self vertices at: 4))}
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
GRectangle >> hasPoint: aGPoint [
	self deprecated: 'Use #hasPoint:' transformWith: '`@receiver hasPoint: `@statements' -> '`@receiver includesPoint: `@statements'.
	^ self includesPoint: aGPoint
]

{ #category : #accessing }
GRectangle >> height [
	"Answer the height of the receiver."

	^ (self vertices at: 2) distanceTo: (self vertices at: 3)
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

{ #category : #enumerating }
GRectangle >> sideWhichHas: point [
	^ self edges detect: [ :edge | edge includesPoint: point ]
]

{ #category : #accessing }
GRectangle >> width [
	"Answer the width of the receiver."

	^ (self vertices at: 2) distanceTo: (self vertices at: 1)
]
