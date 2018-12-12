Class {
	#name : #GVectorTest,
	#superclass : #TestCase,
	#instVars : [
		'vector'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GVectorTest >> test2DVector [
	vector := GVector x: 1 y: 2.
	self assert: vector x equals: 1.
	self assert: vector y equals: 2.
	
	vector := GVector x: -1 y: -2.
	self assert: vector x equals: -1.
	self assert: vector y equals: -2.
	
	vector := GVector coordinates: (G2DCoordinates x: 1 y: 2).
	self assert: vector x equals: 1.
	self assert: vector y equals: 2
]

{ #category : #tests }
GVectorTest >> testEquals [
	self assert: (GVector x: 1 y: 2) equals: (GVector x: 1 y: 2).
	self deny: (GVector x: 2 y: 4) equals: (GVector x: 1 y: 2).
	self assert: (GVector x: 1 y: 2) hash equals: (GVector x: 1 y: 2) hash.
	self deny: (GVector x: 2 y: 4) hash equals: (GVector x: 1 y: 2) hash
]

{ #category : #tests }
GVectorTest >> testLength [
	vector := GVector x: 3 y: -4.
	self assert: vector length equals: 5
]
