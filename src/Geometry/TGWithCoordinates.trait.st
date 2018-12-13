Trait {
	#name : #TGWithCoordinates,
	#category : #'Geometry-Core'
}

{ #category : #accessing }
TGWithCoordinates >> coordinates [
	^ self explicitRequirement
]

{ #category : #accessing }
TGWithCoordinates >> coordinates: gCoordinates [
	^ self explicitRequirement
]

{ #category : #enumerating }
TGWithCoordinates >> coordinatesWith: aCollection collect: aBlock [
	^ self coordinates coordinatesWith: aCollection coordinates collect: aBlock
]

{ #category : #enumerating }
TGWithCoordinates >> coordinatesWith: aCollection do: aBlock [
	self coordinates coordinatesWith: aCollection coordinates do: aBlock
]

{ #category : #copying }
TGWithCoordinates >> postCopy [
	super postCopy.
	self coordinates: self coordinates copy
]

{ #category : #printing }
TGWithCoordinates >> printOn: aStream [
	super printOn: aStream.
	self coordinates printCoordinatesOn: aStream
]

{ #category : #accessing }
TGWithCoordinates >> x [
	^ self coordinates x
]

{ #category : #accessing }
TGWithCoordinates >> x: aNumber [ 
	self coordinates x: aNumber
]

{ #category : #accessing }
TGWithCoordinates >> y [
	^ self coordinates y
]

{ #category : #accessing }
TGWithCoordinates >> y: aNumber [ 
	self coordinates y: aNumber
]
