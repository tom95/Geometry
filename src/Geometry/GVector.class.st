Class {
	#name : #GVector,
	#superclass : #Object,
	#traits : 'TGWithCoordinates',
	#classTraits : 'TGWithCoordinates classTrait',
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GVector class >> coordinates: aCoordinates [
	^ self new
		coordinates: aCoordinates;
		yourself
]

{ #category : #'instance creation' }
GVector class >> withCollection: aCollection [
	^ self coordinates: (GCoordinates withCollection: aCollection)
]

{ #category : #'instance creation' }
GVector class >> x: aNumber y: anotherNumber [
	^ self new
		coordinates: (G2DCoordinates x: aNumber y: anotherNumber);
		yourself
]

{ #category : #comparing }
GVector >> = anotherPoint [
	"Answer whether the receiver and anObject represent the same object."

	self == anotherPoint ifTrue: [ ^ true ].
	self class = anotherPoint class ifFalse: [ ^ false ].

	^ coordinates = anotherPoint coordinates
]

{ #category : #accessing }
GVector >> coordinates [
	^ coordinates
]

{ #category : #accessing }
GVector >> coordinates: anObject [
	coordinates := anObject
]

{ #category : #comparing }
GVector >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	| coordHash |
	coordHash := coordinates hash.
	^ coordHash squared + coordHash "Try to avoid collisions with GAbstractCoordinates and GPoint"
]
