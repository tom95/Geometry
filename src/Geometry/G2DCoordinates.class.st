Class {
	#name : #G2DCoordinates,
	#superclass : #GCoordinates,
	#category : #'Geometry-Core'
}

{ #category : #accessing }
G2DCoordinates class >> numberOfDimensions [
	^ 2
]

{ #category : #'instance creation' }
G2DCoordinates class >> x: aNumber y: anotherNumber [
	^ self new
		x: aNumber;
		y: anotherNumber;
		yourself
]
