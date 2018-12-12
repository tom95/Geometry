"
Description
--------------------

I represent a geometric point. In the contrary of default Pharo point, I implement only the point logic and cannot be used as a vector. 

Vectors can be used with GVector.

I am based on a set of coordinates and my API should be independent from the number of dimensions of the current space. The computations will rely on coordinates.

Examples
--------------------

	""Instance creation""
	
	GPoint withCollection: #(1 2).	 ""a GPoint(1,2)""
	
	GPoint coordinates: (GCoordinates withCollection: #(1 3)). 	""a GPoint(1,3)""
	
	(GCoordinates withCollection: #(1 3)) asGPoint.	""a GPoint(1,3)""
	
	#(1 2) asGPoint.	""a GPoint(1,2)""
		
	1 , 2.		""a GPoint(1,2)""		
		
	""Arithmetic""
	(1 , 2) + (2 , 3). ""a GPoint(3,5) <= This will be a new instance.""
	
	(1, 2) translateBy: (2 , 3).	""a GPoint(3,5) <= This will be the same instance than the receiver"" 
		
	(4, 2) - (1, 1).	""a GVector(3,1)""
		
	(3, 5) middlePointTo: (9, 15).	""a GPoint(6,10)""
	
	(3, 5) distanceTo: (9, 15).	""11.661903789690601""
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	coordinates:		<aGCoordinates> 	I represent the coordinates of the point.

"
Class {
	#name : #GPoint,
	#superclass : #GElement,
	#traits : 'TGWithCoordinates',
	#classTraits : 'TGWithCoordinates classTrait',
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GPoint class >> coordinates: aCoordinates [
	^ self new
		coordinates: aCoordinates;
		yourself
]

{ #category : #'instance creation' }
GPoint class >> withCollection: aCollection [
	^ self coordinates: (GCoordinates withCollection: aCollection)
]

{ #category : #'instance creation' }
GPoint class >> x: aNumber y: anotherNumber [
	^ self new
		coordinates: (G2DCoordinates x: aNumber y: anotherNumber);
		yourself
]

{ #category : #arithmetic }
GPoint >> + aGVector [
	"I return a new point translated by a vector"

	^ self copy
		translateBy: aGVector;
		yourself
]

{ #category : #arithmetic }
GPoint >> - aPoint [
	"I return a vector represented by the substraction of two points"

	^ (self coordinates - aPoint coordinates) asGVector
]

{ #category : #comparing }
GPoint >> = anotherPoint [
	"Answer whether the receiver and anObject represent the same object."

	self == anotherPoint ifTrue: [ ^ true ].
	self class = anotherPoint class ifFalse: [ ^ false ].

	^ coordinates = anotherPoint coordinates
]

{ #category : #comparing }
GPoint >> =~ aPoint [
	^ (self distanceTo: aPoint) =~ 0

]

{ #category : #converting }
GPoint >> asGPoint [
	^ self
]

{ #category : #accessing }
GPoint >> coordinates [
	^ coordinates
]

{ #category : #accessing }
GPoint >> coordinates: anObject [
	coordinates := anObject
]

{ #category : #comparing }
GPoint >> distanceTo: aGPoint [ 
	"Answer the distance between aPoint and the receiver.
	
	Create a vector from the substraction between me and the argument and ask its size."
	
	^ (self - aGPoint) length
]

{ #category : #comparing }
GPoint >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ coordinates hash squared "Try to avoid collisions with GAbstractCoordinates"
]

{ #category : #accessing }
GPoint >> middlePointTo: aGPoint [
	self flag: #todo. "Ask Guillaume if it's the best solution and add test"
	^ ((self coordinates + aGPoint coordinates) / 2) asGPoint
]

{ #category : #accessing }
GPoint >> segment: aPoint [ 
	^ GSegment with: self with: aPoint 
]

{ #category : #transforming }
GPoint >> translateBy: aVector [ 
	"Answer a Point translated by a vector."

	coordinates := coordinates + aVector coordinates
]
