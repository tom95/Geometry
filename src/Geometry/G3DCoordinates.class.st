"
Description
--------------------

I am a coordinates set for 3D spaces.

Examples
--------------------

	GCoordinates withCollection: #(1 3 2).

	G3DCoordinates coordinates: #(1 3 2).
	
	G2DCoordinates x: 1 y: 2 z: 3
"
Class {
	#name : #G3DCoordinates,
	#superclass : #GCoordinates,
	#category : #'Geometry-Core'
}

{ #category : #accessing }
G3DCoordinates class >> numberOfDimensions [
	^ 3
]

{ #category : #'instance creation' }
G3DCoordinates class >> x: aNumber y: anotherNumber z: thirdNumber [
	^ self new
		x: aNumber;
		y: anotherNumber;
		z: thirdNumber;
		yourself
]

{ #category : #accessing }
G3DCoordinates >> z [
	^ coordinates at: 3
]

{ #category : #accessing }
G3DCoordinates >> z: aNumber [
	^ coordinates at: 3 put: aNumber
]
