"
Description
--------------------

I am a common superclass for all shapes elements.

I define the minimal API each elements should be able to answer to.
"
Class {
	#name : #GShape,
	#superclass : #GElement,
	#category : #'Geometry-Shapes'
}

{ #category : #testing }
GShape class >> isAbstract [
	^ self = GShape
]

{ #category : #accessing }
GShape >> area [
	"Return the area of the shape"
	
	^ self subclassResponsibility
]

{ #category : #testing }
GShape >> boundaryContains: aPoint [
	"Should return true if the border of the shape contains the point. Else it should return false."

	^ self subclassResponsibility
]

{ #category : #testing }
GShape >> boundaryContainsAny: points [
	^ points anySatisfy: [ :point | self boundaryContains: point ]
]

{ #category : #testing }
GShape >> boundaryContainsWhichOf: points [
	^ points select: [ :point | self boundaryContains: point ]
]

{ #category : #accessing }
GShape >> center [
	^ self encompassingRectangle center
]

{ #category : #testing }
GShape >> contains: aPoint [
	^ (self includesPoint: aPoint) and: [ (self boundaryContains: aPoint) not ]
]

{ #category : #accessing }
GShape >> encompassingRectangle [
	"I should return a rectangle on the minimum size that contains the shape"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GShape >> extent [
	"I return a vector representing the extent of the encompassing rectangle of the shape. I should be able to translate the corner of the encompassing rectangle to its origin."
	
	^ self encompassingRectangle extent
]

{ #category : #transforming }
GShape >> fitInExtent: anExtent [
	"I should transform my shape to fit in a rectangle of size 0@0 to the extent as parameter, keeping my center.
	Note that I should keep proportions. We could maybe implement another method to not keep proportions."
	
	self subclassResponsibility
]

{ #category : #intersections }
GShape >> intersectionsWithPoint: aPoint [
	^ (self boundaryContains: aPoint) ifTrue: [ { aPoint } ] ifFalse: [ {  } ]
]

{ #category : #accessing }
GShape >> perimeter [
	"Return the perimeter of the shape"
	
	^ self subclassResponsibility
]

{ #category : #transforming }
GShape >> scaleBy: aPoint [
	"Scale the shape by a delta defined by a point."
	
	self subclassResponsibility
]

{ #category : #properties }
GShape >> semiperimeter [
	^ self perimeter / 2
]
