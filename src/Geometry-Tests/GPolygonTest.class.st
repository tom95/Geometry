Class {
	#name : #GPolygonTest,
	#superclass : #GTestCase,
	#instVars : [
		'polygon'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GPolygonTest >> testBoundaryContains [
	self assert: ((GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}) boundaryContains: 0 , 10).
	self deny: ((GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}) boundaryContains: -5 , 5)
]

{ #category : #tests }
GPolygonTest >> testConvexHullOn [
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 , -20).
					(0 , 10).
					(30 , -30).
					(40 , 0).
					(-10 , 0).
					(40 , -20)}) vertices
		equals:
			{(-10 , 0).
			(0 , -20).
			(30 , -30).
			(40 , -20).
			(40 , 0).
			(0 , 10)} asOrderedCollection.
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 , -20).
					(0 , 10).
					(30 , -30).
					(0 , 0).
					(40 , 0).
					(-10 , 0).
					(40 , -20)}) vertices
		equals:
			{(-10 , 0).
			(0 , -20).
			(30 , -30).
			(40 , -20).
			(40 , 0).
			(0 , 10)} asOrderedCollection
]

{ #category : #tests }
GPolygonTest >> testEdges [
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 , -20).
					(0 , 10).
					(30 , -30).
					(40 , 0).
					(-10 , 0).
					(40 , -20)}) edges first
		equals: (GSegment with: -10 , 0 with: 0 , -20).
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 , -20).
					(0 , 10).
					(30 , -30).
					(40 , 0).
					(-10 , 0).
					(40 , -20)}) edges second
		equals: (GSegment with: 0 , -20 with: 30 , -30).
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 , -20).
					(0 , 10).
					(30 , -30).
					(40 , 0).
					(-10 , 0).
					(40 , -20)}) edges last
		equals: (GSegment with: -10 , 0 with: 0 , 10)
]

{ #category : #tests }
GPolygonTest >> testEncompassingRectangle [
	self
		assert:
			(GPolygon
				vertices:
					{(0 , -20) . (0 , 10) . (30 , -30) . (40 , 0) . (-10 , 0).
					(40 , -20)}) encompassingRectangle
		equals:
			(GRectangle
				left: -10
				right: 40
				top: 10
				bottom: -30)
]

{ #category : #tests }
GPolygonTest >> testFitInExtent [
	polygon := GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}.
	polygon fitInExtent: {20 . 20} asGVector.
	self
		assert: polygon vertices
		equals: {(10 , 10) . (-10 , 10) . (-10 , -10)}.
	polygon fitInExtent: {40 . 40} asGVector.
	self
		assert: polygon vertices
		equals: {(20 , 20) . (-20 , 20) . (-20 , -20)}.
	polygon fitInExtent: {10 . 10} asGVector.
	self
		assert: polygon vertices
		equals: {(5 , 5) . (-5 , 5) . (-5 , -5)}
]

{ #category : #tests }
GPolygonTest >> testIncludesPoint [
	self assert: ((GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}) includesPoint: -5 , 5)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: 0 , 1 and: 5 , 6.
	polygon := GPolygon vertices: {(3 , 3) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: line) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: line) hasCloseElementsTo: {(3 , 4) . (2 , 3)}.
	self assert: (polygon intersectionsWith: line) equals: (polygon intersectionsWithLine: line).

	polygon := GPolygon vertices: {(2 , 3) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: line) hasCloseElementsTo: {(2 , 3)}
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	polygon := GPolygon vertices: {(1 , 5) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: point) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assert: (polygon intersectionsWith: point) equals: (polygon intersectionsWithPoint: point)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithSegment [
	| segment |
	segment := GSegment with: 0 , -1 with: 0 , 4.
	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: segment) isEmpty.

	segment := GSegment with: 0 , -1 with: 1 , 3.
	self assert: (polygon intersectionsWith: segment) isEmpty.

	segment := GSegment with: 0 , 1 with: 5 , 6.
	self assert: (polygon intersectionsWith: segment) hasCloseElementsTo: {(2 , 3) . (3 , 4)}.
	self assert: (polygon intersectionsWith: segment) equals: (polygon intersectionsWithSegment: segment)
]

{ #category : #tests }
GPolygonTest >> testScaleBy [
	polygon := GPolygon vertices: {(10 , 4) . (-4 , 10) . (-10 , -8)}.
	polygon scaleBy: 1.
	self assert: polygon vertices equals: {(10 , 4) . (-4 , 10) . (-10 , -8)}.

	polygon := GPolygon vertices: {(5 , 2) . (-2 , 5) . (-5 , -5)}.
	polygon scaleBy: 2.
	self assert: polygon vertices equals: {(10 , 4) . (-4 , 10) . (-10 , -10)}.

	polygon := GPolygon vertices: {(10 , 4) . (-4 , 10) . (-10 , -10)}.
	polygon scaleBy: 1 / 2.
	self assert: polygon vertices equals: {(5 , 2) . (-2 , 5) . (-5 , -5)}.

	self should: [ polygon scaleBy: 0 ] raise: GError
]

{ #category : #tests }
GPolygonTest >> testTranslateBy [
	polygon := GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}.
	polygon translateBy: 10 , 10.
	self assert: polygon vertices equals: {(20 , 20) . (0 , 20) . (0 , 0)}
]
