Class {
	#name : #GRectangleTest,
	#superclass : #GTestCase,
	#instVars : [
		'rectangle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GRectangleTest >> actualClass [
	^ GRectangle
]

{ #category : #running }
GRectangleTest >> setUp [
	super setUp.
	rectangle := GRectangle origin: 10 , 10 corner: 20 , 20
]

{ #category : #tests }
GRectangleTest >> testArea [
	self assert: (GRectangle origin: 0 , 0 corner: 5 , 5) area equals: 25.
	self assert: (GRectangle origin: 2 , 3 corner: 10 , 8) area equals: 40.
	self assert: (GRectangle origin: 5 , 5 corner: 6 , 6) area equals: 1.
	self assert: (GRectangle origin: -1 , -2 corner: 2 , 1) area equals: 9
]

{ #category : #tests }
GRectangleTest >> testBoundaryContains [
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) boundaryContains: 1 , 3).
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) boundaryContains: 2 , 3).
	self deny: ((GRectangle origin: 1 , 3 corner: 3 , 0) boundaryContains: 0 , 0)
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
GRectangleTest >> testHeight [
	self assert: rectangle height equals: 10
]

{ #category : #tests }
GRectangleTest >> testIncludes [
	self assert: (rectangle includes: 11 , 11).
	self assert: (rectangle includes: 10 , 10).
	self deny: (rectangle includes: 9 , 9).
	self deny: (rectangle includes: 21 , 21).
	self deny: (rectangle includes: 15 , 21).
	self deny: (rectangle includes: 9 , 15).
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) includes: 2 , 1).
	self deny: ((GRectangle origin: 1 , 3 corner: 3 , 0) includes: 0 , 0)
]

{ #category : #tests }
GRectangleTest >> testIntersectionsWithLine [
	| intersections |
	intersections := (GRectangle origin: 1 , 3 corner: 3 , 0) intersectionsWithLine: (GSegment with: 0 , 3 with: 4 , 1) asGLine.
	self assert: intersections hasCloseElementsTo: {(1 , (5 / 2)) . (3 , (3 / 2))}
]

{ #category : #tests }
GRectangleTest >> testIntersectionsWithRay [
	self assert: ((GRectangle origin: 1 , 3 corner: 3 , 0) intersectionsWithRay: (GRay origin: 2 , 1 direction: 4 , 1)) hasCloseElementsTo: {(3 , 1)}
]

{ #category : #tests }
GRectangleTest >> testVertices [
	self should: [ GRectangle vertices: {(1 , 1) . (2 , 2) . (3 , 5)} ] raise: GError.
	self should: [ GRectangle vertices: {(0 , 0) . (2 , 0) . (2 , -2) . (-1 , -2)} ] raise: GError
]

{ #category : #tests }
GRectangleTest >> testWidth [
	self assert: rectangle width equals: 10
]
