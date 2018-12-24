Extension { #name : #Number }

{ #category : #'*Geometry' }
Number >> , aNumber [
	^ GPoint x: self y: aNumber
]

{ #category : #'*Geometry' }
Number >> =~ aNumber [ 
	^((self - aNumber) abs) < Number epsilon.
]

{ #category : #'*geometry' }
Number class >> epsilon [
	^ 0.00001
]

{ #category : #'*Geometry' }
Number >> multiplyWithVector: aGVector [ 
	^ (aGVector coordinates * self) asGVector
]
