Extension { #name : #Number }

{ #category : #'*Geometry' }
Number >> , aNumber [
	^ GPoint x: self y: aNumber
]

{ #category : #'*Geometry' }
Number >> <=~ other [
	^ self < other or: [ self =~ other ]
]

{ #category : #'*Geometry' }
Number >> <~ other [
	^ (self >=~ other) not
]

{ #category : #'*Geometry' }
Number >> =~ aNumber [ 
	^((self - aNumber) abs) < Number epsilon.
]

{ #category : #'*Geometry' }
Number >> >=~ other [
	^ other <=~ self
]

{ #category : #'*Geometry' }
Number >> >~ other [
	^ other <~ self
]

{ #category : #'*geometry' }
Number class >> epsilon [
	^ 0.00001
]

{ #category : #'*Geometry' }
Number >> isBetween: a and: b with: eps [ 
	|mi ma|
	(a =~ self or:[ b =~ self or:[ a + (2 * eps) =~ self or:[ a - (2 * eps) =~ self or:[ b + (2 * eps) =~ self or:[ b - (2 * eps) =~ self ]]]]] )
		ifTrue:[ ^ true]
		ifFalse:[
			mi := a min: b. 
			ma := a max: b. 
	( self + (2 * eps) >=~ mi and:[ self + (2 * eps) <=~ ma ] )
	ifTrue:[ ^ true]
	ifFalse:[ 		
			^  self between: mi and: ma ]] "( ( self - mi ) abs >=~ eps ) and:[ ( ma - self ) abs >=~ eps ]"
]

{ #category : #'*Geometry' }
Number >> multiplyWithVector: aGVector [ 
	^ (aGVector coordinates * self) asGVector
]
