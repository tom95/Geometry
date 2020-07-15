"
Description
--------------------

I am a common super class for all geometric elements. I define the common API all elements should be able to answer to.


Public API and Key Messages
--------------------

- #includes: 	This methods takes a point as parameter and answer true of the element includes the point. (Boundaries included) Note: In the future I should be able to take more elements than the point as parameter using double dispatch as #intersectionsWith:.
- #contains: 	This methods takes a point as parameter and answer true of the element includes the point. (Boundaries excluded) Note: In the future I should be able to take more elements than the point as parameter using double dispatch as #intersectionsWith:.
- #boundaryContains: 		This methods takes a point as parameter and answer true of the boundaries of the element includes the point.
- #intersectionsWith: 	Takes as parameter any GElement and returns a collection of intersections points with this element.
- #translateBy: 			Takes a vector as parameter and translate the element by this vector.

"
Class {
	#name : #GElement,
	#superclass : #GeometryObject,
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

	self flag: #todo. "Maybe later we could use double dispatch to be able to do something like `aPolygon contains: aCricle` like with intersections"
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
GElement >> intersectionsWithArc: anArc [
	^ (self intersectionsWithEllipse: (GCircle center: anArc center radius: anArc radius)) select: [ :point | anArc includes: point ]
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
	^ (self boundaryContains: aPoint) ifTrue: [ {aPoint} ] ifFalse: [ {} ]
]

{ #category : #intersections }
GElement >> intersectionsWithPolygon: aGPolygon [
	^ (aGPolygon edges flatCollect: [ :segment | segment intersectionsWith: self ]) asSet
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
