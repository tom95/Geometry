"
A GMatrixTest is a test class for testing the behavior of GMatrix
"
Class {
	#name : #GMatrixTest,
	#superclass : #GTestCase,
	#instVars : [
		'matrix'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GMatrixTest >> actualClass [
	^ GMatrix
]

{ #category : #test }
GMatrixTest >> testAt [
	matrix := GMatrix rows: #(#(3 5) #(2 9)).
	self assert: (matrix at: 1) equals: #(3 5).
	self assert: (matrix at: 2) equals: #(2 9)
]

{ #category : #test }
GMatrixTest >> testAtAt [
	matrix := GMatrix rows: #(#(3 5) #(2 9)).
	self assert: (matrix at: 1 at: 1) equals: 3.
	self assert: (matrix at: 1 at: 2) equals: 5.
	self assert: (matrix at: 2 at: 1) equals: 2.
	self assert: (matrix at: 2 at: 2) equals: 9
]

{ #category : #test }
GMatrixTest >> testDeterminant [
	matrix := GMatrix rows: #(#(3 5) #(2 9)).
	self assert: matrix determinant equals: 17
]

{ #category : #test }
GMatrixTest >> testEquals [
	matrix := GMatrix rows: #(#(3 5) #(2 9)).
	self assert: matrix equals: (GMatrix rows: #(#(3 5) #(2 9))).
	self assert: matrix hash equals: (GMatrix rows: #(#(3 5) #(2 9))) hash.
	self deny: matrix = (GMatrix rows: #(#(3 5) #(2 1))).
	self deny: matrix hash = (GMatrix rows: #(#(3 5) #(2 1))) hash
]
