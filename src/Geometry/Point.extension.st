Extension { #name : #Point }

{ #category : #'*Geometry' }
Point >> asGPoint [
	^ x , y
]

{ #category : #'*Geometry' }
Point >> asGVector [
	^ GVector coordinates: (G2DCoordinates x: x y: y)
]
