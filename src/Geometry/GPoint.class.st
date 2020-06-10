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
	
	GPoint withCollection: #(1 4 2). ""a GPoint(1,4,2)""
	
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
	#superclass : #G1DElement,
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

{ #category : #arithmetic }
GPoint >> additionWithVector: aGVector [
	^ self + aGVector
]

{ #category : #converting }
GPoint >> asGPoint [
	^ self
]

{ #category : #converting }
GPoint >> asPoint [
	^ self x @ self y
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
	
	The distance between two points is the length of the vector transposing v1 into v2"
	
	^ (self - aGPoint) length
]

{ #category : #comparing }
GPoint >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ coordinates hash squared "Try to avoid collisions with GAbstractCoordinates"
]

{ #category : #testing }
GPoint >> includes: aGPoint [
	^ aGPoint =~ self
]

{ #category : #intersections }
GPoint >> intersectionsWith: anElement [
	^ anElement intersectionsWithPoint: self
]

{ #category : #intersections }
GPoint >> intersectionsWithEllipse: aGEllipse [ 
	^ aGEllipse intersectionsWithPoint: self
]

{ #category : #intersections }
GPoint >> intersectionsWithLine: aGLine [ 
	^ aGLine intersectionsWithPoint: self
]

{ #category : #accessing }
GPoint >> length [
	"https://math.stackexchange.com/questions/1936865/what-is-the-length-of-a-point-on-the-real-number-line"

	^ 0
]

{ #category : #transformations }
GPoint >> rotateBy: aGAngle [
	"Rotate the point around the origin (0,0) of the plan.
	
	This will change the receiver. To get a new point use #rotatedBy:.
	
	This is only valid for 2D points."

	self rotateBy: aGAngle about: 0 , 0
]

{ #category : #transformations }
GPoint >> rotateBy: aGAngle about: aGPoint [
	"Rotate the point around the another point of the plan.
	
	This will change the receiver. To get a new point use #rotatedBy:about:.
	
	This is only valid for 2D points."

	| cos sin diffX diffY |
	cos := aGAngle cos.
	sin := aGAngle sin.
	diffX := self x - aGPoint x.
	diffY := self y - aGPoint y.
	self x: cos * diffX - (sin * diffY) + aGPoint x.
	self y: sin * diffX + (cos * diffY) + aGPoint y
]

{ #category : #transformations }
GPoint >> rotatedBy: aGAngle [
	"Rotate the point around the origin (0,0) of the plan.
	
	This will return a new point. To change the receiver use #rotateBy:.
	
	This is only valid for 2D points."

	^ self rotatedBy: aGAngle about: 0 , 0
]

{ #category : #transformations }
GPoint >> rotatedBy: aGAngle about: aGPoint [
	"Rotate the point around another point of the plan.
	
	This will return a new point. To change the receiver use #rotateBy:about:.
	
	This is only valid for 2D points."

	| cos sin diffX diffY |
	cos := aGAngle cos.
	sin := aGAngle sin.
	diffX := self x - aGPoint x.
	diffY := self y - aGPoint y.
	^ cos * diffX - (sin * diffY) + aGPoint x , (sin * diffX + (cos * diffY) + aGPoint y)
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
