Class {
	#name : #GPolygonTest,
	#superclass : #GShapeTestCase,
	#instVars : [
		'polygon'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GPolygonTest >> actualClass [
	^ GPolygon
]

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
GPolygonTest >> testEquals [
	polygon := GPolygon vertices: {(1 , 1) . (2 , 3) . (5 , 8) . (2 , 5)}.
	self assert: polygon equals: (GPolygon vertices: {(1 , 1) . (2 , 3) . (5 , 8) . (2 , 5)}).
	self assert: polygon hash equals: (GPolygon vertices: {(1 , 1) . (2 , 3) . (5 , 8) . (2 , 5)}) hash.
	self deny: polygon = (GPolygon vertices: {(1 , 1) . (2 , 4) . (5 , 8) . (2 , 5)}).
	self deny: polygon hash = (GPolygon vertices: {(1 , 1) . (2 , 4) . (5 , 8) . (2 , 5)}) hash
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
GPolygonTest >> testIncludes [
	self assert: ((GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}) includes: -5 , 5)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithArc [
	| arc |
	polygon := GPolygon vertices: {(1 , 2) . (1 , 5) . (-3 , 5) . (-3 , 0)}.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (polygon intersectionsWith: arc) isEmpty.

	arc := GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2.
	self assert: (polygon intersectionsWith: arc) hasCloseElementsTo: {(1 , 3)}.
	self assertCollection: (polygon intersectionsWith: arc) hasSameElements: (polygon intersectionsWithArc: arc)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithEllipse [
	| ellipse |
	polygon := GPolygon vertices: {(5 , 1) . (9 , 1) . (8 , 0) . (6 , -1)}.
	ellipse := GEllipse center: 2,6 vertex: 7, 6 coVertex: 2,9 .
	self assert: (polygon intersectionsWith: ellipse) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: ellipse) hasCloseElementsTo: {(2 , 3) . (5.7267799 , 4)}.
	self assertCollection: (polygon intersectionsWith: ellipse) hasSameElements: (polygon intersectionsWithEllipse: ellipse)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithLine [
	| line |
	line := GLine through: 0 , 1 and: 5 , 6.
	polygon := GPolygon vertices: {(3 , 3) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: line) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: line) hasCloseElementsTo: {(3 , 4) . (2 , 3)}.
	self assertCollection: (polygon intersectionsWith: line) hasSameElements: (polygon intersectionsWithLine: line).

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
	self assertCollection: (polygon intersectionsWith: point) hasSameElements: (polygon intersectionsWithPoint: point)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithPolygon [
	| polygon2 |
	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	polygon2 := GPolygon vertices: {(-3 , 5) . (0 , 5) . (1 , 2) . (-1 , 4)}.
	self assert: (polygon intersectionsWith: polygon2) isEmpty.

	polygon2 := GPolygon vertices: {(5 , 1) . (8 , 1) . (8 , 0) . (6 , -1)}.
	self assert: (polygon intersectionsWith: polygon2) hasCloseElementsTo: {(6 , 1)}.

	polygon2 := GPolygon vertices: {(5 , 6) . (8 , 7) . (8 , 3) . (5 , 3)}.
	self assert: (polygon intersectionsWith: polygon2) hasCloseElementsTo: {(6 , 3) . (5 , 4)}.
	self assertCollection: (polygon intersectionsWith: polygon2) hasSameElements: (polygon intersectionsWithPolygon: polygon2)
]

{ #category : #tests }
GPolygonTest >> testIntersectionsWithRay [
	| ray |
	ray := GRay origin: 0 , -1 direction: 0 , 4.
	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (polygon intersectionsWith: ray) isEmpty.

	ray := GRay origin: 1 , 3 direction: 0 , -1.
	self assert: (polygon intersectionsWith: ray) isEmpty.

	ray := GRay origin: 0 , 1 direction: 5 , 6.
	self assert: (polygon intersectionsWith: ray) hasCloseElementsTo: {(2 , 3) . (3 , 4)}.
	self assertCollection: (polygon intersectionsWith: ray) hasSameElements: (polygon intersectionsWithRay: ray)
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
	self assertCollection: (polygon intersectionsWith: segment) hasSameElements: (polygon intersectionsWithSegment: segment)
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

	self should: [ polygon scaleBy: 0 ] raise: GeometryError
]

{ #category : #tests }
GPolygonTest >> testTranslateBy [
	polygon := GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}.
	polygon translateBy: 10 , 10.
	self assert: polygon vertices equals: {(20 , 20) . (0 , 20) . (0 , 0)}
]
