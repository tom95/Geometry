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
	[ lastPoint := nextPoint.
	convexHull add: lastPoint.
	nextPoint := aCollection detect: [ :point | point ~= lastPoint ].
	(aCollection copyWithout: nextPoint)
		do: [ :point | 
			| turn |
			turn := (nextPoint x - lastPoint x) * (point y - lastPoint y)
				- ((point x - lastPoint x) * (nextPoint y - lastPoint y)).
			(turn < 0
				or: [ turn = 0
						and: [ (lastPoint distanceTo: point) > (lastPoint distanceTo: nextPoint) ] ])
				ifTrue: [ nextPoint := point ] ] ]
		doWhileTrue: [ convexHull first ~= nextPoint ].

	^ self vertices: convexHull
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
	self deprecated: 'Use #vertices: instead' transformWith: '`@receiver newVertices: `@statements' -> '`@receiver vertices: `@statements'.
	^ self vertices: aCollection
]

{ #category : #'instance creation' }
GPolygon class >> vertices: aCollection [
	^ self new
		vertices: aCollection;
		yourself
]

{ #category : #comparing }
GPolygon >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ vertices = anObject vertices
]

{ #category : #testing }
GPolygon >> boundaryContains: aGPoint [ 
	^ self edges anySatisfy: [ :segment | segment includesPoint: aGPoint ]
]

{ #category : #accessing }
GPolygon >> edges [
	| edges |
	edges := (self vertices overlappingPairsCollect: [ :point1 :point2 | (GSegment with: point1 with: point2) ]) asOrderedCollection.
	edges add: (GSegment with: self vertices last with: self vertices first).
	^ edges
]

{ #category : #accessing }
GPolygon >> encompassingRectangle [
	| origin corner |
	origin := ((self vertices collect: #coordinates) fold: [ :coor1 :coor2 | coor1 lowerLimitsWith: coor2 ]) asGPoint.
	corner := ((self vertices collect: #coordinates) fold: [ :coor1 :coor2 | coor1 upperLimitsWith: coor2 ]) asGPoint.
	^ GRectangle origin: origin corner: corner
]

{ #category : #'rectangle functions' }
GPolygon >> expandBy: anInteger [
	self fitInExtent: self extent + (2 * {anInteger . anInteger} asGVector)
]

{ #category : #transforming }
GPolygon >> fitInExtent: extent [
	"I take as parameter a point and will fit the polygon in a rectangle whose dimensions is defined by the extent."

	| scales |
	scales := extent coordinatesWith: self encompassingRectangle extent coordinates collect: [ :number1 :number2 | number1 / number2 ].
	vertices := self vertices collect: [ :vertice | ((vertice - self center) coordinates coordinatesWith: scales collect: [ :a :b | a * b ]) asGVector + self center ]
]

{ #category : #testing }
GPolygon >> hasOnBoundary: point [
	^ self edges anySatisfy: [ :edge | edge includesPoint: point ]
]

{ #category : #comparing }
GPolygon >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ vertices hash bitXor: self class hash
]

{ #category : #testing }
GPolygon >> includesPoint: point [
	^ (AthensPolygonTester new polygon: vertices) includesPoint: point
]

{ #category : #intersections }
GPolygon >> intersectionsWith: anElement [
	^ anElement intersectionsWithPolygon: self
]

{ #category : #intersections }
GPolygon >> intersectionsWithEllipse: aGEllipse [
	^ aGEllipse intersectionsWithPolygon: self
]

{ #category : #intersections }
GPolygon >> intersectionsWithLine: aGLine [
	^ aGLine intersectionsWithPolygon: self
]

{ #category : #accessing }
GPolygon >> perimeter [
	^ self edges sum: #length
]

{ #category : #transforming }
GPolygon >> scaleBy: anInteger [

	anInteger <= 0 ifTrue: [ self error: 'Scale must be over zeo' ].

	vertices := self vertices collect: [ :vertice | (vertice - self center) * anInteger + self center ]
]

{ #category : #enumerating }
GPolygon >> sideWhichHas: point [
	^ self edges detect: [ :edge | edge includesPoint: point ]
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
GPolygon >> vertices: aCollection [
	vertices := aCollection collect: #asGPoint
]
