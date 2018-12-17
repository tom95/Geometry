"
I am a collection of several shapes. Useful for finding an intersection of a more complex shape.
"
Class {
	#name : #GCollection,
	#superclass : #OrderedCollection,
	#category : #'Geometry-Core'
}

{ #category : #accessing }
GCollection >> center [
	^ self encompassingRectangle center
]

{ #category : #accessing }
GCollection >> encompassingRectangle [
	^ self
		ifEmpty: [ 0 @ 0 corner: 0 @ 0 ]
		ifNotEmpty: [ Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #accessing }
GCollection >> height [
	^ self encompassingRectangle height
]

{ #category : #comparing }
GCollection >> intersectionsWith: anElement [
	^ (self flatCollect: [ :each | anElement intersectionsWith: each ]) asArray
]

{ #category : #accessing }
GCollection >> width [
	^ self encompassingRectangle width
]
