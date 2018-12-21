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
GElement >> includesPoint: aPoint [
	"I should return true if the points is contained in the shape. Else I will answer false."

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
	^ (self includesPoint: aPoint) ifTrue: [ { aPoint } ] ifFalse: [ {  } ]
]

{ #category : #intersections }
GElement >> intersectionsWithPolygon: aGPolygon [
	"I should return the intersection points between me and a polygon"
	
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWithRay: aGRay [
	"I should return the intersection points between me and a ray"

	self flag: #todo. "I think we can have a generic solution by getting the intersections with the line going through the two points of the element then selectiong tne points that are on the element."
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionsWithSegment: aGSegment [
	"I should return the intersection points between me and a segment"
	
	self flag: #todo. "I think we can have a generic solution by getting the intersections with the line going through the two points of the element then selectiong tne points that are on the element."
	^ self subclassResponsibility
]

{ #category : #transforming }
GElement >> translateBy: aPoint [
	"Translate the shape by a delta defined by a point."
	
	self subclassResponsibility
]
