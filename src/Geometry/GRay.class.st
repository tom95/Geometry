"
Description
--------------------

A ray starts out at a point and continues off to infinity

A ray is a geometry figure defined by an initial point, the origin, and another point to define a direction.

Examples
--------------------

TODO	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	directionPoint:		<aGPoint>		A point that can be anywhere on the ray and defining the direction of the ray.
	initialPoint:		<aGPoint>		A GPoint defining the end point of the ray.

"
Class {
	#name : #GRay,
	#superclass : #GElement,
	#instVars : [
		'initialPoint',
		'directionPoint'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GRay class >> origin: aGPoint direction: anotherPoint [
	^ self new
		initializeWithOrigin: aGPoint direction: anotherPoint;
		yourself
]

{ #category : #comparing }
GRay >> = aRay [
	self == aRay ifTrue: [ ^ true ].
	self class = aRay class ifFalse: [ ^ false ].

	^ self initialPoint =~ aRay initialPoint and: [ (self angleInRadiansWith: aRay) closeTo: 0 ]
]

{ #category : #arithmetic }
GRay >> angleInRadiansWith: aGRay [ 
	^ (self directionPoint - self initialPoint) angleInRadiansWith: (aGRay directionPoint - aGRay initialPoint)
]

{ #category : #converting }
GRay >> asLine [
	^ GLine through: self initialPoint and: self directionPoint
]

{ #category : #converting }
GRay >> asSegment [
	^ GSegment with: initialPoint with: directionPoint
]

{ #category : #accessing }
GRay >> directionPoint [
	^ directionPoint 

]

{ #category : #properties }
GRay >> flipped [
	^ self class origin: self initialPoint direction: initialPoint + (initialPoint - directionPoint)
]

{ #category : #comparing }
GRay >> hash [
	"We define the hash by its origin and the angle the ray has with the x axis."

	^ self initialPoint hash bitXor: (self directionPoint - self initialPoint angleInRadiansWith: {1 . 1} asGVector) hash
]

{ #category : #testing }
GRay >> includesPoint: aPoint [
	^ ((self directionPoint - self initialPoint) angleInRadiansWith: (aPoint - self initialPoint)) =~ 0
]

{ #category : #accessing }
GRay >> initialPoint [ 
	^ initialPoint

]

{ #category : #initialization }
GRay >> initializeWithOrigin: aGPoint direction: anotherGPoints [
	initialPoint  := aGPoint asGPoint.
	directionPoint  := anotherGPoints asGPoint
]

{ #category : #intersections }
GRay >> intersectionsWith: anElement [
	^ anElement intersectionsWithRay: self
]

{ #category : #intersections }
GRay >> intersectionsWithEllipse: aGEllipse [	
	^ (self asLine intersectionsWithEllipse: aGEllipse) select: [ :each | self includesPoint: each ]
]

{ #category : #intersections }
GRay >> intersectionsWithLine: aGLine [
	^ aGLine intersectionsWithRay: self
]

{ #category : #intersections }
GRay >> intersectionsWithRay: aGRay [ 
	^ (self asLine intersectionsWithRay: aGRay asLine) select: [ :each | self includesPoint: each ]
]

{ #category : #intersections }
GRay >> intersectionsWithSegment: aGSegment [ 
	^ aGSegment intersectionsWithRay: self
]

{ #category : #accessing }
GRay >> length [
	"A ray is not finite."

	^ Float infinity
]
