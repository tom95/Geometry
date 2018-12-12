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
Point >> geometryCorner: aPoint [
	^ GRectangle origin: self corner: aPoint
]

{ #category : #'*Geometry' }
Point >> geometryExtent: aPoint [
	"Answer a Rectangle whose origin is the receiver and whose extent is aPoint. This is one of the infix ways of expressing the creation of a rectangle."

	^ GRectangle origin: self extent: aPoint
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
