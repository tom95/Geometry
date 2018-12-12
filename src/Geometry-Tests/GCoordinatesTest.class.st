Class {
	#name : #GCoordinatesTest,
	#superclass : #TestCase,
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GCoordinatesTest >> test2DCoordinates [
	coordinates := G2DCoordinates x: 1 y: 2.
	self assert: coordinates x equals: 1.
	self assert: coordinates y equals: 2.
	
	coordinates := G2DCoordinates x: -1 y: -2.
	self assert: coordinates x equals: -1.
	self assert: coordinates y equals: -2
]

{ #category : #tests }
GCoordinatesTest >> testAddition [
	| coordinates2 coordinates3 |
	coordinates := G2DCoordinates x: 1 y: 2.
	coordinates2 := G2DCoordinates x: 4 y: 8.
	coordinates3 := coordinates + coordinates2.
	self assert: coordinates3 x equals: 5.
	self assert: coordinates3 y equals: 10
]

{ #category : #tests }
GCoordinatesTest >> testDivision [
	| coordinates2 |
	coordinates := G2DCoordinates x: 2 y: 8.
	coordinates2 := coordinates / 2.
	self assert: coordinates2 x equals: 1.
	self assert: coordinates2 y equals: 4
]

{ #category : #tests }
GCoordinatesTest >> testEquals [
	self assert: (G2DCoordinates x: 1 y: 2) equals: (G2DCoordinates x: 1 y: 2).
	self deny: (G2DCoordinates x: 2 y: 4) equals: (G2DCoordinates x: 1 y: 2).
	self assert: (G2DCoordinates x: 1 y: 2) hash equals: (G2DCoordinates x: 1 y: 2) hash.
	self deny: (G2DCoordinates x: 2 y: 4) hash equals: (G2DCoordinates x: 1 y: 2) hash
]

{ #category : #tests }
GCoordinatesTest >> testMultiplication [
	| coordinates2 |
	coordinates := G2DCoordinates x: 2 y: 8.
	coordinates2 := coordinates * 2.
	self assert: coordinates2 x equals: 4.
	self assert: coordinates2 y equals: 16
]

{ #category : #tests }
GCoordinatesTest >> testSubstraction [
	| coordinates2 coordinates3 |
	coordinates := G2DCoordinates x: 1 y: 2.
	coordinates2 := G2DCoordinates x: 4 y: 8.
	coordinates3 := coordinates - coordinates2.
	self assert: coordinates3 x equals: -3.
	self assert: coordinates3 y equals: -6
]