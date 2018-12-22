Class {
	#name : #GEllipseTest,
	#superclass : #GTestCase,
	#instVars : [
		'ellipse'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GEllipseTest >> testArea [
	ellipse := GEllipse center: 5 , -1 vertex: 10 , -1 coVertex: 5 , 2.
	self assert: ellipse area =~ 47.123889
]

{ #category : #tests }
GEllipseTest >> testBoundaryContains [
	ellipse := (GEllipse center: 4 , 1 vertex: 6 , 1 coVertex: 4 , 2).
	self deny: (ellipse boundaryContains: 4, 1).
	self assert: (ellipse boundaryContains: 6, 1).
	self assert: (ellipse boundaryContains: 4, 2).
	self deny: (ellipse boundaryContains: 3, 1).
	self deny: (ellipse boundaryContains: 2.1, 0.1).
	self deny: (ellipse boundaryContains: 3, 0.13).
]

{ #category : #tests }
GEllipseTest >> testEncompassingRectangle [
	ellipse := GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2.
	self assert: ellipse encompassingRectangle equals: (-1 , 2 corner: 9 , -4)
]

{ #category : #tests }
GEllipseTest >> testEquals [
	ellipse := GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10.
	self assert: ellipse equals: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10).
	self assert: ellipse hash equals: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) hash.
	self deny: ellipse = (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10).
	self deny: ellipse hash = (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10) hash
]

{ #category : #tests }
GEllipseTest >> testFitInExtent [
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
	self assert: foci hasCloseElementsTo: {(8 , 10) . (12 , 10)}
]

{ #category : #tests }
GEllipseTest >> testFociLocation [
	ellipse := GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2.
	self assert: ellipse fociLocation equals: 4
]

{ #category : #tests }
GEllipseTest >> testIncludesPoint [
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
	| line |
	"Test with an ellipse centered at the origin and a line going through the origin"
	ellipse := GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0.
	line := GLine a: -1 b: 1 c: 0.
	self assert: (ellipse intersectionsWithLine: line) hasCloseElementsTo: {(1.6641 , 1.6641) . (-1.6641 , -1.6641)}.

	"Test with an ellipse centered at the origin and a line not going through the origin"
	line := GLine a: -1 b: 1 c: -1.
	self assert: (ellipse intersectionsWithLine: line) hasCloseElementsTo: {(0.9065084 , 1.9065084) . (-2.291123 , -1.291123)}.

	"Test with an ellipse not centered at the origin and a line not going through the origin"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -2 b: 1 c: -8.
	self assert: (ellipse intersectionsWithLine: line) hasCloseElementsTo: {(-0.263181454 , 7.473637091) . (-1.873804847 , 4.252390306)}.
	self assert: (ellipse intersectionsWith: line) equals: (ellipse intersectionsWithLine: line).
	self assert: (line intersectionsWith: ellipse) equals: (ellipse intersectionsWithLine: line)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLineWithTangent [
	| line |
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -1 b: 1 c: -8.
	self assert: (ellipse intersectionsWithLine: line) hasCloseElementsTo: {(-6 / 5 , (34 / 5))}
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLineWithoutIntersections [
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	self assert: (ellipse intersectionsWithLine: (GLine a: -1 b: 1 c: -20)) isEmpty
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	ellipse := GEllipse center: 1 , 3 vertex: 5 , 6 coVertex: 3 , 4.
	self assert: (ellipse intersectionsWith: point) isEmpty.

	ellipse := GEllipse center: 2 , 1 vertex: 5 , 1 coVertex: 2 , 4.
	self assert: (ellipse intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assert: (ellipse intersectionsWith: point) equals: (ellipse intersectionsWithPoint: point)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithVerticalLine [
	| line |
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	line := GLine a: 1 b: 0 c: -2.
	self assert: (ellipse intersectionsWithVerticalLine: line) hasCloseElementsTo: {(2 , 0.3999999) . (2 , 3.6)}.
	self assert: (ellipse intersectionsWithLine: line) equals: (ellipse intersectionsWithVerticalLine: line)
]

{ #category : #tests }
GEllipseTest >> testMajorAxis [
	ellipse := GEllipse center: 10 , 10 vertex: 7.1715 , 10 coVertex: 10 , 8.
	self assert: (ellipse) majorAxis equals: (GSegment with: 7.1715 , 10 with: 12.8285 , 10)
]

{ #category : #tests }
GEllipseTest >> testMinorAxis [
	ellipse := GEllipse center: 10 , 10 vertex: 7.1715 , 10 coVertex: 10 , 8.
	self assert: ellipse minorAxis equals: (GSegment with: 10 , 8 with: 10 , 12)
]

{ #category : #tests }
GEllipseTest >> testTranslateBy [
	ellipse :=  (GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2).
	ellipse translateBy: { 1 . 1} asGVector.
	self assert: ellipse center equals: 5 , 0.
	self assert: ellipse vertex equals: 10, 0.
	self assert: ellipse coVertex equals: 5, 3
]
