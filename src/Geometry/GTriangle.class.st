"
I am a triangle
"
Class {
	#name : #GTriangle,
	#superclass : #GPolygon,
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GTriangle class >> vertices: aCollection [	
	aCollection size = 3 ifFalse: [ self error: 'A triangle should have 3 vertices.' ].

	^ super vertices: aCollection
]

{ #category : #'instance creation' }
GTriangle class >> with: aPoint1 with: aPoint2 with: aPoint3 [
	^ self vertices: { aPoint1. aPoint2. aPoint3 }
]

{ #category : #properties }
GTriangle >> area [
	| semiperimeter|
	semiperimeter := self semiperimeter.

	^ (self edges 
		inject: semiperimeter
		into: [ :subProduct :edge |
			(semiperimeter - edge length) * subProduct ]) sqrt
]

{ #category : #figures }
GTriangle >> circumscribedCircle [
	^ (self edges first perpendicularBisector intersectionsWith: self edges last perpendicularBisector)
		ifNotEmpty: [ :points | GCircle center: points anyOne radius: (self v1 distanceTo: self v2) * (self v2 distanceTo: self v3) * (self v3 distanceTo: self v1) / (4 * self area) ]
]

{ #category : #figures }
GTriangle >> isDegenerate [
	^ (self v1 = self v2 or: [ self v1 = self v3 or: [ self v2 = self v3 ] ])
		ifTrue: [ true ]
		ifFalse: [ self edges first length + self edges second length = self edges third length
				or: [ self edges second length + self edges third length = self edges first length or: [ self edges third length + self edges first length = self edges second length ] ] ]
]

{ #category : #accessing }
GTriangle >> v1 [
	^ vertices at: 1
]

{ #category : #accessing }
GTriangle >> v2 [
	^ vertices at: 2
]

{ #category : #accessing }
GTriangle >> v3 [
	^ vertices at: 3
]
