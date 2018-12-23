"
I am a segment between two vertices
"
Class {
	#name : #GSegment,
	#superclass : #GElement,
	#instVars : [
		'v1',
		'v2'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'as yet unclassified' }
GSegment class >> with: aPoint1 with: aPoint2 [
	^ self new
		initializeWith: aPoint1 with: aPoint2;
		yourself
]

{ #category : #comparing }
GSegment >> = aSegment [
	self == aSegment ifTrue: [ ^ true ].
	self class = aSegment class ifFalse: [ ^ false ].
	
	^ (v1 =~ aSegment v1 and: [ v2 =~ aSegment v2 ])
		or: [ v1 =~ aSegment v2 and: [ v2 =~ aSegment v1 ] ]
]

{ #category : #properties }
GSegment >> asLine [
	^ GLine through: v1 and: v2
]

{ #category : #properties }
GSegment >> distanceTo: aGPoint [
	self flag: #todo.	"«The distance between segments and rays may not be the same as the distance between their extended lines. » http://geomalgorithms.com/a07-_distance.html
	
	So apparently this implementation is wrong."
	^ self asLine distanceTo: aGPoint
]

{ #category : #initialization }
GSegment >> hash [
	^ v1 hash bitXor: v2 hash
]

{ #category : #properties }
GSegment >> includesPoint: aGPoint [
	"The point is on the segment if the sum of the distance from v1 to aGPoint and the distance of a GPoint to v2 is my length"

	^ (v2 distanceTo: aGPoint) + (aGPoint distanceTo: v1) =~ self length
]

{ #category : #initialization }
GSegment >> initializeWith: aPoint1 with: aPoint2 [
	v1 := aPoint1 asGPoint.
	v2 := aPoint2 asGPoint
]

{ #category : #intersections }
GSegment >> intersectionsWith: anElement [
	^ anElement intersectionsWithSegment: self
]

{ #category : #intersections }
GSegment >> intersectionsWithEllipse: aGEllipse [ 
	^ (self asLine intersectionsWithEllipse: aGEllipse) select: [ :each | self includesPoint: each ]
]

{ #category : #intersections }
GSegment >> intersectionsWithLine: aLine [
	^ (self asLine intersectionsWithLine: aLine) select: [ :point | self includesPoint: point ]
]

{ #category : #intersections }
GSegment >> intersectionsWithRay: ray [
	^ (self asLine intersectionsWithLine: ray asLine) select: [ :point | (self includesPoint: point) and: [ ray includesPoint: point ] ]
]

{ #category : #intersections }
GSegment >> intersectionsWithSegment: segm [
	^ (self asLine intersectionsWithLine: segm asLine) select: [ :point | (self includesPoint: point) and: [ segm includesPoint: point ] ]
]

{ #category : #properties }
GSegment >> length [
	"The distance between two points is the length of the vector transposing v1 into v2"

	^ (v2 - v1) length
]

{ #category : #properties }
GSegment >> midPoint [
	^ ((v1 coordinates + v2 coordinates) / 2) asGPoint
]

{ #category : #properties }
GSegment >> perpendicularBisector [
	self flag: #todo.	"This is only for 2D. We should rely on GPoints to be able to do it for n-dimensions."

	^ GLine a: v2 x - v1 x b: v2 y - v1 y c: (v1 x * v1 x - (v2 x * v2 x) + (v1 y * v1 y) - (v2 y * v2 y)) / 2
]

{ #category : #printing }
GSegment >> printOn: aStream [
	v1 printOn: aStream.
	aStream nextPutAll: '>-<'.
	v2 printOn: aStream
]

{ #category : #accessing }
GSegment >> v1 [
	^ v1
]

{ #category : #accessing }
GSegment >> v1: aGPoint [
	v1 := aGPoint
]

{ #category : #accessing }
GSegment >> v2 [
	^ v2
]

{ #category : #accessing }
GSegment >> v2: aGPoint [
	v2 := aGPoint
]

{ #category : #initialization }
GSegment >> vertices [
	^ { v1 . v2 }
]
