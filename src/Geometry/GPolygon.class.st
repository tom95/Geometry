"
I'm polygon builded on my vertices.


"
Class {
	#name : #GPolygon,
	#superclass : #GShape,
	#instVars : [
		'vertices'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'as yet unclassified' }
GPolygon class >> convexHullOn: aCollection [
	| lastPoint nextPoint convexHull |
"self halt."
	convexHull := OrderedCollection new.	
	nextPoint := aCollection detectMin: #x.
	 [
		lastPoint := nextPoint.
		convexHull add: lastPoint.
		nextPoint := aCollection detect: [ :point | point ~= lastPoint ].
		(aCollection copyWithout: nextPoint) do: [ :point |
			| turn |		
			turn :=
				(nextPoint x - lastPoint x) * (point y - lastPoint y) -
				((point x - lastPoint x) * (nextPoint y - lastPoint y)).
			(turn < 0 or:
				[ turn = 0 and:
				[ (lastPoint distanceTo: point) > (lastPoint distanceTo: nextPoint) ] ]) ifTrue:
					[ nextPoint := point ] ] ] doWhileTrue: [
				convexHull first ~= nextPoint ].
		
	^ self newVertices: convexHull
				
]

{ #category : #'instance creation' }
GPolygon class >> newRegularPolygonWithEdgeNumber: aNumber [
	"I return the polygon vertices for a regular polygon with a number of segment given as parameter.
	
	If Y give 8 as parameter I get an octogon."

	| angle encompassingCircleRadius |
	angle := 2 * Float pi / aNumber.
	encompassingCircleRadius := 0.5.
	^ self newVertices: ((1 to: aNumber) collect: [ :index | ((encompassingCircleRadius + index) * angle) sin , ((encompassingCircleRadius + index) * angle) cos negated ])
]

{ #category : #'instance creation' }
GPolygon class >> newVertices: aCollection [
	
	^ self new
		initializeVertices: aCollection;
		yourself.
]

{ #category : #accessing }
GPolygon >> edges [
	| edges firstVert prevVert |
	edges := OrderedCollection new.	
	firstVert := vertices at: 1.
	prevVert := firstVert.
	vertices allButFirstDo: [ :curVert |
		edges add: (GSegment with: prevVert with: curVert).
		prevVert := curVert ].
	edges add: (GSegment with: (vertices at: (vertices size)) with: firstVert).
	^ edges
]

{ #category : #accessing }
GPolygon >> encompassingRectangle [
	| origin corner |
	origin := ((self vertices collect: #coordinates) fold: [ :coor1 :coor2 | coor1 lowerLimitsWith: coor2 ]) asGPoint.
	corner := ((self vertices collect: #coordinates) fold: [ :coor1 :coor2 | coor1 upperLimitsWith: coor2 ]) asGPoint.
	^ GRectangle origin: origin corner: corner
]

{ #category : #transforming }
GPolygon >> fitInExtent: extent [
	"I take as parameter a point and will fit the polygon in a rectangle whose dimensions is defined by the extent."

	| scales |
	scales := extent coordinatesWith: self encompassingRectangle extent coordinates collect: [ :number1 :number2 | number1 / number2 ].
	vertices := self vertices collect: [ :vertice | ((vertice - self center) coordinates coordinatesWith: scales collect: [ :a :b | a * b ]) asGVector + self center ]
]

{ #category : #testing }
GPolygon >> includesPoint: point [
	^ (AthensPolygonTester new polygon: vertices) includesPoint: point
]

{ #category : #initialization }
GPolygon >> initializeVertices: aCollection [
	vertices := aCollection collect: #asGPoint
]

{ #category : #comparing }
GPolygon >> intersectLine: aLine [
	| intersections |
	intersections := Set new.
	self segmentsDo: [ :segment | (segment intersectionPointWithLine: aLine) ifNotNil: [ :point | intersections add: point ] ].
	^ intersections
]

{ #category : #comparing }
GPolygon >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectPolygon: self
]

{ #category : #transforming }
GPolygon >> moveBy: aPoint [
	"Move a polygon by a delta defined by aPoint"

	self deprecated: 'Use #translateBy:' transformWith: '`@receiver moveBy: `@statements' -> '`@receiver translateBy: `@statements'.
	self translateBy: aPoint
]

{ #category : #transforming }
GPolygon >> scaleBy: anInteger [
	vertices := self vertices collect: [ :vertice | (vertice - self center) * anInteger + self center ]
]

{ #category : #enumerating }
GPolygon >> segmentsDo: aBlock [
	self vertices overlappingPairsDo: [ :point1 :point2 | aBlock value: (GSegment with: point1 with: point2) ].
	aBlock value: (GSegment with: self vertices last with: self vertices first)
]

{ #category : #transforming }
GPolygon >> translateBy: aPoint [
	"Move a polygon by a delta defined by aPoint"

	vertices := self vertices collect: [ :point | point + aPoint ]
]

{ #category : #accessing }
GPolygon >> vertices [
	
	^ vertices
]

{ #category : #accessing }
GPolygon >> vertices: anObject [
	vertices := anObject
]
