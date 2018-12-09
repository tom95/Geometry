"
I am a rectangle. See my parent for API
"
Class {
	#name : #GRectangle,
	#superclass : #Rectangle,
	#category : 'Geometry'
}

{ #category : #'as yet unclassified' }
GRectangle >> encompassingRectangle [
	^ self
]

{ #category : #comparing }
GRectangle >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectRectangle: self
]
