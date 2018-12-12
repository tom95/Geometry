Extension { #name : #Collection }

{ #category : #'*Geometry' }
Collection >> asGCoordinates [
	^ GCoordinates withCollection: self
]

{ #category : #'*Geometry' }
Collection >> asGPoint [
	^ GPoint withCollection: self
]

{ #category : #'*Geometry' }
Collection >> asGVector [
	^ GVector withCollection: self
]
