Class {
	#name : #GRectangleTest,
	#superclass : #TestCase,
	#instVars : [
		'rectangle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #running }
GRectangleTest >> setUp [
	super setUp.
	rectangle := 10 @ 10 geometryCorner: 20 @ 20
]

{ #category : #tests }
GRectangleTest >> testArea [
	self assert: (0 @ 0 geometryCorner: 5 @ 5) area equals: 25.
	self assert: (2 @ 3 geometryCorner: 10 @ 8) area equals: 40.
	self assert: (5 @ 5 geometryCorner: 6 @ 6) area equals: 1.
	self assert: (-1 @ -2 geometryCorner: 2 @ 1) area equals: 9
]

{ #category : #tests }
GRectangleTest >> testBottom [
	self assert: rectangle bottom equals: 20
]

{ #category : #tests }
GRectangleTest >> testBottomCenter [
	self assert: rectangle bottomCenter equals: 15@ 20
]

{ #category : #tests }
GRectangleTest >> testBottomLeft [
	self assert: rectangle bottomLeft equals: 10@ 20
]

{ #category : #tests }
GRectangleTest >> testBottomRight [
	self assert: rectangle bottomRight equals: 20@ 20
]

{ #category : #tests }
GRectangleTest >> testCenter [
	| c |
	rectangle := 0 @ 0 geometryExtent: 10 @ 20.
	c := rectangle center.
	self assert: (rectangle includesPoint: c) description: 'the center is inside the rectangle'.
	self assert: (rectangle topLeft distanceTo: c) equals: (rectangle bottomRight distanceTo: c).
	self assert: (rectangle bottomLeft distanceTo: c) equals: (rectangle topRight distanceTo: c).
	self assert: (rectangle topLeft distanceTo: c) equals: (rectangle bottomLeft distanceTo: c).
	self assert: (rectangle translateBy: -20 @ 10) center = (c translateBy: -20 @ 10) description: 'the center is translated with the rectangle'
]

{ #category : #tests }
GRectangleTest >> testCorners [
	self
		assertCollection: rectangle corners
		hasSameElements:
			{(10 @ 10).
			(10 @ 20).
			(20 @ 20).
			(20 @ 10)}
]

{ #category : #tests }
GRectangleTest >> testExtent [
	self assert: rectangle extent equals: 10 @ 10.
	rectangle := 10 @ 5 geometryExtent: 30 @ 45.
	self assert: rectangle extent equals: 30 @ 45.
	rectangle := 10 @ 5 geometryCorner: 40 @ 50.
	self assert: rectangle extent equals: 30 @ 45
]

{ #category : #tests }
GRectangleTest >> testHasOnBoundary [
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasOnBoundary: 1 @ 3).
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasOnBoundary: 2 @ 3).
	self deny: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasOnBoundary: 0 @ 0)
]

{ #category : #tests }
GRectangleTest >> testHasOnOneSideAnd [
	self assert: ((GRectangle origin: -22 @ -42 corner: 62 @ 42) hasOnOneSide: -9 @ 42 and: 30 @ 42).
	self assert: ((GRectangle origin: -22 @ -42 corner: 62 @ 42) hasOnOneSide: -22 @ 30 and: -22 @ -10).
	self deny: ((GRectangle origin: -22 @ -42 corner: 62 @ 42) hasOnOneSide: -9 @ 42 and: -22 @ -10)
]

{ #category : #tests }
GRectangleTest >> testHasPoint [
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasPoint: 1 @ 3).
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasPoint: 2 @ 1).
	self deny: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) hasPoint: 0 @ 0)
]

{ #category : #tests }
GRectangleTest >> testHeight [
	self assert: rectangle height equals: 10
]

{ #category : #tests }
GRectangleTest >> testIncludesPoint [
	self assert: (rectangle includesPoint: 11 @ 11).
	self assert: (rectangle includesPoint: 10 @ 10).
	self assert: (rectangle includesPoint: 20 @ 20).
	self deny: (rectangle includesPoint: 9 @ 9).
	self deny: (rectangle includesPoint: 21 @ 21).
	self deny: (rectangle includesPoint: 15 @ 21).
	self deny: (rectangle includesPoint: 9 @ 15)
]

{ #category : #tests }
GRectangleTest >> testIntersectionPointWithRay [
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) intersectionPointWithRay: (GRay origin: 2 @ 1 direction: 4 @ 1)) equals: {(3 @ 1)}
]

{ #category : #tests }
GRectangleTest >> testIntersectionPointsWith1 [
	self
		assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) intersectionPointsWithLine: (GSegment with: 0 @ 3 with: 4 @ 1) asLine) first
		equals: 1 @ 2.5.
	self
		assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) intersectionPointsWithLine: (GSegment with: 0 @ 3 with: 4 @ 1) asLine) second
		equals: 3 @ 1.5
]

{ #category : #tests }
GRectangleTest >> testIntersectionPointsWith2 [
	self
		assert:
			((GRectangle origin: -60 @ -80 corner: 80 @ 60)
				intersectionPointsWithLine: (GSegment with: 174.8683298050514 @ -174.86832980505142 with: -14.868329805051376 @ 14.868329805051385) asLine)
				first =~ (-60 @ 60).
	self
		assert:
			((GRectangle origin: -60 @ -80 corner: 80 @ 60)
				intersectionPointsWithLine: (GSegment with: 174.8683298050514 @ -174.86832980505142 with: -14.868329805051376 @ 14.868329805051385) asLine)
				second =~ (80 @ -80)
]

{ #category : #tests }
GRectangleTest >> testLeft [
	self assert: rectangle left equals: 10
]

{ #category : #tests }
GRectangleTest >> testRight [
	self assert: rectangle right equals: 20
]

{ #category : #tests }
GRectangleTest >> testRotateByCenterAt [
	rectangle := GRectangle
		left: 0
		right: 6
		top: 4
		bottom: 2.
	self assert: (rectangle rotateBy: #left centerAt: 0 @ 0) left equals: 2.
	self assert: (rectangle rotateBy: #left centerAt: 0 @ 0) right equals: 4.
	self assert: (rectangle rotateBy: #left centerAt: 0 @ 0) top equals: -6.
	self assert: (rectangle rotateBy: #left centerAt: 0 @ 0) bottom equals: 0.
	self assert: (rectangle rotateBy: #right centerAt: 0 @ 0) left equals: -4.
	self assert: (rectangle rotateBy: #right centerAt: 0 @ 0) right equals: -2.
	self assert: (rectangle rotateBy: #right centerAt: 0 @ 0) top equals: 0.
	self assert: (rectangle rotateBy: #right centerAt: 0 @ 0) bottom equals: 6.
	self assert: (rectangle rotateBy: #pi centerAt: 0 @ 0) left equals: -6.
	self assert: (rectangle rotateBy: #pi centerAt: 0 @ 0) right equals: 0.
	self assert: (rectangle rotateBy: #pi centerAt: 0 @ 0) top equals: -4.
	self assert: (rectangle rotateBy: #pi centerAt: 0 @ 0) bottom equals: -2
]

{ #category : #tests }
GRectangleTest >> testScaleBy [
	rectangle := 2 @ 2 geometryCorner: 6 @ 4.
	rectangle scaleBy: 2.
	self assert: rectangle left equals: 4.
	self assert: rectangle right equals: 12.
	self assert: rectangle top equals: 4.
	self assert: rectangle bottom equals: 8.
	
	rectangle := 2 @ 2 geometryCorner: 6 @ 4.
	rectangle scaleBy: 1 / 2.
	self assert: rectangle left equals: 1.
	self assert: rectangle right equals: 3.
	self assert: rectangle top equals: 1.
	self assert: rectangle bottom equals: 2.
	
	rectangle := 2 @ 2 geometryCorner: 6 @ 4.
	self should: [ rectangle scaleBy: 0 ] raise: GError
]

{ #category : #tests }
GRectangleTest >> testSideWhichHas [
	self assert: ((GRectangle origin: 1 @ 3 corner: 3 @ 0) sideWhichHas: 1 @ 2.5) equals: (GSegment with: 1 @ 3 with: 1 @ 0)
]

{ #category : #tests }
GRectangleTest >> testTop [
	self assert: rectangle top equals: 10
]

{ #category : #tests }
GRectangleTest >> testTopCenter [
	self assert: rectangle topCenter equals: 15@ 10
]

{ #category : #tests }
GRectangleTest >> testTopLeft [
	self assert: rectangle topLeft equals: 10@ 10
]

{ #category : #tests }
GRectangleTest >> testTopRight [
	self assert: rectangle topRight equals: 20@ 10
]

{ #category : #tests }
GRectangleTest >> testTranslateBy [
	rectangle := 2 @ 2 geometryCorner: 6 @ 4.
	rectangle translateBy: 2.
	self assert: rectangle left equals: 4.
	self assert: rectangle right equals: 8.
	self assert: rectangle top equals: 4.
	self assert: rectangle bottom equals: 6.

	rectangle := 2 @ 2 geometryCorner: 6 @ 4.
	rectangle translateBy: 2 negated.
	self assert: rectangle left equals: 0.
	self assert: rectangle right equals: 4.
	self assert: rectangle top equals: 0.
	self assert: rectangle bottom equals: 2
]

{ #category : #tests }
GRectangleTest >> testWidth [
	self assert: rectangle width equals: 10
]
