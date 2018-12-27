Class {
	#name : #GCircleTest,
	#superclass : #GTestCase,
	#instVars : [
		'circle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GCircleTest >> testBoundaryContains [
	circle := GCircle center: 609 / 17 , (10837 / 136) radius: 38.27069133568686.
	self assert: (circle boundaryContains: 5 , 57).
	self assert: (circle boundaryContains: 74 , 77).
	self deny: (circle boundaryContains: 74 , 72).

	circle := GCircle center: 2 , 2 radius: 3.
	self assert: (circle boundaryContains: 5 , 2)
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsAny [
	circle := GCircle center: 2 , 2 radius: 3.
	self assert: (circle boundaryContainsAny: {(2 , 2) . (5 , 2)})
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsWhichOf [
	circle := GCircle center: 2 , 2 radius: 3.
	self assert: (circle boundaryContainsWhichOf: {(2 , 2) . (5 , 2)}) equals: {(5 , 2)}
]

{ #category : #tests }
GCircleTest >> testContains [
	circle := GCircle center: 2 , 2 radius: 3.
	self assert: (circle contains: 2 , 2).
	self deny: (circle contains: 6 , 2).

	circle := GCircle center: 30 , 30 radius: 20.
	self deny: (circle contains: 50 , 30).
	self deny: (circle contains: 10 , 30).
	self deny: (circle contains: 30 , 10).
	self assert: (circle contains: 30 , 30).

	circle := GCircle center: 0 , 0 radius: 31.62277660168381.
	self deny: (circle contains: -30 , -10).
	self deny: (circle contains: 10 , -30).
	self deny: (circle contains: 30 , 10).
	self deny: (circle contains: 30 , 30).
	self assert: (circle contains: 10 , 10)
]

{ #category : #tests }
GCircleTest >> testEncompassingRectangle [
	circle := GCircle center: 2 , 2 radius: 3.
	self assert: circle encompassingRectangle equals: (-1 , -1 corner: 5 , 5)
]

{ #category : #tests }
GCircleTest >> testEquals [
	circle := GCircle center: 1 , 1 radius: 3.
	self assert: circle equals: (GCircle center: 1 , 1 radius: 3).
	self assert: circle hash equals: (GCircle center: 1 , 1 radius: 3) hash.
	self deny: circle = (GCircle center: 1.002 , 1.009 radius: 3).
	self deny: circle hash = (GCircle center: 1.002 , 1.009 radius: 3) hash.
	self assert: circle equals: (GCircle center: 1 , 1 radius: 2.999999999).
	self assert: circle equals: (GCircle center: 1.00000001 , 0.9999991 radius: 2.999999999).
	self deny: circle = (GCircle center: 1 , 1 radius: 34).
	circle := GCircle center: 1.4 , 1 radius: 3.
	self deny: circle = (GCircle center: 1 , 1 radius: 34)
]

{ #category : #tests }
GCircleTest >> testIncludes [
	circle := GCircle center: 2 , 2 radius: 3.
	self assert: (circle includes: 2 , 2).
	self deny: (circle includes: 6 , 2).

	circle := GCircle center: 30 , 30 radius: 20.
	self assert: (circle includes: 50 , 30).
	self assert: (circle includes: 10 , 30).
	self assert: (circle includes: 30 , 10).
	self assert: (circle includes: 30 , 30).

	circle := GCircle center: 0 , 0 radius: 31.62277660168381.
	self assert: (circle includes: -30 , -10).
	self assert: (circle includes: 10 , -30).
	self assert: (circle includes: 30 , 10).
	self deny: (circle includes: 30 , 30).
	self assert: (circle includes: 10 , 10).

	circle := GCircle center: 0 , 0 radius: 31.61277660168381.
	self deny: (circle includes: 30 , 10)
]

{ #category : #tests }
GCircleTest >> testPerimeter [
	circle := GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686.
	self assert: circle perimeter equals: 240.46184549599278
]

{ #category : #tests }
GCircleTest >> testPolygonOn [
	circle := GCircle center: 1 , 1 radius: 3.
	self assert: ((circle polygonOn: {(-20 , 10) . (40 , 10) . (10 , -20)}) at: 1) v1 equals: -20 , 10
]

{ #category : #tests }
GCircleTest >> testTranslateBy [
	circle := GCircle center: 3,4 radius: 2.
	circle translateBy: #(1 -2) asGVector.
	self assert: circle center equals: 4, 2.
	self assert: circle radius equals: 2
]

{ #category : #tests }
GCircleTest >> testUpperPoint [
	circle := GCircle center: 1 , 1 radius: 3.
	self assert: circle upperPoint equals: 1 , 4
]
