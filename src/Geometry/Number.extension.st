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

{ #category : #'*Geometry' }
Number >> pi [
	^ self * Float pi
]
