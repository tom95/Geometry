Class {
	#name : #GPolygonTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GPolygonTest >> testConvexHullOn [
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) vertices
		equals:
			{(-10 @ 0).
			(0 @ -20).
			(30 @ -30).
			(40 @ -20).
			(40 @ 0).
			(0 @ 10)} asOrderedCollection
]

{ #category : #tests }
GPolygonTest >> testConvexHullOn1 [
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(0 @ 0).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) vertices
		equals:
			{(-10 @ 0).
			(0 @ -20).
			(30 @ -30).
			(40 @ -20).
			(40 @ 0).
			(0 @ 10)} asOrderedCollection
]

{ #category : #tests }
GPolygonTest >> testEdges [
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) edges first
		equals: (GSegment with: -10 @ 0 with: 0 @ -20).
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) edges second
		equals: (GSegment with: 0 @ -20 with: 30 @ -30).
	self
		assert:
			(GPolygon
				convexHullOn:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) edges last
		equals: (GSegment with: -10 @ 0 with: 0 @ 10)
]

{ #category : #tests }
GPolygonTest >> testEncompasingRectangle [
	self
		assert:
			(GPolygon
				newVertices:
					{(0 @ -20).
					(0 @ 10).
					(30 @ -30).
					(40 @ 0).
					(-10 @ 0).
					(40 @ -20)}) encompassingRectangle
		equals:
			(Rectangle
				left: -10
				right: 40
				top: 10
				bottom: -30)
]

{ #category : #tests }
GPolygonTest >> testFitInExtent [
	| polygon |
	polygon := GPolygon
		newVertices:
			{(10 @ 10).
			(-10 @ 10).
			(-10 @ -10)}.
	polygon fitInExtent: 20 @ 20.
	self
		assert: polygon vertices
		equals:
			{(10 @ 10).
			(-10 @ 10).
			(-10 @ -10)}.
	polygon fitInExtent: 40 @ 40.
	self
		assert: polygon vertices
		equals:
			{(20 @ 20).
			(-20 @ 20).
			(-20 @ -20)}.
	polygon fitInExtent: 10 @ 10.
	self
		assert: polygon vertices
		equals:
			{(5 @ 5).
			(-5 @ 5).
			(-5 @ -5)}
]

{ #category : #tests }
GPolygonTest >> testFitInExtentNonProportionnal [
	| polygon |
	polygon := GPolygon
		newVertices:
			{(10 @ 4).
			(-4 @ 10).
			(-10 @ -8)}.
	polygon fitInExtent: 20 @ 20.
	self
		assert: polygon vertices
		equals:
			{(10 @ 4).
			(-4 @ 10).
			(-10 @ -8)}.
	polygon fitInExtent: 40 @ 40.
	self
		assert: polygon vertices
		equals:
			{(20 @ 8).
			(-8 @ 20).
			(-20 @ -16)}.
	polygon fitInExtent: 10 @ 10.
	self
		assert: polygon vertices
		equals:
			{(5 @ 2).
			(-2 @ 5).
			(-5 @ -4)}
]

{ #category : #tests }
GPolygonTest >> testIncludesPoint [
	self
		assert:
			((GPolygon
				newVertices:
					{(10 @ 10).
					(-10 @ 10).
					(-10 @ -10)}) includesPoint: -5 @ 5)
]

{ #category : #tests }
GPolygonTest >> testTranslateBy [
	| polygon |
	polygon := GPolygon
		newVertices:
			{(10 @ 10).
			(-10 @ 10).
			(-10 @ -10)}.
	polygon translateBy: 10 @ 10.
	self
		assert: polygon vertices
		equals:
			{(20 @ 20).
			(0 @ 20).
			(0 @ 0)}
]
