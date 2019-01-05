"
Description
--------------------

I am a coordinates set for plans. (2D space).

Examples
--------------------

	GCoordinates withCollection: #(1 3).

	G2DCoordinates coordinates: #(1 3).
	
	G2DCoordinates x: 1 y: 2
"
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
