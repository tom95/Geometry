"
Description
--------------------

I represent a set of coordinates that will be used by other geometric elements.

My subclass will represent sets of a certain amount of coordinates. In the long terme we would like to remove all the subclasses and that everything manage myself as a n-dimensions coordinates set, but for now we prefer to begin with simple sets like 2D or 3D.

I implement basic arithmetic that can be done with coordinates.

Examples
--------------------
	
	""Instance creation""
	GCoordinates withCollection: #(1 3). 	""(1,3)""
	
	#(1 3) asGCoordinates.	""(1,3)""
	
	""Arithmetic""		
	(GCoordinates withCollection: #(1 3)) + (GCoordinates withCollection: #(5 1)). 	""(6,4)""
		
	(GCoordinates withCollection: #(1 3)) - (GCoordinates withCollection: #(5 1)). 	""(-4,2)""
		
	(GCoordinates withCollection: #(1 3)) * 2. 	""(2,6)""
		
	(GCoordinates withCollection: #(1 3)) / 2. 	""((1/2),(3/2))""
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	coordinates:		<aCollection> 	A collection of all the coordinates I contains.

"
Class {
	#name : #GCoordinates,
	#superclass : #GeometryObject,
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

{ #category : #converting }
GCoordinates >> asGPoint [
	^ GPoint coordinates: self
]

{ #category : #converting }
GCoordinates >> asGVector [
	^ GVector coordinates: self
]

{ #category : #accessing }
GCoordinates >> at: anInteger [
	^ self coordinates at: anInteger
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
GCoordinates >> coordinatesWith: aCollection collect: aBlock [
	^ coordinates with: aCollection collect: aBlock
]

{ #category : #enumerating }
GCoordinates >> coordinatesWith: aCollection do: aBlock [
	coordinates with: aCollection do: aBlock
]

{ #category : #enumerating }
GCoordinates >> fold: aBlock [
	^ self coordinates fold: aBlock
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
	anArray size = self numberOfDimensions ifFalse: [ self error: 'The provided array must have the same size than my number of dimensions which is ' , self numberOfDimensions size asString ].

	coordinates := anArray
]

{ #category : #enumerating }
GCoordinates >> inject: aSeed into: aBlock [
	^ self coordinates inject: aSeed into: aBlock
]

{ #category : #accessing }
GCoordinates >> lowerLimitsWith: otherCoordinates [
	^ self class newWithCoordinates: (self coordinatesWith: otherCoordinates coordinates collect: [ :number1 :number2 | number1 min: number2 ])
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
	coordinates do: [ :number | aStream << number asString ] separatedBy: [ aStream << $, ].
	aStream << $)
]

{ #category : #printing }
GCoordinates >> printOn: aStream [
	self printCoordinatesOn: aStream
]

{ #category : #accessing }
GCoordinates >> upperLimitsWith: otherCoordinates [
	^ self class newWithCoordinates: (self coordinatesWith: otherCoordinates coordinates collect: [ :number1 :number2 | number1 max: number2 ])
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
	"Might return an error for 1D coordinates, but do they make sense?"

	^ coordinates at: 2
]

{ #category : #accessing }
GCoordinates >> y: aNumber [
	"Might return an error for 1D coordinates, but do they make sense?"

	coordinates at: 2 put: aNumber
]
