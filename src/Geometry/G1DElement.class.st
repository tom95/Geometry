Class {
	#name : #G1DElement,
	#superclass : #GElement,
	#category : #'Geometry-Elements'
}

{ #category : #testing }
G1DElement >> boundaryContains: aPoint [
	^ self includes: aPoint
]

{ #category : #accessing }
G1DElement >> length [
	"Return the length of the element."

	^ self subclassResponsibility
]
