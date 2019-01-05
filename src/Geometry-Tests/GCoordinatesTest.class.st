Class {
	#name : #GCoordinatesTest,
	#superclass : #GTestCase,
	#instVars : [
		'coordinates'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GCoordinatesTest >> actualClass [
	^ GCoordinates
]

{ #category : #accessing }
GCoordinatesTest >> newInstance [
	^ self actualClass withCollection: #(1 2)
]

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
	self flag: #pharo6. "Use #deny:equals: when Pharo 7 will be the minimum requirement"
	self assert: (G2DCoordinates x: 1 y: 2) equals: (G2DCoordinates x: 1 y: 2).
	self deny: (G2DCoordinates x: 2 y: 4) = (G2DCoordinates x: 1 y: 2).
	self assert: (G2DCoordinates x: 1 y: 2) hash equals: (G2DCoordinates x: 1 y: 2) hash.
	self deny: (G2DCoordinates x: 2 y: 4) hash = (G2DCoordinates x: 1 y: 2) hash
]

{ #category : #tests }
GCoordinatesTest >> testLowerLimitsWith [
	| coordinates2 coordinates3 |
	coordinates := G2DCoordinates x: 1 y: 8.
	coordinates2 := G2DCoordinates x: 4 y: 6.
	coordinates3 := coordinates lowerLimitsWith: coordinates2.
	self assert: coordinates3 x equals: 1.
	self assert: coordinates3 y equals: 6
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

{ #category : #tests }
GCoordinatesTest >> testUpperLimitsWith [
	| coordinates2 coordinates3 |
	coordinates := G2DCoordinates x: 1 y: 8.
	coordinates2 := G2DCoordinates x: 4 y: 6.
	coordinates3 := coordinates upperLimitsWith: coordinates2.
	self assert: coordinates3 x equals: 4.
	self assert: coordinates3 y equals: 8
]
