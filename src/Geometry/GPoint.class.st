Class {
	#name : #GPoint,
	#superclass : #Object,
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

	^ coordinates := coordinates + aVector coordinates
]
