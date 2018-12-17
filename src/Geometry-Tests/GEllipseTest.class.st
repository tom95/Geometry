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
	self deny: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) equals: (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10).
	self deny: (GEllipse center: 10 , 10 vertex: 7 , 10 coVertex: 12 , 10) hash equals: (GEllipse center: 10 , 10 vertex: 7 , 11 coVertex: 12 , 10) hash
]

{ #category : #tests }
GEllipseTest >> testFitInExtent [
	| ellipse |
	self shouldBeImplemented.
	"ellipse :=  (GOldEllipse center: 10 @ 10 xRadius: 5 yRadius: 10).
	ellipse fitInExtent: 100@100.
	self assert: ellipse center equals: 10 @ 10.
	self assert: ellipse xRadius equals: 25.
	self assert: ellipse yRadius equals: 50.
	
	ellipse :=  (GOldEllipse center: 10 @ 10 xRadius: 10 yRadius: 5).
	ellipse fitInExtent: 100@100.
	self assert: ellipse center equals: 10 @ 10.
	self assert: ellipse xRadius equals: 50.
	self assert: ellipse yRadius equals: 25."
]

{ #category : #tests }
GEllipseTest >> testFoci [
	self assertCollection: (GEllipse center: 10 , 10 vertex: 7.1715 , 10 coVertex: 10 , 8) foci hasSameElements: {(12 , 10) . (8 , 10)}
]

{ #category : #tests }
GEllipseTest >> testFociLocation [
	self assert: (GEllipse center: 4 , -1 vertex: 9 , -1 coVertex: 4 , 2) fociLocation equals: 4
]

{ #category : #tests }
GEllipseTest >> testIncludesPoint [
	self shouldBeImplemented
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
