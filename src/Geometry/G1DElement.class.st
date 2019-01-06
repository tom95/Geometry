"
Description
--------------------

I am the common superclass to all 1D elements. A 1D elements covers elements such as points, lines, segments, rays...
"
Class {
	#name : #G1DElement,
	#superclass : #GElement,
	#category : #'Geometry-Elements'
}

{ #category : #testing }
G1DElement class >> isAbstract [
	^ self = G1DElement
]

{ #category : #testing }
G1DElement >> boundaryContains: aPoint [
	^ self includes: aPoint
]

{ #category : #accessing }
G1DElement >> length [
	"Return the length of the element."

	^ self subclassResponsibility
]
