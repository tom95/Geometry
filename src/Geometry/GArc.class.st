"
Description
--------------------

In Euclidean geometry, an arc is a closed segment of a differentiable curve.

It is defined by 3 points:
- The center of the arc
- The origin of the arc
- A point defining the direction of the arc in the trigonometric direction

Examples
--------------------

	TODO
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	center:		<Object>
	direction:		<Object>
	origin:		<Object>

"
Class {
	#name : #GArc,
	#superclass : #G1DElement,
	#instVars : [
		'center',
		'origin',
		'direction'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GArc class >> center: aGPoint origin: anotherGPoint direction: yetAnotherGPoint [
	^ self new
		center: aGPoint;
		origin: anotherGPoint;
		direction: yetAnotherGPoint;
		yourself
]

{ #category : #comparing }
GArc >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ origin = anObject origin and: [ center = anObject center and: [ self angle = anObject angle ] ]
]

{ #category : #accessing }
GArc >> angle [
	^ (self origin - self center) angleWith: (self direction - self center)
]

{ #category : #accessing }
GArc >> center [
	^ center
]

{ #category : #accessing }
GArc >> center: anObject [
	center := anObject
]

{ #category : #accessing }
GArc >> centralAngle [
	"Alias of angle to cover the geometric names"

	^ self angle
]

{ #category : #accessing }
GArc >> direction [
	"The direction is a point defining the arc angle of the arc from the origin in the trigonometric direct sense. It does not need to be in the circle defined by the center and the origin."

	^ direction
]

{ #category : #accessing }
GArc >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
GArc >> endPoint [
	"The end point is the point at the end of the arc (opposed to the origin).
	
	We can find it by finding the intersection point of the circle containing the arc and a ray from the center to the direction point"

	^ ((GRay origin: self center direction: self direction) intersectionsWith: (GCircle center: self center radius: self radius)) anyOne
]

{ #category : #comparing }
GArc >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ origin hash bitXor: (center hash bitXor: self angle hash)
]

{ #category : #testing }
GArc >> includes: aGPoint [
	"An arc includes a point in the angle between the vector defined by the origin and center and the vector defined by the point and the center is between 0 and the arc angle and if the distance of the point from the center is equals to the radius."

	^ ((self origin - self center angleWith: aGPoint - self center) < self angle)
		and: [ (aGPoint distanceTo: self center) =~ self radius ]
]

{ #category : #intersections }
GArc >> intersectionsWith: anElement [
	^ anElement intersectionsWithArc: self
]

{ #category : #intersections }
GArc >> intersectionsWithEllipse: aGEllipse [
	^ aGEllipse intersectionsWithArc: self
]

{ #category : #intersections }
GArc >> intersectionsWithLine: aGLine [ 
	^ aGLine intersectionsWithArc: self
]

{ #category : #accessing }
GArc >> length [
	^ self angle radians * self radius
]

{ #category : #accessing }
GArc >> origin [
	^ origin
]

{ #category : #accessing }
GArc >> origin: anObject [
	origin := anObject
]

{ #category : #comparing }
GArc >> printOn: aStream [
	super printOn: aStream.

	aStream
		<< $(;
		<< 'center: ';
		print: center coordinates;
		<< ' | origin: ';
		print: origin coordinates;
		<< ' | angle: ';
		print: self angle;
		<< $)
]

{ #category : #accessing }
GArc >> radius [
	^ (self origin - self center) length
]

{ #category : #comparing }
GArc >> translateBy: aGVector [ 
	self center: self center + aGVector.
	self origin: self origin + aGVector.
	self direction: self direction + aGVector
]
