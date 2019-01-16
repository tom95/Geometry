Extension { #name : #Number }

{ #category : #'*Geometry' }
Number >> , aNumber [
	^ GPoint x: self y: aNumber
]

{ #category : #'*Geometry' }
Number >> =~ aNumber [ 
	^((self - aNumber) abs) < Number epsilon.
]

{ #category : #'*Geometry' }
Number >> angleIsInferiorTo: anAngle [
	"Return if an angle in radian is inferior to another angle.
	
	Here we manage the case one of the angle is negative"

	^ self asPositiveAngle between: 0 and: anAngle asPositiveAngle
]

{ #category : #'*Geometry' }
Number >> asPositiveAngle [
	^ self positive ifTrue: [ self ] ifFalse: [ 2 * Float pi + self ]
]

{ #category : #'*Geometry' }
Number >> degrees [
	^ GAngle degrees: self
]

{ #category : #'*Geometry' }
Number >> divideWithAngle: aGAngle [ 
	^ (aGAngle radians / self) radians
]

{ #category : #'*geometry' }
Number class >> epsilon [
	^ 0.00001
]

{ #category : #'*Geometry' }
Number >> multiplyWithAngle: aGAngle [ 
	^ (aGAngle radians * self) radians
]

{ #category : #'*Geometry' }
Number >> multiplyWithVector: aGVector [ 
	^ (aGVector coordinates * self) asGVector
]

{ #category : #'*Geometry' }
Number >> radians [
	^ GAngle radians: self
]
