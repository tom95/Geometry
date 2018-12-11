"
Description
--------------------

I am a common super class for all geometric elements
"
Class {
	#name : #GElement,
	#superclass : #Object,
	#category : #'Geometry-Elements'
}

{ #category : #testing }
GElement class >> isAbstract [
	^ self = GElement
]

{ #category : #'error handling' }
GElement >> error [
	GError signal
]

{ #category : #'error handling' }
GElement >> error: aString [
	GError signal: aString
]

{ #category : #printing }
GElement >> printOn: aStream [
	super printOn: aStream.
	aStream << $[ << self hash << $]
]
