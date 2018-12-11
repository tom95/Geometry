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

{ #category : #accessing }
GShape >> center [
	"I should return a point that is at the center of the shape"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GShape >> encompassingRectangle [
	"I should return a rectangle on the minimum size that contains the shape"
	
	^ self subclassResponsibility
]

{ #category : #transforming }
GShape >> fitInExtent: anExtent [
	"I should transform my shape to fit in a rectangle of size 0@0 to the extent as parameter, keeping my center."
	
	self subclassResponsibility
]

{ #category : #testing }
GShape >> includesPoint: aPoint [
	"I should return true if the points is contained in the shape. Else I will answer false."

	^ self subclassResponsibility
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

{ #category : #transforming }
GShape >> translateBy: aPoint [
	"Translate the shape by a delta defined by a point."
	
	self subclassResponsibility
]
