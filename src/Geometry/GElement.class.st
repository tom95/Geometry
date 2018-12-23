"
Description
--------------------

I am a common super class for all geometric elements
"
Class {
	#name : #GElement,
	#superclass : #GObject,
	#category : #'Geometry-Elements'
}

{ #category : #testing }
GElement class >> isAbstract [
	^ self = GElement
]

{ #category : #testing }
GElement >> boundaryContains: aPoint [
	"Should return true if the boundaries of the element contains the point. Else it should return false.
	
	For 1D elements it is equivalent to #includes:"

	^ self subclassResponsibility
]

{ #category : #testing }
GElement >> boundaryContainsAny: points [
	^ points anySatisfy: [ :point | self boundaryContains: point ]
]

{ #category : #testing }
GElement >> boundaryContainsWhichOf: points [
	^ points select: [ :point | self boundaryContains: point ]
]

{ #category : #testing }
GElement >> contains: aPoint [
	"Return true if the element includes the argument but not in its boundaries.
	
	Will always be false for 1D elements."

	^ (self includes: aPoint) and: [ (self boundaryContains: aPoint) not ]
]

{ #category : #testing }
GElement >> includes: aPoint [
	"I should return true if the points is contained in the element including the boundaries. Else I will answer false."

	self flag: #todo. "Maybe later we could use double dispatch to be able to do something like `aPolygon includes: aCricle` like with intersections"
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWith: anElement [
	"We should use double dispatch to find intersection points"

	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWithEllipse: aGEllipse [
	"I should return the intersection points between me and an ellipse"
	
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWithLine: aGLine [
	"I should return the intersection points between me and a line"
	
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWithPoint: aPoint [
	^ (self includes: aPoint) ifTrue: [ { aPoint } ] ifFalse: [ {  } ]
]

{ #category : #intersections }
GElement >> intersectionsWithPolygon: aGPolygon [
	self flag: #todo. "I do not like the asSet asArray. We should see to improve that later to have better perfs."
	^ (aGPolygon edges flatCollect: [ :segment | segment intersectionsWith: self]) asSet asArray
]

{ #category : #intersections }
GElement >> intersectionsWithRay: aGRay [
	^ (aGRay asGLine intersectionsWith: self) select: [ :point | aGRay includes: point ]
]

{ #category : #intersections }
GElement >> intersectionsWithSegment: aGSegment [
	^ (aGSegment asGLine intersectionsWith: self) select: [ :point | aGSegment includes: point ]
]

{ #category : #transforming }
GElement >> translateBy: aPoint [
	"Translate the shape by a delta defined by a point."
	
	self subclassResponsibility
]
