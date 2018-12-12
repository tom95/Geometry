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
	^ self copy
		translateBy: aGVector;
		yourself
]

{ #category : #comparing }
GPoint >> = anotherPoint [
	"Answer whether the receiver and anObject represent the same object."

	self == anotherPoint ifTrue: [ ^ true ].
	self class = anotherPoint class ifFalse: [ ^ false ].

	^ coordinates = anotherPoint coordinates
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
GPoint >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ coordinates hash squared "Try to avoid collisions with GAbstractCoordinates"
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
