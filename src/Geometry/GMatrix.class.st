"
Description
--------------------

I am a simple implementation of matrix for operations needing matrix in geometry computations.

I will not implement all matrix operations, only the one needed for the features of geometry elements.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	rows:		<aCollection> 	A collection of collection containing the rows of the matrix.

"
Class {
	#name : #GMatrix,
	#superclass : #GeometryObject,
	#instVars : [
		'rows'
	],
	#category : #'Geometry-Core'
}

{ #category : #'instance creation' }
GMatrix class >> rows: aCollection [
	^ self new
		rows: aCollection;
		yourself
]

{ #category : #comparing }
GMatrix >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ rows = anObject rows
]

{ #category : #accessing }
GMatrix >> at: anInteger [
	^ self rows at: anInteger
]

{ #category : #accessing }
GMatrix >> at: anInteger at: anInteger2 [ 
	^ (self at: anInteger) at: anInteger2
]

{ #category : #arithmetic }
GMatrix >> determinant [
	self flag: #todo.	"For now this implementation is only for 2D squared matrix. We should later manage n-dimensions matrix"
	^ (self at: 1 at: 1) * (self at: 2 at: 2) - ((self at: 1 at: 2) * (self at: 2 at: 1))
]

{ #category : #comparing }
GMatrix >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ rows hash negated
]

{ #category : #accessing }
GMatrix >> rows [
	^ rows
]

{ #category : #accessing }
GMatrix >> rows: anObject [
	rows := anObject
]
