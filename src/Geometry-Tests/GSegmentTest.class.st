Class {
	#name : #GSegmentTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GSegmentTest >> testAlreadyExistIn [
	| segm aSet |
	segm := GSegment with: 0 , 0 with: 3 , 3.
	aSet := Set
		withAll:
			{(GSegment with: 5 , 2 with: 3 , 4).
			(GSegment with: 1 , 1 with: 4 , 8)}.
	self deny: (segm alreadyExistIn: aSet).

	aSet := Set
		withAll:
			{(GSegment with: 1 , 2 with: 3 , 4).
			(GSegment with: 1 , 1 with: 2 , 2)}.
	self assert: (segm alreadyExistIn: aSet)
]

{ #category : #tests }
GSegmentTest >> testAsLine [
	| line |
	line := (GSegment with: 1 , 3 with: 3 , 0) asLine.
	self assert: line a equals: 3.
	self assert: line b equals: 2.
	self assert: line c equals: -9.
	
	line := (GSegment with: -2 , 4 with: 2 , 4) asLine.
	self assert: line a equals: 0.
	self assert: line b equals: 1.
	self assert: line c equals: -4.
	
	line := (GSegment with: 1 , 3 with: 1 , 0) asLine.
	self assert: line a equals: 1.
	self assert: line b equals: 0.
	self assert: line c equals: -1
]

{ #category : #tests }
GSegmentTest >> testBelowPoint [
	self deny: ((GSegment with: -2 , 4 with: 2 , 4) belowPoint: -2 , 4).
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) belowPoint: 0 , 5).
	self deny: ((GSegment with: -2 , 4 with: 2 , 4) belowPoint: 0 , -5).
	self assert: ((GSegment with: -2 , 4 with: -2 , 0) belowPoint: 0 , 2).
	self deny: ((GSegment with: -2 , 4 with: -2 , 0) belowPoint: -4 , 2)
]

{ #category : #tests }
GSegmentTest >> testDistanceTo [
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) distanceTo: -2 , 4) equals: 0.
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) distanceTo: 2 , 4) equals: 0.
	self
		assert:
			((GSegment with: 477 / 11 , (149 / 2) with: -56.73661227723915 , 143.3189209406019) distanceTo: 36819 / 1022 , (82249 / 1022))
				=~ 0.7697676365059569.
	self
		assert:
			((GSegment with: 838 / 41 , (4811 / 82) with: 57583 / 914 , (56095 / 914)) distanceTo: 57.998905906959145 , 61.11074842728413)
				<=~ (2 * 0.02757564283371476)
		equals: true
]

{ #category : #tests }
GSegmentTest >> testEquals [
	| segm1 segm2 |
	self flag: #pharo6. "Use #deny:equals: when Pharo 7 will be the minimum requirement"
	segm1 := GSegment with: 1 , 2 with: 3 , 4.
	segm2 := GSegment with: 0 , 0 with: 3 , 3.
	self deny: segm1 asLine = segm2 asLine.
	
	segm1 := GSegment with: 1 , 1 with: 3 , 3.
	segm2 := GSegment with: 0 , 0 with: 3 , 3.
	self assert: segm1 asLine equals: segm2 asLine.
	
	segm1 := GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178.
	segm2 := GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795.
	self assert: segm1 asLine equals: segm2 asLine .
	
	segm1 := GSegment with: -24.494897427831784 , -24.494897427831795 with: 24.494897427831784 , 24.49489742783178.
	segm2 := GSegment with: 24.494897427831784 , 24.49489742783178 with: -24.494897427831784 , -24.494897427831795.
	self assert: segm1 equals: segm2.
	
	self assert: (GSegment with: -1 , -1 with: 1 , 1) equals: (GSegment with: 1 , 1 with: -1 , -1).
	self deny: (GSegment with: -1 , -1 with: 1 , 1) = (GSegment with: -1 , 1 with: -1 , 1).
]

{ #category : #tests }
GSegmentTest >> testExtendSegmVert [
	| segm1 segm2 segm3 frame |
	segm1 := GSegment with: -2 , 4 with: 2 , 4.
	segm2 := GSegment with: -2 , 2 with: -2 , 4.
	segm3 := GSegment with: -2 , 2 with: 2 , 4.
	frame := GRectangle origin: -5 , 0 corner: 5 , 5.
	self assert: (segm1 extendSegmVert: 2 , 4 to: frame) equals: (GSegment with: -2 , 4 with: 5 , 4).
	self assert: (segm1 extendSegmVert: -2 , 4 to: frame) equals: (GSegment with: -5 , 4 with: 2 , 4).
	self assert: (segm2 extendSegmVert: -2 , 2 to: frame) equals: (GSegment with: -2 , 0 with: -2 , 4).
	self assert: (segm2 extendSegmVert: -2 , 4 to: frame) equals: (GSegment with: -2 , 2 with: -2 , 5).
	self assert: (segm3 extendSegmVert: -2 , 2 to: frame) equals: (GSegment with: -5 , (1 / 2) with: 2 , 4).
	self assert: (segm3 extendSegmVert: 2 , 4 to: frame) equals: (GSegment with: -2 , 2 with: 4 , 5)
]

{ #category : #tests }
GSegmentTest >> testExtendWithAnd [
	| frame |
	frame := GRectangle origin: -5 , 0 corner: 5 , 5.
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) extendWith: 3 , 4 and: frame) equals: (GSegment with: -5 , 4 with: 3 , 4)
]

{ #category : #tests }
GSegmentTest >> testExtendWithAnd1 [
	| frame |
	frame := GRectangle origin: -5 , 0 corner: 5 , 5.
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) extendWith: 3 , 4 and: frame) equals: (GSegment with: 3 , 4 with: -5 , 4)
]

{ #category : #tests }
GSegmentTest >> testIncludesPoint [
	self assert: ((GSegment with: 1 , 3 with: 3 , 0) includesPoint: 1 , 3).
	self assert: ((GSegment with: 1 , 3 with: 3 , 0) includesPoint: 3 , 0).
	self assert: ((GSegment with: -1 , 1 with: 1 , -1) includesPoint: 0 , 0).
	self deny: ((GSegment with: 0 , 0 with: 12 , 9) includesPoint: 13 , (39 / 4)).
	self assert: ((GSegment with: 0 , 0 with: 13 , (39 / 4)) includesPoint: 12 , 9)
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithRay [
	self assert: ((GSegment with: 2 , 0 with: 2 , 3) intersectionsWithRay: (GRay origin: 0 , 0 direction: 3 , 2)) anyOne equals: 2 , (4 / 3).
	self assert: ((GSegment with: 2 , 0 with: 2 , 3) intersectionsWithRay: (GRay origin: 0 , 0 direction: 1 , 1)) anyOne equals: 2 , 2.
	self assert: ((GSegment with: 2 , 0 with: 2 , 3) intersectionsWith: (GRay origin: 0 , 0 direction: 1 , 1)) anyOne equals: 2 , 2.
	self assert: ((GSegment with: -2 , 0 with: -2 , 3) intersectionsWithRay: (GRay origin: 0 , 0 direction: 1 , 1)) isEmpty.
	self assert: ((GSegment with: 0 , 0 with: 0 , 3) intersectionsWithRay: (GRay origin: 0 , 0 direction: 1 , 1)) anyOne equals: 0 , 0
]

{ #category : #tests }
GSegmentTest >> testIntersectionsWithSegment [
	self assert: ((GSegment with: -1 , -1 with: 1 , 1) intersectionsWithSegment: (GSegment with: -3 , 3 with: -1 , 1)) isEmpty.
	self assertCollection: ((GSegment with: -1 , -1 with: 1 , 1) intersectionsWithSegment: (GSegment with: -3 , 3 with: 2 , -2)) hasSameElements: {(0 , 0)}.
	self assertCollection: ((GSegment with: 0 , 1 with: 3 , 1) intersectionsWithSegment: (GSegment with: 0 , 3 with: 4 , -1)) hasSameElements: {(2 , 1)}.
	self assertCollection: ((GSegment with: 0 , 1 with: 3 , 1) intersectionsWith: (GSegment with: 0 , 3 with: 4 , -1)) hasSameElements: {(2 , 1)}.
]

{ #category : #tests }
GSegmentTest >> testIsOnLinePointWithRespectWith [
	self skip.	"The test was commented, I prefer to use skip."
	self
		deny:
			((GSegment with: 18427 / 974 , (57187 / 974) with: 362.2460738148583 , -421.94450334080176)
				hasOnLinePoint: 838 / 41 , (4811 / 82)
				withRespectTo: 18427 / 974 , (57187 / 974)
				withApprox: 0.8902246907382428)
]

{ #category : #tests }
GSegmentTest >> testIsOnLineWith [
	self assert: ((GSegment with: -2 , 4 with: 2 , 4) isOnLineWith: (GSegment with: -2 , 4 with: 2 , 4)).
	self assert: ((GSegment with: -4 , 4 with: 4 , 4) isOnLineWith: (GSegment with: -2 , 4 with: 2 , 4)).
	self deny: ((GSegment with: -2 , 3 with: 2 , 4) isOnLineWith: (GSegment with: -2 , 4 with: 2 , 4)).
	self deny: ((GSegment with: -2 , 4 with: 2 , 4) isOnLineWith: (GSegment with: -2 , 2 with: 2 , 2))
]

{ #category : #tests }
GSegmentTest >> testLength [
	self assert: (GSegment with: 0 , 0 with: 3 , 4) length equals: 5.
	self assert: (GSegment with: -2 , 1 with: 3 , 4) length equals: 34 sqrt
]

{ #category : #tests }
GSegmentTest >> testMidPoint [
	self assert: (GSegment with: -1 , 2 with: 2 , 1) midPoint equals: 0.5 , 1.5.
	self assert: (GSegment with: 2 , 1 with: 2 , 1) midPoint equals: 2 , 1
]

{ #category : #tests }
GSegmentTest >> testPerpendicularBisector [
	| line |
	self assert: (GSegment with: -1 , 2 with: 0 , 0) perpendicularBisector a equals: 1.
	
	line := (GSegment with: 1 , 3 with: -1 , 1) perpendicularBisector.
	self assert: line a equals: -2.
	self assert: line b equals: -2.
	self assert: line c equals: 4.
	
	self assert: (GSegment with: -1 , 2 with: 0 , 0) perpendicularBisector b equals: -2.

	line := (GSegment with: 3 , 0 with: 1 , 3) perpendicularBisector.
	self assert: line a equals: -2.
	self assert: line b equals: 3.
	self assert: line c equals: -1 / 2
]

{ #category : #tests }
GSegmentTest >> testSegmentFromPoints [
	self assert: (1 , 2 segment: 2 , 3) equals: (GSegment with: 1 , 2 with: 2 , 3)
]
