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
GElement >> intersectionPointsWith: anElement [
	"We should use double dispatch to find intersection points"

	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionPointsWithLine: aGLine [
	"I should return the intersection points between me and a line"
	
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionPointsWithPolygon: aGPolygon [
	"I should return the intersection points between me and a polygon"
	
	^ self subclassResponsibility
]

{ #category : #intersections }
GElement >> intersectionPointsWithSegment: aGSegment [
	"I should return the intersection points between me and a segment"
	
	^ self subclassResponsibility
]

{ #category : #transforming }
GElement >> translateBy: aPoint [
	"Translate the shape by a delta defined by a point."
	
	self subclassResponsibility
]
