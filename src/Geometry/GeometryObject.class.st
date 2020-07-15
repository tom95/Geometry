"
Description
--------------------

I am a common superclass for all Geometry object. Concrete (points, segments, polygons...) and abstract objects (coordinates, vectors, ...).
"
Class {
	#name : #GeometryObject,
	#superclass : #Object,
	#category : #'Geometry-Elements'
}

{ #category : #'error handling' }
GeometryObject class >> error [
	GeometryError signal
]

{ #category : #'error handling' }
GeometryObject class >> error: aString [
	GeometryError signal: aString
]

{ #category : #'error handling' }
GeometryObject >> error [
	^ self class error
]

{ #category : #'error handling' }
GeometryObject >> error: aString [
	^ self class error: aString
]
