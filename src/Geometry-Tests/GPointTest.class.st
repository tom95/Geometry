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
GPointTest >> testIncludesPoint [
	point := 2 , 4.
	self deny: (point includesPoint: 3, 4).
	self assert: (point includesPoint: 2, 4)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithEllipse [
	| ellipse |
	point := 2 , 4.
	ellipse := GEllipse center: 1, 3 vertex: 5, 6  coVertex: 3, 4 .
	self assert: (point intersectionsWith: ellipse) isEmpty.
	
	ellipse := GEllipse center: 2, 1 vertex: 5 , 1 coVertex: 2, 4.
	self assert: (point intersectionsWith: ellipse) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: ellipse) size equals: 1.
	self assert: (point intersectionsWith: ellipse) equals: (point intersectionsWithEllipse: ellipse)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithLine [
	| line |
	point := 2 , 4.
	line := GLine through: 5 , 6 and: 7 , 102.
	self assert: (point intersectionsWith: line) isEmpty.

	line := GLine through: 1 , 3 and: 3 , 5.
	self assert: (point intersectionsWith: line) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: line) size equals: 1.
	self assert: (point intersectionsWith: line) equals: (point intersectionsWithLine: line)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithPoint [
	point := 2 , 4.
	self assert: (point intersectionsWith: 3 , 4) isEmpty.
	self assert: (point intersectionsWith: 2 , 4) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: 2 , 4) size equals: 1.
	self assert: (point intersectionsWith: 2 , 4) equals: (point intersectionsWithPoint: 2 , 4)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithPolygon [
	| polygon |
	point := 2 , 4.
	polygon := GPolygon vertices: {(1 , 5) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (point intersectionsWith: polygon) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (point intersectionsWith: polygon) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: polygon) size equals: 1.
	self assert: (point intersectionsWith: polygon) equals: (point intersectionsWithPolygon: polygon)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithRay [
	| ray |
	point := 2 , 4.
	ray := GRay origin: 5 , 6 direction: 7 , 102.
	self assert: (point intersectionsWith: ray) isEmpty.
	
	ray := GRay origin: 1 , 3 direction: 0 , 2.
	self assert: (point intersectionsWith: ray) isEmpty.
	
	ray := GRay origin: 0 , 2 direction: 1 , 3.
	self assert: (point intersectionsWith: ray) anyOne equals: 2 , 4.

	ray := GRay origin: 1 , 3 direction: 3 , 5.
	self assert: (point intersectionsWith: ray) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: ray) size equals: 1.
	self assert: (point intersectionsWith: ray) equals: (point intersectionsWithRay: ray)
]

{ #category : #tests }
GPointTest >> testIntersectionsWithSegment [
	| segment |
	point := 2 , 4.
	segment := GSegment with: 5 , 6 with: 7 , 102.
	self assert: (point intersectionsWith: segment) isEmpty.
	
	segment := GSegment with: 1 , 3 with: 0 , 2.
	self assert: (point intersectionsWith: segment) isEmpty.

	segment := GSegment with: 1 , 3 with: 3 , 5.
	self assert: (point intersectionsWith: segment) anyOne equals: 2 , 4.
	self assert: (point intersectionsWith: segment) size equals: 1.
	self assert: (point intersectionsWith: segment) equals: (point intersectionsWithSegment: segment)
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
