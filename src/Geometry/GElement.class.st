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

{ #category : #'error handling' }
GElement class >> error [
	GError signal
]

{ #category : #'error handling' }
GElement class >> error: aString [
	GError signal: aString
]

{ #category : #testing }
GElement class >> isAbstract [
	^ self = GElement
]

{ #category : #'error handling' }
GElement >> error [
	^ self class error
]

{ #category : #'error handling' }
GElement >> error: aString [
	^ self class error: aString
]
