Extension { #name : #Point }

{ #category : #'*Geometry' }
Point >> =~ aPoint [
	^ (self dist: aPoint) =~ 0

]

{ #category : #'*Geometry' }
Point >> asGPoint [
	^ x , y
]

{ #category : #'*Geometry' }
Point >> asGVector [
	^ GVector coordinates: (G2DCoordinates x: x y: y)
]

{ #category : #'*Geometry' }
Point >> has: aPoint onTheSameSideAs: p [
	(self x <= p x) 
		ifTrue:[ self y <= p y
			ifTrue:[ ^ (self x <= aPoint x) and:[ self y <= aPoint y ] ]
			ifFalse:[ ^ (self x <= aPoint x) and:[ self y > aPoint y ] ] ]
		ifFalse:[ self y <= p y
			ifTrue:[ ^ (self x > aPoint x) and:[ self y <= aPoint y ] ]
			ifFalse:[ ^ (self x > aPoint x) and:[ self y > aPoint y ] ] ]
	 
]

{ #category : #'*Geometry' }
Point >> ray: aPoint [ 
	^ GRay origin: self direction: aPoint 
]

{ #category : #'*Geometry' }
Point >> segment: aPoint [ 
	^ GSegment with: self with: aPoint 
]

{ #category : #'*Geometry' }
Point >> signFuz [
	^ (x signFuz @ y signFuz)
]

{ #category : #'*Geometry' }
Point >> ~=~ aPoint [
	^ (self =~ aPoint) not
]
