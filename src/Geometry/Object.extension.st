Extension { #name : #Object }

{ #category : #'*Geometry' }
Object >> <=~ other [
	^ self < other or: [ self =~ other ]
]

{ #category : #'*Geometry' }
Object >> <~ other [
	^ (self >=~ other) not
]

{ #category : #'*Geometry' }
Object >> >=~ other [
	^ other <=~ self
]

{ #category : #'*Geometry' }
Object >> >~ other [
	^ other <~ self
]
