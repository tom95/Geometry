Class {
	#name : #GEllipseTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GEllipseTest >> testArea [
	self assert: (GEllipse center: 5 , -1 vertex: 10 , -1 coVertex: 5 , 2) area =~ 47.123889
]

{ #category : #tests }
GEllipseTest >> testEncompassingRectangle [
	self assert: (GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2) encompassingRectangle equals: (-1 , 2 corner: 9 , -4)
]

{ #category : #tests }
GEllipseTest >> testEquals [
	self assert: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) equals: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10).
	self assert: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) hash equals: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) hash.
	self deny: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) = (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10).
	self deny: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) hash = (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10) hash
]

{ #category : #tests }
GEllipseTest >> testFitInExtent [
	| ellipse |
	ellipse :=  (GEllipse center: 10 , 10 vertex: 20, 10 coVertex: 10, 15).
	ellipse fitInExtent: #(100 100) asGVector.
	self assert: ellipse center equals: 10 , 10.
	self assert: ellipse vertex equals: 60, 10.
	self assert: ellipse coVertex equals: 10, 60.
	
	ellipse :=  (GEllipse center: 10 , 10 vertex: 20, 10 coVertex: 10, 15).
	ellipse fitInExtent: #(100 60) asGVector.
	self assert: ellipse center equals: 10 , 10.
	self assert: ellipse vertex equals: 60, 10.
	self assert: ellipse coVertex equals: 10, 40
]

{ #category : #tests }
GEllipseTest >> testFoci [
	| foci |
	foci := (GEllipse center: 10 , 10 vertex: 7.171575 , 10 coVertex: 10 , 8) foci.
	self assert: (foci anySatisfy: [ :e | e =~ (8 , 10) ]).
	self assert: (foci anySatisfy: [ :e | e =~ (12 , 10) ])
]

{ #category : #tests }
GEllipseTest >> testFociLocation [
	self assert: (GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2) fociLocation equals: 4
]

{ #category : #tests }
GEllipseTest >> testIncludesPoint [
	| ellipse |
	ellipse := (GEllipse center: 4 , 1 vertex: 6 , 1 coVertex: 4 , 2).
	self assert: (ellipse includesPoint: 4, 1).
	self assert: (ellipse includesPoint: 6, 1).
	self assert: (ellipse includesPoint: 4, 2).
	self assert: (ellipse includesPoint: 3, 1).
	self deny: (ellipse includesPoint: 2.1, 0.1).
	self deny: (ellipse includesPoint: 3, 0.13).
	self assert: (ellipse includesPoint: 3, 0.15).
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLine [
	"Test with an ellipse centered at the origin and a line going through the origin"

	self
		assert:
			(((GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0) intersectionsWithLine: (GLine a: -1 b: 1 c: 0))
				anySatisfy: [:point | point =~ (1.6641 , 1.6641)]).
	self
		assert:
			(((GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0) intersectionsWithLine: (GLine a: -1 b: 1 c: 0))
				anySatisfy: [:point | point =~ (-1.6641 , -1.6641)]).


	"Test with an ellipse centered at the origin and a line not going through the origin"
	self
		assert:
			(((GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0) intersectionsWithLine: (GLine a: -1 b: 1 c: -1))
				anySatisfy: [:point | point =~ (0.9065084 , 1.9065084)]).
	self
		assert:
			(((GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0) intersectionsWithLine: (GLine a: -1 b: 1 c: -1))
				anySatisfy: [:point | point =~ (-2.291123 , -1.291123)]).


	"Test with an ellipse not centered at the origin and a line not going through the origin"
	self
		assert:
			(((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -2 b: 1 c: -8))
				anySatisfy: [:point | point =~ (-0.263181454 , 7.473637091)]).
	self
		assert:
			(((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -2 b: 1 c: -8))
				anySatisfy: [:point | point =~ (-1.873804847 , 4.252390306)]).
	self
		assert: ((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWith: (GLine a: -2 b: 1 c: -8))
		equals: ((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -2 b: 1 c: -8)).
	self
		assert: ((GLine a: -2 b: 1 c: -8) intersectionsWith: (GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5))
		equals: ((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -2 b: 1 c: -8))
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLineWithTangent [
	self
		assert:
			((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -1 b: 1 c: -8)) anyOne
				=~ (-6 / 5 , (34 / 5)).
	self
		assert: ((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -1 b: 1 c: -8)) size
		equals: 1
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLineWithoutIntersections [
	self assert: ((GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5) intersectionsWithLine: (GLine a: -1 b: 1 c: -20)) isEmpty
]

{ #category : #tests }
GEllipseTest >> testMajorAxis [
	self assert: (GEllipse center: 10 , 10 vertex: 7.1715 , 10 coVertex: 10 , 8) majorAxis equals: (GSegment with: 7.1715 , 10 with: 12.8285 , 10)
]

{ #category : #tests }
GEllipseTest >> testMinorAxis [
	self assert: (GEllipse center: 10 , 10 vertex: 7.1715 , 10 coVertex: 10 , 8) minorAxis equals: (GSegment with: 10 , 8 with: 10 , 12)
]

{ #category : #tests }
GEllipseTest >> testTranslateBy [
	| ellipse |
	ellipse :=  (GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2).
	ellipse translateBy: { 1 . 1} asGVector.
	self assert: ellipse center equals: 5 , 0.
	self assert: ellipse vertex equals: 10, 0.
	self assert: ellipse coVertex equals: 5, 3
]
