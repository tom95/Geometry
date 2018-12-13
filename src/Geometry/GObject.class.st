"
Description
--------------------

I am a common superclass for all Geometry object. Concrete (points, segments, polygons...) and abstract objects (coordinates, vectors, ...).
"
Class {
	#name : #GObject,
	#superclass : #Object,
	#category : #'Geometry-Elements'
}

{ #category : #'error handling' }
GObject class >> error [
	GError signal
]

{ #category : #'error handling' }
GObject class >> error: aString [
	GError signal: aString
]

{ #category : #'error handling' }
GObject >> error [
	^ self class error
]

{ #category : #'error handling' }
GObject >> error: aString [
	^ self class error: aString
]
