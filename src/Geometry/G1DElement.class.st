Class {
	#name : #G1DElement,
	#superclass : #GElement,
	#category : #'Geometry-Elements'
}

{ #category : #accessing }
G1DElement >> length [
	"Return the length of the element."

	^ self subclassResponsibility
]
