Class {
	#name : #GLineTest,
	#superclass : #GTestCase,
	#instVars : [
		'line'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GLineTest >> testDistanceTo [
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 7 , 0) equals: 0.
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 7 , 7) equals: 0.
	self assert: ((GLine a: 1 b: 0 c: -7) distanceTo: 0 , 0) equals: 7
]

{ #category : #tests }
GLineTest >> testEquals [
	self assert: (GLine a: 1 b: 1 c: -13) equals: (GLine a: 6 b: 6 c: -78).
	self assert: (GLine a: 0 b: 1 c: -13) equals: (GLine a: 0 b: 6 c: -78).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 1 b: 6 c: -78).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 6 b: 6 c: -7).
	self assert: (GLine a: 1 b: 0 c: -13) equals: (GLine a: 6 b: 0 c: -78).
	self assert: (GLine a: 0 b: 1 c: 0) equals: (GLine a: 0 b: 6 c: 0).
	self assert: (GLine a: 1 b: 0 c: 0) equals: (GLine a: 1 b: 0 c: 0).
	self deny: (GLine a: 1 b: 1 c: -13) = (GLine a: 6 b: 6 c: 0).
	self assert: (GLine a: 0 b: 1 c: -13) equals: (GLine a: 0 b: 6 c: -78).
	self assert: (GLine a: -48.989794855663575 b: 48.98979485566357 c: 4.547473508864641e-13) equals: (GLine a: -138.58803762173304 b: 138.58803762173304 c: 1.8189894035458565e-12).
	self
		assert: (GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178) asLine
		equals: (GSegment with: -99.30232333601874 , -99.30232333601876 with: 39.285714285714285 , 39.28571428571428) asLine.
	self
		assert: (GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178) asLine
		equals: (GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795) asLine
]

{ #category : #tests }
GLineTest >> testIncludesPoint [
	self deny: ((GSegment with: 17674 / 229 , (14582 / 229) with: 76.82622578909061 , 64.97050543967634) asLine includesPoint: -28206 / 397 , (50382 / 397)).
	self assert: ((GLine through: 1 , 3 and: 3 , 0) includesPoint: 1 , 3).
	self assert: ((GLine through: 1 , 3 and: 3 , 0) includesPoint: 3 , 0).
	self assert: ((GLine through: -1 , 1 and: 1 , -1) includesPoint: 0 , 0).
	self assert: ((GLine through: 0 , 0 and: 12 , 9) includesPoint: 13 , (39 / 4)).
	self assert: ((GLine through: 0 , 0 and: 13 , (39 / 4)) includesPoint: 12 , 9).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includesPoint: 1 , 2).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includesPoint: 1 , 1.01).
	self deny: ((GLine through: 0 , 0 and: 1 , 1) includesPoint: 2 , 2.001)
]

{ #category : #tests }
GLineTest >> testIntersectionsWithLine [
	self assert: ((GLine a: 2 b: -3 c: 0.5) intersectionsWithLine: (GLine a: 1 b: 1 c: -2)) hasCloseElementsTo: {(1.1 , 0.9)}.
	self assert: ((GLine a: 2 b: -3 c: 0.5) intersectionsWithLine: (GLine a: -2 b: -2 c: 4)) hasCloseElementsTo: {(1.1 , 0.9)}.
	self assert: ((GLine through: 0 , 0 and: 1 , 1) intersectionsWithLine: (GLine through: 3 , 3 and: 5 , 5)) isEmpty
]

{ #category : #tests }
GLineTest >> testIntersectionsWithPoint [
	| point |
	point := 2 , 4.
	line := GLine through: 5 , 6 and: 7 , 102.
	self assert: (line intersectionsWith: point) isEmpty.

	line := GLine through: 1 , 3 and: 3 , 5.
	self assert: (line intersectionsWith: point) hasCloseElementsTo: {(2 , 4)}.
	self assert: (line intersectionsWith: point) equals: (line intersectionsWithPoint: point)
]

{ #category : #tests }
GLineTest >> testParallelTo [
	self deny: ((GLine a: 0 b: -3 c: 0.5) parallelTo: (GLine a: -2 b: 0 c: 4)).
	self deny: ((GLine a: 0 b: -3 c: 0.5) parallelTo: (GLine a: -2 b: 1 c: 4)).
	self assert: ((GLine a: 1 b: 2 c: 0.5) parallelTo: (GLine a: 2 b: 4 c: 4)).
	self assert: ((GLine a: 0 b: 2 c: 0.5) parallelTo: (GLine a: 0 b: 2 c: 0.5))
]

{ #category : #tests }
GLineTest >> testThroughAndHasPoint [
	self assert: ((GLine through: 1 , 1 and: 3 , 3) through: 1 , 1 and: 3 , 3 hasPoint: 2 , 2).
	self assert: ((GLine through: 1 , 1 and: 2 , 2) through: 1 , 1 and: 2 , 2 hasPoint: 3 , 3).
	self deny: ((GLine through: 1 , 1 and: 2 , 2) through: 1 , 1 and: 2 , 2 hasPoint: 2 , 1)
]
