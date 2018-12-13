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

{ #category : #transforming }
GElement >> translateBy: aPoint [
	"Translate the shape by a delta defined by a point."
	
	self subclassResponsibility
]
