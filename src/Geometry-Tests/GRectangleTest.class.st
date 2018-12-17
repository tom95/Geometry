Class {
	#name : #GRectangleTest,
	#superclass : #TestCase,
	#instVars : [
		'rectangle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #running }
GRectangleTest >> setUp [
	super setUp.
	rectangle := 10 , 10 corner: 20 , 20
]

{ #category : #tests }
GRectangleTest >> testArea [
	self assert: (0 , 0 corner: 5 , 5) area equals: 25.
	self assert: (2 , 3 corner: 10 , 8) area equals: 40.
	self assert: (5 , 5 corner: 6 , 6) area equals: 1.
	self assert: (-1 , -2 corner: 2 , 1) area equals: 9
]

{ #category : #tests }
GRectangleTest >> testCenter [
	| translated1 translated2 |
	rectangle := GRectangle vertices: {(1 , 1) . (5 , 1) . (5 , 6) . (1 , 6)}.
	self assert: rectangle center equals: 3, (7/2).

	rectangle := GRectangle vertices: {(1 , 3) . (2 , 1) . (5 , 4) . (4 , 6)}.
	self assert: rectangle center equals: 3, (7/2).

	rectangle := GRectangle vertices: {(1 , 3) . (4 , 6) . (5 , 4) . (2 , 1)}.
	self assert: rectangle center equals: 3, (7/2).
	
	rectangle := GRectangle vertices: {(1 , 3) . (4 , 6) . (5 , 4) . (2 , 1)}.
	translated1 := rectangle translateBy: #(1 2) asGVector.
	rectangle := GRectangle vertices: {(1 , 3) . (4 , 6) . (5 , 4) . (2 , 1)}.
	translated2 := rectangle translateBy: #(1 2) asGVector.
	self assert: translated1 center = translated2 center description: 'the center is translated with the rectangle'
]

{ #category : #tests }
GRectangleTest >> testDiagonals [
	rectangle := GRectangle vertices: {(1 , 1) . (5 , 1) . (5 , 6) . (1 , 6)}.
	self assertCollection: rectangle diagonals hasSameElements: {(GSegment with: 1 , 6 with: 5 , 1) . (GSegment with: 5 , 6 with: 1 , 1)}.

	rectangle := GRectangle vertices: {(1 , 3) . (2 , 1) . (5 , 4) . (4 , 6)}.
	self assertCollection: rectangle diagonals hasSameElements: {(GSegment with: 1 , 3 with: 5 , 4) . (GSegment with: 4 , 6 with: 2 , 1)}.

	rectangle := GRectangle vertices: {(1 , 3) . (4 , 6) . (5 , 4) . (2 , 1)}.
	self assertCollection: rectangle diagonals hasSameElements: {(GSegment with: 1 , 3 with: 5 , 4) . (GSegment with: 4 , 6 with: 2 , 1)}
]

{ #category : #tests }
GRectangleTest >> testExpandBy [
	rectangle := GRectangle vertices: {(-1 , -1) . (-1 , 1) . (1 , 1) . (1 , -1)}.
	rectangle expandBy: 0.5.
	self assert: rectangle equals: (GRectangle vertices: {(-1.5 , -1.5) . (-1.5 , 1.5) . (1.5 , 1.5) . (1.5 , -1.5)}).

	rectangle := GRectangle vertices: {(-2 , -1) . (-2 , 1) . (2 , 1) . (2 , -1)}.
	rectangle expandBy: 0.5.
	self assert: rectangle equals: (GRectangle vertices: {(-2.5 , -1.5) . (-2.5 , 1.5) . (2.5 , 1.5) . (2.5 , -1.5)})
]

{ #category : #tests }
GRectangleTest >> testExtent [
	rectangle := GRectangle vertices: {(1 , 1) . (5 , 1) . (5 , 6) . (1 , 6)}.
	self assert: rectangle extent equals: #(4 5) asGVector.

	rectangle := GRectangle vertices: {(1 , 3) . (2 , 1) . (5 , 4) . (4 , 6)}.
	self assert: rectangle extent equals: #(4 5) asGVector.

	rectangle := GRectangle vertices: {(1 , 3) . (4 , 6) . (5 , 4) . (2 , 1)}.
	self assert: rectangle extent equals: #(4 5) asGVector
]

{ #category : #tests }
GRectangleTest >> testHasOnBoundary [
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) hasOnBoundary: 1 , 3).
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) hasOnBoundary: 2 , 3).
	self deny: ((GRectangle origin: 1 , 3 corner: 3 , 0) hasOnBoundary: 0 , 0)
]

{ #category : #tests }
GRectangleTest >> testHeight [
	self assert: rectangle height equals: 10
]

{ #category : #tests }
GRectangleTest >> testIncludesPoint [
	self assert: (rectangle includesPoint: 11 , 11).
	self assert: (rectangle includesPoint: 10 , 10).
	self deny: (rectangle includesPoint: 9 , 9).
	self deny: (rectangle includesPoint: 21 , 21).
	self deny: (rectangle includesPoint: 15 , 21).
	self deny: (rectangle includesPoint: 9 , 15).
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) includesPoint: 2 , 1).
	self deny: ((GRectangle origin: 1 , 3 corner: 3 , 0) includesPoint: 0 , 0)
]

{ #category : #tests }
GRectangleTest >> testIntersectionsWithLine [
	| intersections |
	intersections := (GRectangle origin: 1 , 3 corner: 3 , 0) intersectionsWithLine: (GSegment with: 0 , 3 with: 4 , 1) asLine.
	self assert: (intersections anySatisfy: [ :e | e =~ (1 , (5 / 2)) ]).
	self assert: (intersections anySatisfy: [ :e | e =~ (3 , (3 / 2)) ]).

	intersections := (GRectangle origin: -60 , -80 corner: 80 , 60)
		intersectionsWithLine: (GSegment with: 174.8683298050514 , -174.86832980505142 with: -14.868329805051376 , 14.868329805051385) asLine.
	self assert: (intersections anySatisfy: [ :e | e =~ (-60 , 60) ]).
	self assert: (intersections anySatisfy: [ :e | e =~ (80 , -80) ])
]

{ #category : #tests }
GRectangleTest >> testIntersectionsWithRay [
	self assertCollection: ((GRectangle origin: 1 , 3 corner: 3 , 0) intersectionsWithRay: (GRay origin: 2 , 1 direction: 4 , 1)) hasSameElements: {(3 , 1)}
]

{ #category : #tests }
GRectangleTest >> testSideWhichHas [
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) sideWhichHas: 1 , 2.5) equals: (GSegment with: 1 , 3 with: 1 , 0)
]

{ #category : #tests }
GRectangleTest >> testWidth [
	self assert: rectangle width equals: 10
]
