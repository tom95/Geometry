"
Description
--------------------

A ray starts out at a point and continues off to infinity

A ray is a geometry figure defined by an initial point, the origin, and another point to define a direction.

Examples
--------------------

	GRay origin: 0 , -1 direction: 1 , 4.
	
	(GRay origin: 100 , 100 direction: 80 , 110) flipped.
	
	(GRay origin: 100 , 100 direction: 80 , 110) includes: 120 , 90.
	
	(GRay origin: 0 , 0 direction: 1 , 1) intersectionsWith: GRay origin: 2 , 3 direction: 2 , 0.
	
	(GRay origin: -1 , -4 direction: 1 , -2) translateBy: #(1 -2).
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	directionPoint:		<aGPoint>		A point that can be anywhere on the ray and defining the direction of the ray.
	initialPoint:		<aGPoint>		A GPoint defining the end point of the ray.

"
Class {
	#name : #GRay,
	#superclass : #G1DElement,
	#instVars : [
		'initialPoint',
		'directionPoint'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GRay class >> origin: aGPoint direction: anotherPoint [
	^ self new
		initialPoint: aGPoint;
		directionPoint: anotherPoint;
		yourself
]

{ #category : #comparing }
GRay >> = aRay [
	self == aRay ifTrue: [ ^ true ].
	self class = aRay class ifFalse: [ ^ false ].

	^ self initialPoint =~ aRay initialPoint and: [ (self angleWith: aRay) isZero ]
]

{ #category : #arithmetic }
GRay >> angleWith: aGRay [ 
	^ (self directionPoint - self initialPoint) angleWith: (aGRay directionPoint - aGRay initialPoint)
]

{ #category : #converting }
GRay >> asGLine [
	^ GLine through: self initialPoint and: self directionPoint
]

{ #category : #accessing }
GRay >> directionPoint [
	^ directionPoint 

]

{ #category : #accessing }
GRay >> directionPoint: aGPoint [
	directionPoint := aGPoint asGPoint
]

{ #category : #properties }
GRay >> flipped [
	^ self class origin: self initialPoint direction: initialPoint + (initialPoint - directionPoint)
]

{ #category : #comparing }
GRay >> hash [
	"We define the hash by its origin and the angle the ray has with the x axis."

	^ self initialPoint hash bitXor: (self directionPoint - self initialPoint angleWith: {1 . 1} asGVector) hash
]

{ #category : #testing }
GRay >> includes: aPoint [
	^ ((self directionPoint - self initialPoint) angleWith: (aPoint - self initialPoint)) isZero
]

{ #category : #accessing }
GRay >> initialPoint [ 
	^ initialPoint

]

{ #category : #accessing }
GRay >> initialPoint: aGPoint [
	initialPoint := aGPoint asGPoint
]

{ #category : #intersections }
GRay >> intersectionsWith: anElement [
	^ anElement intersectionsWithRay: self
]

{ #category : #intersections }
GRay >> intersectionsWithEllipse: aGEllipse [	
	^ aGEllipse intersectionsWithRay: self
]

{ #category : #intersections }
GRay >> intersectionsWithLine: aGLine [
	^ aGLine intersectionsWithRay: self
]

{ #category : #accessing }
GRay >> length [
	"A ray is not finite."

	^ Float infinity
]

{ #category : #transforming }
GRay >> translateBy: aGVector [ 
	initialPoint := initialPoint + aGVector.
	directionPoint := directionPoint + aGVector
]
