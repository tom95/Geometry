Class {
	#name : #GEllipseTest,
	#superclass : #GShapeTestCase,
	#instVars : [
		'ellipse'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GEllipseTest >> actualClass [
	^ GEllipse
]

{ #category : #util }
GEllipseTest >> sortedIntersectionsBetween: shape and: line [
	^ (shape intersectionsWith: line) asOrderedCollection 
		sorted: [ :a :b | a asPoint < b asPoint ].
]

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
GEllipseTest >> testEmpty [
	| shape line intersections |
	shape := GEllipse center: 0@0 vertex: 0@0 coVertex: 0@0.
	line := GLine through: shape center and: 10@10.
	intersections := self sortedIntersectionsBetween: shape and: line.
	
	self assert: intersections isNotEmpty.
	self assert: (intersections first asPoint closeTo: 0@0).
	
	"horizontal line "
	line := GLine through: 10@20 and: 20@10.
	intersections := self sortedIntersectionsBetween: shape and: line.
	self assert: intersections isEmpty.
	
	"vertical line"
	"intersectionsWithVerticalLine: 
	does not work with an empty ellipse"
	shape := GEllipse center: 0@0 vertex: 9@0 coVertex: 0@9.
	line := GLine through: 10@10 and: 10@20.
	intersections := self sortedIntersectionsBetween: shape and: line.
	self assert: intersections isEmpty.
]

{ #category : #tests }
GEllipseTest >> testEncompassingRectangle [
	ellipse := GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2.
	self assert: ellipse encompassingRectangle equals: (GRectangle origin: -1 , 2 corner: 9 , -4)
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
	ellipse := GEllipse center: 10 , 10 vertex: 20 , 10 coVertex: 10 , 15.
	ellipse fitInExtent: #(100 100) asGVector.
	self assert: ellipse center equals: 10 , 10.
	self assert: ellipse vertex equals: 60 , 10.
	self assert: ellipse coVertex equals: 10 , 60.

	ellipse := GEllipse center: 10 , 10 vertex: 20 , 10 coVertex: 10 , 15.
	ellipse fitInExtent: #(100 60) asGVector.
	self assert: ellipse center equals: 10 , 10.
	self assert: ellipse vertex equals: 60 , 10.
	self assert: ellipse coVertex equals: 10 , 40
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
GEllipseTest >> testIncludes [
	ellipse := (GEllipse center: 4 , 1 vertex: 6 , 1 coVertex: 4 , 2).
	self assert: (ellipse includes: 4, 1).
	self assert: (ellipse includes: 6, 1).
	self assert: (ellipse includes: 4, 2).
	self assert: (ellipse includes: 3, 1).
	self deny: (ellipse includes: 2.1, 0.1).
	self deny: (ellipse includes: 3, 0.13).
	self assert: (ellipse includes: 3, 0.15).
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithArc [
	"Because we need the intersection between two ellipse to do that. Until we have that, we declare the test as expected failure"
	<expectedFailure>
	| arc |
	ellipse := GEllipse center: -4 , 3 vertex: 1 , 3 coVertex: -4 , 7.
	arc := GArc center: 1 , 0 origin: 4 , 0 direction: 3 , 2.
	self assert: (ellipse intersectionsWith: arc) isEmpty.

	arc := GArc center: 1 , 0 origin: 4 , 0 direction: -1 , 2.
	self assert: (ellipse intersectionsWith: arc) hasCloseElementsTo: {(1 , 3)}.
	self assertCollection: (ellipse intersectionsWith: arc) hasSameElements: (ellipse intersectionsWithArc: arc)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithEllipse [
	self flag: #todo
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithLine [
	| line |
	"Test without intersection"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	self assert: (ellipse intersectionsWith: (GLine a: -1 b: 1 c: -20)) isEmpty.
	
	"Test with an ellipse centered at the origin and a line going through the origin"
	ellipse := GEllipse center: 0 , 0 vertex: 0 , 3 coVertex: 2 , 0.
	line := GLine a: -1 b: 1 c: 0.
	self assert: (ellipse intersectionsWith: line) hasCloseElementsTo: {(1.6641 , 1.6641) . (-1.6641 , -1.6641)}.

	"Test with an ellipse centered at the origin and a line not going through the origin"
	line := GLine a: -1 b: 1 c: -1.
	self assert: (ellipse intersectionsWith: line) hasCloseElementsTo: {(0.9065084 , 1.9065084) . (-2.291123 , -1.291123)}.

	"Test with an ellipse not centered at the origin and a line not going through the origin"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -2 b: 1 c: -8.
	self assert: (ellipse intersectionsWith: line) hasCloseElementsTo: {(-0.263181454 , 7.473637091) . (-1.873804847 , 4.252390306)}.
	self assertCollection: (ellipse intersectionsWith: line) hasSameElements: (ellipse intersectionsWithLine: line).
	
	"Test with tangent"
	ellipse := GEllipse center: 2 , 5 vertex: 2 , 9 coVertex: 5 , 5.
	line := GLine a: -1 b: 1 c: -8.
	self assert: (ellipse intersectionsWith: line) hasCloseElementsTo: {(-6 / 5 , (34 / 5))}
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	ellipse := GEllipse center: 1 , 3 vertex: 5 , 6 coVertex: 3 , 4.
	self assert: (ellipse intersectionsWith: point) isEmpty.

	ellipse := GEllipse center: 2 , 1 vertex: 5 , 1 coVertex: 2 , 4.
	self assert: (ellipse intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assertCollection: (ellipse intersectionsWith: point) hasSameElements: (ellipse intersectionsWithPoint: point)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithPolygon [
	| polygon |
	polygon := GPolygon vertices: {(5 , 1) . (9 , 1) . (8 , 0) . (6 , -1)}.
	ellipse := GEllipse center: 2,6 vertex: 7, 6 coVertex: 2,9 .
	self assert: (ellipse intersectionsWith: polygon) isEmpty.

	polygon := GPolygon vertices: {(1 , 4) . (6 , 4) . (6 , 1) . (3 , 2)}.
	self assert: (ellipse intersectionsWith: polygon) hasCloseElementsTo: {(2 , 3) . (5.7267799 , 4)}.
	self assertCollection: (ellipse intersectionsWith: polygon) hasSameElements: (ellipse intersectionsWithPolygon: polygon)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithRay [
	| ray |
	ray := GRay origin: 0 , -1 direction: 1 , 4.
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	self assert: (ellipse intersectionsWith: ray) isEmpty.

	ray := GRay origin: 2 , 3 direction: 0 , 1.
	self assert: (ellipse intersectionsWith: ray) hasCloseElementsTo: {(1 , 2)}.

	ray := GRay origin: 0 , 1 direction: 5 , 6.
	self assert: (ellipse intersectionsWith: ray) hasCloseElementsTo: {(1 , 2) . (2.951219 , 3.951219)}.
	self assertCollection: (ellipse intersectionsWith: ray) hasSameElements: (ellipse intersectionsWithRay: ray)
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithSegment [
	| segment |
	segment := GSegment with: 0 , -1 with: 1 , 4.
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	self assert: (ellipse intersectionsWith: segment) isEmpty.

	segment := GSegment with: 0 , 1 with: 2 , 3.
	self assert: (ellipse intersectionsWith: segment) hasCloseElementsTo: {(1 , 2)}.

	segment := GSegment with: 0 , 1 with: 5 , 6.
	self assert: (ellipse intersectionsWith: segment) hasCloseElementsTo: {(1 , 2) . (2.951219 , 3.951219)}.
	self assertCollection: (ellipse intersectionsWith: segment) hasSameElements: (ellipse intersectionsWithSegment: segment).
	
	segment := GSegment with: -3, 5 with: -3, 0.
	ellipse := GCircle center: 1, 0 radius: 3.
	self assert: (ellipse intersectionsWith: segment) isEmpty
]

{ #category : #tests }
GEllipseTest >> testIntersectionsWithVerticalLine [
	| line |
	ellipse := GEllipse center: 3.5 , 2 vertex: 6 , 2 coVertex: 3.5 , 4.
	line := GLine a: 1 b: 0 c: -2.
	self assert: (ellipse intersectionsWithVerticalLine: line) hasCloseElementsTo: {(2 , 0.3999999) . (2 , 3.6)}.
	self assertCollection: (ellipse intersectionsWithLine: line) hasSameElements: (ellipse intersectionsWithVerticalLine: line)
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
GEllipseTest >> testNonEmpty [
	| shape line intersections |
	shape := GEllipse center: 0@0 vertex: 0@10 coVertex: 5@10.
	line := GLine through: shape center and: 10@10.
	intersections := self sortedIntersectionsBetween: shape and: line.
	self assert: intersections isNotEmpty.
	self assert: (intersections first asPoint closeTo: -7.4535599249993@ -7.4535599249993).
	self assert: (intersections second asPoint closeTo: 7.4535599249993@ 7.4535599249993).
]

{ #category : #tests }
GEllipseTest >> testPerimeter [
	ellipse := GEllipse center: 2,6 vertex: 7, 6 coVertex: 2,9.
	self assert: ellipse perimeter =~ 25.32480
]

{ #category : #tests }
GEllipseTest >> testTranslateBy [
	ellipse := GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2.
	ellipse translateBy: {1 . 1} asGVector.
	self assert: ellipse center equals: 5 , 0.
	self assert: ellipse vertex equals: 10 , 0.
	self assert: ellipse coVertex equals: 5 , 3
]
