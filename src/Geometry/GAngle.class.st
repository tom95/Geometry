"
Description
--------------------

I represent a geometric angle. 

For now I can manage angle in radians or degrees.

If the angle is not in [0;2π[ , I'll take care to convert it in order to store the angle as a radian value in [0;2π[.

Examples
--------------------

	90 degrees. ""90.0°""

	(0.5 * Float pi)  radians. ""90.0°""
	
	0.5π radians. ""90.0°""	
	
	450 degrees. ""90.0°""
	
	0.5π radians + 0.5π radians. ""180.0°""
	
	0.5π radians - 0.25π radians. ""45.0°""
	
	0.5π radians * 6. ""180.0°""
	
	6 * 0.5π radians. ""180.0°""
	
	90 degrees < 100 degrees. ""true""
	
	90 degrees < -270 degrees. ""false""
	
	90 degrees < 460 degrees. ""false""
	
	0 radians isZero. ""true""
	
	90 degrees explementary. ""270.0°""
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	radians:		<aNumber>		The angle in radians in bounds [0;2π[

"
Class {
	#name : #GAngle,
	#superclass : #GeometryObject,
	#instVars : [
		'radians'
	],
	#classVars : [
		'RightAngle',
		'StraightAngle',
		'TwoPi',
		'ZeroAngle'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GAngle class >> degrees: anInteger [ 
	^ self radians: anInteger degreesToRadians
]

{ #category : #'class initialization' }
GAngle class >> initialize [
	TwoPi := 2π.
	ZeroAngle := 0 radians.
	RightAngle := 0.5π radians.
	StraightAngle := 1π radians
]

{ #category : #'instance creation' }
GAngle class >> radians: aNumber [
	^ self new
		initializeWith: aNumber;
		yourself
]

{ #category : #arithmetic }
GAngle >> * anInteger [ 
	^ anInteger multiplyWithAngle: self
]

{ #category : #arithmetic }
GAngle >> + aGAngle [ 
	^ aGAngle addWithAngle: self
]

{ #category : #arithmetic }
GAngle >> - aGAngle [ 
	^ aGAngle substractWithAngle: self
]

{ #category : #arithmetic }
GAngle >> / anInteger [ 
	^ anInteger divideWithAngle: self
]

{ #category : #comparison }
GAngle >> < aGAngle [ 
	^ self radians < aGAngle radians
]

{ #category : #comparison }
GAngle >> <= aGAngle [ 
	^ (self > aGAngle) not
]

{ #category : #comparing }
GAngle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ (radians - anObject radians) =~ 0 or: [ (radians - anObject radians) =~ TwoPi ]
]

{ #category : #comparison }
GAngle >> > aGAngle [ 
	^ aGAngle < self
]

{ #category : #comparison }
GAngle >> >= aGAngle [ 
	^ aGAngle <= self
]

{ #category : #arithmetic }
GAngle >> adaptToNumber: anInteger andSend: aString [ 
	(#(#/ #+) anySatisfy: [ :forgivenSelector | aString = forgivenSelector ]) ifTrue: [ self error: 'Cannot execute ' , aString , ' on an Integer with an angle' ]. "I think we can do better than an if here but no time."
	^ self perform: aString with: anInteger
]

{ #category : #arithmetic }
GAngle >> addWithAngle: aGAngle [ 
	^ (self radians + aGAngle radians) radians
]

{ #category : #arithmetic }
GAngle >> cos [
	^ self radians cos
]

{ #category : #converting }
GAngle >> degreeNumber [
	^ self radians radiansToDegrees
]

{ #category : #accessing }
GAngle >> explementary [
	^ (0 - self radians) radians
]

{ #category : #comparing }
GAngle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ radians hash
]

{ #category : #initialization }
GAngle >> initializeWith: aNumber [ 
	radians := aNumber.
	radians := radians \\ TwoPi.
	radians negative ifTrue: [ radians := radians + TwoPi ]
]

{ #category : #testing }
GAngle >> isAcute [
	^ self > 0 radians and: [ self < RightAngle ]
]

{ #category : #testing }
GAngle >> isObtuse [
	^ self > RightAngle and: [ self < StraightAngle ]
]

{ #category : #testing }
GAngle >> isReflex [
	^ self > StraightAngle and: [ self radians < TwoPi ]
]

{ #category : #testing }
GAngle >> isRight [
	^ self = RightAngle
]

{ #category : #testing }
GAngle >> isStraight [
	^ self = StraightAngle
]

{ #category : #testing }
GAngle >> isZero [
	^ self = ZeroAngle
]

{ #category : #arithmetic }
GAngle >> multiplyWithAngle: aGAngle [ 
	self error: 'Not possible to multiply an angle by another angle'
]

{ #category : #printing }
GAngle >> printOn: aStream [
	aStream
		nextPutAll: (self degreeNumber asString truncateTo: 10);
		nextPutAll: '°'
]

{ #category : #converting }
GAngle >> radianNumber [
	^ self radians
]

{ #category : #accessing }
GAngle >> radians [
	^ radians
]

{ #category : #arithmetic }
GAngle >> sin [
	^ self radians sin
]

{ #category : #arithmetic }
GAngle >> substractWithAngle: aGAngle [ 
	^ (aGAngle radians - self radians) radians
]

{ #category : #arithmetic }
GAngle >> tan [
	^ self radians tan
]
