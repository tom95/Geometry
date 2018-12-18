Class {
	#name : #GEllipse,
	#superclass : #GShape,
	#instVars : [
		'center',
		'vertex',
		'coVertex'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GEllipse class >> center: aGPoint vertex: aGPoint2 coVertex: aGPoint3 [
	^ self new
		center: aGPoint;
		vertex: aGPoint2;
		coVertex: aGPoint3;
		yourself
]

{ #category : #comparing }
GEllipse >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ vertex = anObject vertex and: [ center = anObject center and: [ coVertex = anObject coVertex ] ]
]

{ #category : #accessing }
GEllipse >> area [
	"pi * a * b"

	^ Float pi * self semiMajorAxisLength * self semiMinorAxisLength
]

{ #category : #accessing }
GEllipse >> center [
	^ center
]

{ #category : #accessing }
GEllipse >> center: anObject [
	center := anObject
]

{ #category : #accessing }
GEllipse >> coVertex [
	^ coVertex
]

{ #category : #accessing }
GEllipse >> coVertex: anObject [
	coVertex := anObject
]

{ #category : #accessing }
GEllipse >> encompassingRectangle [
	| radiuxPoints |
	radiuxPoints := { vertex . (center + (center - vertex)). coVertex . (center + (center - coVertex)) } collect: #coordinates.
	^ (radiuxPoints fold: [ :pt1 :pt2 | pt1 upperLimitsWith: pt2 ]) asGPoint corner: (radiuxPoints fold: [ :pt1 :pt2 | pt1 lowerLimitsWith: pt2 ]) asGPoint
]

{ #category : #accessing }
GEllipse >> foci [
	self shouldBeImplemented.
]

{ #category : #accessing }
GEllipse >> fociLocation [
	"c² = a² - b²"

	^ (self semiMajorAxisLength squared - self semiMinorAxisLength squared) sqrt
]

{ #category : #comparing }
GEllipse >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ vertex hash bitXor: (center hash bitXor: coVertex hash)
]

{ #category : #intersections }
GEllipse >> intersectionsWith: anElement [
	^ anElement intersectionWithEllipse: self
]

{ #category : #accessing }
GEllipse >> majorAxis [
	^ GSegment with: center + (center - vertex) with: center + (vertex - center)
]

{ #category : #accessing }
GEllipse >> majorAxisLength [
	^ self majorAxis length
]

{ #category : #accessing }
GEllipse >> minorAxis [
	^ GSegment with: center + (center - coVertex) with: center + (coVertex - center)
]

{ #category : #accessing }
GEllipse >> minorAxisLength [
	^ self minorAxis length
]

{ #category : #accessing }
GEllipse >> semiMajorAxisLength [
	^ self majorAxis length / 2
]

{ #category : #accessing }
GEllipse >> semiMinorAxisLength [
	^ self minorAxis length / 2
]

{ #category : #transforming }
GEllipse >> translateBy: aGVector [ 
	center translateBy: aGVector.
	vertex translateBy: aGVector.
	coVertex translateBy: aGVector
]

{ #category : #accessing }
GEllipse >> vertex [
	^ vertex
]

{ #category : #accessing }
GEllipse >> vertex: anObject [
	vertex := anObject
]
