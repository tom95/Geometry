Class {
	#name : #GRayTest,
	#superclass : #GTestCase,
	#instVars : [
		'ray'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GRayTest >> testAngleInRadiansWith [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 5 , 24.
	ray2 := GRay origin: 3 , 4 direction: 4 , 7.
	self assert: (ray angleInRadiansWith: ray2) closeTo: 0.11635
]

{ #category : #tests }
GRayTest >> testEquals [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	ray2 := GRay origin: 0 , 0 direction: 2 , 2.
	self assert: ray equals: ray2.
	self assert: ray hash equals: ray2 hash.

	ray2 := GRay origin: 0,0 direction: 2, 3.
	self deny: ray = ray2.
	self deny: ray hash = ray2 hash
]

{ #category : #tests }
GRayTest >> testFlipped [
	self assert: (GRay origin: 100 , 100 direction: 80 , 110) flipped directionPoint equals: 120 , 90.
	self assert: (GRay origin: 100 , 100 direction: 120 , 90) flipped directionPoint equals: 80 , 110
]

{ #category : #tests }
GRayTest >> testIncludesPoint [
	self deny: ((GRay origin: 100 , 100 direction: 80 , 110) includesPoint: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includesPoint: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includesPoint: 100 , 100).
	self assert: ((GRay origin: 100 , 100 direction: 110 , 110) includesPoint: 150 , 150).
	self assert: ((GRay origin: 0 , 0 direction: 12 , 9) includesPoint: 13 , (39 / 4)).
	self assert: ((GRay origin: 28 , 30 direction: 9 , 1) includesPoint: -4.97992 , -20.33777)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: -5 , 1 and: -3 , 3.	
	ray := GRay origin: -5 , 3  direction: -7, 5 .
	self assert: (ray intersectionsWith: line) isEmpty.
	
	ray := GRay origin: -7 , 5  direction: -5, 3 .
	self assert: (ray intersectionsWith: line) hasCloseElementsTo: {(-4 , 2)}.
	self assert: (ray intersectionsWith: line) equals: (ray intersectionsWithLine: line)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	ray := GRay origin: 5 , 6 direction: 7 , 102.
	self assert: (ray intersectionsWith: point) isEmpty.

	ray := GRay origin: 1 , 3 direction: 0 , 2.
	self assert: (ray intersectionsWith: point) isEmpty.

	ray := GRay origin: 0 , 2 direction: 1 , 3.
	self assert: (ray intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.

	ray := GRay origin: 1 , 3 direction: 3 , 5.
	self assert: (ray intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assert: (ray intersectionsWith: point) equals: (ray intersectionsWithPoint: point)
]

{ #category : #tests }
GRayTest >> testIntersectionsWithSegment [
	| segment |
	segment := GSegment with: -2 , 0 with: -2 , 3.
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	self assert: (ray intersectionsWith: segment) isEmpty.

	segment := GSegment with: 2 , 0 with: 2 , 3.
	self assert: (ray intersectionsWith: segment) hasCloseElementsTo: {(2 , 2)}.
	self assert: (ray intersectionsWith: segment) equals: (ray intersectionsWithSegment: segment).

	ray := GRay origin: 1 , 1 direction: 0 , 0.
	self assert: (ray intersectionsWith: segment) isEmpty
]
