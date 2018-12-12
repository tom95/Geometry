Class {
	#name : #GCoordinates,
	#superclass : #Object,
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GCoordinates class >> newWithCoordinates: aCollection [
	^ self basicNew
		initializeWith: aCollection;
		yourself
]

{ #category : #accessing }
GCoordinates class >> numberOfDimensions [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GCoordinates class >> withCollection: aCollection [
	^ self allSubclasses
		detect: [ :e | e numberOfDimensions = aCollection size ]
		ifFound: [ :class | 
			class basicNew
				initializeWith: aCollection asArray;
				yourself ]
		ifNone: [ self error: 'This amount of coordinated is not yet managed.' ]
]

{ #category : #arithmetic }
GCoordinates >> * aNumber [
	"Answer a Point that is the multiplication of the receiver and arg."

	aNumber isNumber ifFalse: [ self error: 'Coordinates can only be multiplicated by a number.' ].

	^ self class newWithCoordinates: (self coordinatesCollect: [ :number | number * aNumber ])
]

{ #category : #arithmetic }
GCoordinates >> + otherCoordinates [ 
	"Answer a Point that is the sum of the receiver and arg."
	self numberOfDimensions = otherCoordinates numberOfDimensions ifFalse: [ self error: 'For now we accept only addition of coordinates from the same dimension. We will see later if we should do more.' ].

	^ self class newWithCoordinates: (otherCoordinates coordinatesWith: coordinates collect: [ :number1 :number2 | number1 + number2 ])
]

{ #category : #arithmetic }
GCoordinates >> - otherCoordinates [ 
	"Answer a Point that is the substraction of the receiver and arg."
	self numberOfDimensions = otherCoordinates numberOfDimensions ifFalse: [ self error: 'For now we accept only substraction of coordinates from the same dimension. We will see later if we should do more.' ].

	^ self class newWithCoordinates: (otherCoordinates coordinatesWith: coordinates collect: [ :number2 :number1 | number1 - number2 ])
]

{ #category : #arithmetic }
GCoordinates >> / aNumber [
	"Answer a Point that is the division of the receiver and arg."

	aNumber isNumber ifFalse: [ self error: 'Coordinates can only be divided by a number.' ].

	^ self class newWithCoordinates: (self coordinatesCollect: [ :number | number / aNumber ])
]

{ #category : #comparing }
GCoordinates >> = otherCoordinates [
	"Answer whether the receiver and anObject represent the same object."

	self == otherCoordinates ifTrue: [ ^ true ].
	self class = otherCoordinates class ifFalse: [ ^ false ].

	otherCoordinates coordinatesWith: coordinates do: [ :number2 :number1 | number1 = number2 ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #accessing }
GCoordinates >> coordinates [
	^ coordinates
]

{ #category : #enumerating }
GCoordinates >> coordinatesCollect: aBlock [
	^ coordinates collect: aBlock
]

{ #category : #enumerating }
GCoordinates >> coordinatesDo: aBlock [
	coordinates do: aBlock
]

{ #category : #enumerating }
GCoordinates >> coordinatesWith: aCollection collect: aBlock [
	^ coordinates with: aCollection collect: aBlock
]

{ #category : #enumerating }
GCoordinates >> coordinatesWith: aCollection do: aBlock [
	coordinates with: aCollection do: aBlock
]

{ #category : #comparing }
GCoordinates >> hash [
	"Answer an integer value that is related to the identity of the receiver."
	
	^ coordinates hash negated "We negate to not have a collision with Array"
]

{ #category : #initialization }
GCoordinates >> initialize [
	super initialize.
	coordinates := Array new: self numberOfDimensions
]

{ #category : #private }
GCoordinates >> initializeWith: anArray [
	anArray size = self numberOfDimensions
		ifFalse: [ self error: 'The provided array must have the same size than my number of dimensions which is ' , self numberOfDimensions size asString ].
	coordinates := anArray
]

{ #category : #accessing }
GCoordinates >> numberOfDimensions [
	^ self class numberOfDimensions
]

{ #category : #copying }
GCoordinates >> postCopy [
	super postCopy.
	coordinates := coordinates copy
]

{ #category : #printing }
GCoordinates >> printCoordinatesOn: aStream [
	aStream << $(.
	coordinates do: [ :number | aStream << number ] separatedBy: [ aStream << $, ].
	aStream << $)
]

{ #category : #printing }
GCoordinates >> printOn: aStream [
	super printOn: aStream.
	self printCoordinatesOn: aStream
]

{ #category : #accessing }
GCoordinates >> x [
	^ coordinates at: 1
]

{ #category : #accessing }
GCoordinates >> x: aNumber [
	coordinates at: 1 put: aNumber
]

{ #category : #accessing }
GCoordinates >> y [
	^ coordinates at: 2
]

{ #category : #accessing }
GCoordinates >> y: aNumber [
	coordinates at: 2 put: aNumber
]
