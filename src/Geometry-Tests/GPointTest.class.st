Class {
	#name : #GPointTest,
	#superclass : #TestCase,
	#instVars : [
		'point'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GPointTest >> test2DPoint [
	point := GPoint x: 1 y: 2.
	self assert: point x equals: 1.
	self assert: point y equals: 2.
	
	point := GPoint x: -1 y: -2.
	self assert: point x equals: -1.
	self assert: point y equals: -2.
	
	point := GPoint coordinates: (G2DCoordinates x: 1 y: 2).
	self assert: point x equals: 1.
	self assert: point y equals: 2.
	
	point := (1 , 2).
	self assert: point x equals: 1.
	self assert: point y equals: 2.
]

{ #category : #tests }
GPointTest >> testAddition [
	| vector |
	point := (1, 2).
	vector := GVector x: 2 y: 3.
	self assert: point + vector equals: (3, 5).
	self assert: point equals: (1, 2)
]

{ #category : #tests }
GPointTest >> testCopy [
	| pointCopy |
	point := (1, 2).
	pointCopy := point copy.
	self assert: point equals: pointCopy.
	point x: 2.
	self deny: point = pointCopy.
	self deny: point == pointCopy
]

{ #category : #tests }
GPointTest >> testDistanceTo [
	self assert: (0 , 0 distanceTo: 0 , 0) equals: 0.
	self assert: (0 , 0 distanceTo: 0 , 5) equals: 5.
	self assert: (5 , 0 distanceTo: 0 , 0) equals: 5.
	self assert: (3 , 0 distanceTo: 0 , 4) equals: 5.
	self assert: (5 , 0 distanceTo: 2 , 4) equals: 5.
	self deny: (0 , 0 distanceTo: 0 , 0) = 1
]

{ #category : #tests }
GPointTest >> testEquals [
	self assert: (1 , 2) equals: (1 , 2).
	self deny: (2 , 4) = (1 , 2).
	self assert: (1 , 2) hash equals: (1 , 2) hash.
	self deny: (2 , 4) hash = (1 , 2) hash
]

{ #category : #tests }
GPointTest >> testTranslateBy [
	| vector |
	point := (1, 2).
	vector := GVector x: 2 y: 3.
	point translateBy: vector.
	self assert: point equals: (3, 5).
	point translateBy: vector.
	self assert: point equals: (5 , 8)
]

{ #category : #tests }
GPointTest >> testWithCollection [
	self assert: (GPoint withCollection: #(1 2)) equals: 1 , 2.
	self should: [ GPoint withCollection: #() ] raise: GError
]
