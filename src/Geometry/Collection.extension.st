Extension { #name : #Collection }

{ #category : #'*Geometry' }
Collection >> asGVector [
	^ GVector withCollection: self
]
