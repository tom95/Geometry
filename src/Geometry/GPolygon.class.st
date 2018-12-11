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
				[ (lastPoint dist: point) > (lastPoint dist: nextPoint) ] ]) ifTrue:
					[ nextPoint := point ] ] ] doWhileTrue: [
				convexHull first ~= nextPoint ].
		
	^ self newVertices: convexHull
				
]

{ #category : #'as yet unclassified' }
GPolygon class >> newVertices: aCollection [
	
	^ self new
		initializeVertices: aCollection;
		yourself.
]

{ #category : #accessing }
GPolygon >> center [
	| min max x y |
	min := vertices min.
	max := vertices max.
	x := (min x + max x)/2.0.
	y := (min y + max y)/2.0.
	^ x @ y
	

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
GPolygon >> encompasingRectangle [
	|leftMost rightMost top bottom|
	leftMost := vertices first. 
	rightMost := vertices first.
	top := vertices first. 
	bottom:= vertices first.
	vertices allButFirst do:[ :v | 
		(v y > top y) ifTrue:[ top := v ].
		(v y < bottom y) ifTrue:[ bottom := v ].
		(v x < leftMost x) ifTrue:[ leftMost := v ].
		(v x > rightMost x) ifTrue:[ rightMost := v ]].
	^Rectangle left: leftMost x right: rightMost x top: top y bottom: bottom y
]

{ #category : #converting }
GPolygon >> fitInExtent: extent [
	"I take as parameter a point and will fit the polygon in a rectangle whose dimensions is defined by the extent.
	
	To do that, I will first fit my vertices in a square of lenght of 1, then I will multiply my vertices by the extent required."

	| max verticesInSquareOfSizeOne |
	max := (self vertices collect: #x) max max: ((self vertices collect: #y )) max. "We do not take `self vertices max` because we want to preserve proportions"
	"Fit the polygon in a square of size 1 by doing a division of it's vertices by 2 times the value of the furthest point from the center of the polygon."
	verticesInSquareOfSizeOne := self vertices collect: [ :point | point / (max * 2) ].
	
	vertices := (verticesInSquareOfSizeOne collect: [ :point | point * extent ])
]

{ #category : #testing }
GPolygon >> includesPoint: point [
	^ (AthensPolygonTester new polygon: vertices) includesPoint: point
]

{ #category : #initialization }
GPolygon >> initializeVertices: aCollection [
	self initialize.
	
	vertices := aCollection 
]

{ #category : #comparing }
GPolygon >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectPolygon: self
]

{ #category : #converting }
GPolygon >> moveBy: aPoint [
	"Move a polygon by a delta defined by aPoint"

	vertices := self vertices collect: [ :point | point + aPoint ]
]

{ #category : #accessing }
GPolygon >> vertices [
	
	^ vertices
]
