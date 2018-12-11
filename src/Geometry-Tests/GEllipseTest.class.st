Class {
	#name : #GEllipseTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GEllipseTest >> testEncompassingRectangle [
	self assert: (GEllipse center: 2 @ 2 xRadius: 3 yRadius: 2) encompassingRectangle equals: (-1 @ 0 corner: 5 @ 4)
]

{ #category : #tests }
GEllipseTest >> testEquals [
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) equals: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10).
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) hash equals: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) hash
]

{ #category : #tests }
GEllipseTest >> testFitInExtent [
	| ellipse |
	ellipse :=  (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10).
	ellipse fitInExtent: 100@100.
	self assert: ellipse center equals: 10 @ 10.
	self assert: ellipse xRadius equals: 25.
	self assert: ellipse yRadius equals: 50.
	
	ellipse :=  (GEllipse center: 10 @ 10 xRadius: 10 yRadius: 5).
	ellipse fitInExtent: 100@100.
	self assert: ellipse center equals: 10 @ 10.
	self assert: ellipse xRadius equals: 50.
	self assert: ellipse yRadius equals: 25.
]

{ #category : #tests }
GEllipseTest >> testHeight [
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) width equals: 10.
	self assert: (GEllipse center: 10 @ 10 xRadius: 10 yRadius: 20) width equals: 20
]

{ #category : #tests }
GEllipseTest >> testIncludesPoint [
	| ellipse |
	ellipse := GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10.
	self assert: (ellipse includesPoint: 14 @ 16).
	self deny: (ellipse includesPoint: 16 @ 21).
	self deny: (ellipse includesPoint: 14 @ 19)
]

{ #category : #tests }
GEllipseTest >> testMajorRadius [
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) majorRadius equals: 10.
	self assert: (GEllipse center: 10 @ 10 xRadius: 10 yRadius: 5) majorRadius equals: 10
]

{ #category : #tests }
GEllipseTest >> testMinorRadius [
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) minorRadius equals: 5.
	self assert: (GEllipse center: 10 @ 10 xRadius: 10 yRadius: 5) minorRadius equals: 5
]

{ #category : #tests }
GEllipseTest >> testTranslateBy [
	| ellipse |
	ellipse :=  (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10).
	ellipse translateBy: 10@10.
	self assert: ellipse center equals: 20 @ 20.
	self assert: ellipse xRadius equals: 5.
	self assert: ellipse yRadius equals: 10.
	
	ellipse translateBy: 4@9.
	self assert: ellipse center equals: 24 @ 29.
	self assert: ellipse xRadius equals: 5.
	self assert: ellipse yRadius equals: 10
]

{ #category : #tests }
GEllipseTest >> testWidth [
	self assert: (GEllipse center: 10 @ 10 xRadius: 5 yRadius: 10) width equals: 10.
	self assert: (GEllipse center: 10 @ 10 xRadius: 10 yRadius: 20) width equals: 20
]
