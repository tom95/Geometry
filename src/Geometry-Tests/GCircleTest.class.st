Class {
	#name : #GCircleTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GCircleTest >> testBoundaryContains [
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 5 , 57).
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 74 , 77).
	"self assert: ((GCircle  center: (609/17),(10837/136) radius: 38.27069133568686) boundaryContains: ((74,72)))"
	self assert: ((GCircle center: 2 , 2 radius: 3) boundaryContains: 5 , 2).
	self deny: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 74 , 72)
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsThis [
	self assert: ((GCircle center: 2 , 2 radius: 3) boundaryContainsThis: {(2 , 2) . (5 , 2)})
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsWhich [
	self assert: ((GCircle center: 2 , 2 radius: 3) boundaryContainsWhichOf: {(2 , 2) . (5 , 2)}) equals: {(5 , 2)}
]

{ #category : #tests }
GCircleTest >> testContains [
	self assert: ((GCircle center: 2 , 2 radius: 3) contains: 2 , 2).
	self deny: ((GCircle center: 2 , 2 radius: 3) contains: 6 , 2).
	self deny: ((GCircle center: 30 , 30 radius: 20) contains: 50 , 30).
	self deny: ((GCircle center: 30 , 30 radius: 20) contains: 10 , 30).
	self deny: ((GCircle center: 30 , 30 radius: 20) contains: 30 , 10).
	self assert: ((GCircle center: 30 , 30 radius: 20) contains: 30 , 30).
	self deny: ((GCircle center: 0 , 0 radius: 31.62277660168381) contains: -30 , -10).
	self deny: ((GCircle center: 0 , 0 radius: 31.62277660168381) contains: 10 , -30).
	self deny: ((GCircle center: 0 , 0 radius: 31.62277660168381) contains: 30 , 10).
	self deny: ((GCircle center: 0 , 0 radius: 31.62277660168381) contains: 30 , 30).
	self assert: ((GCircle center: 0 , 0 radius: 31.62277660168381) contains: 10 , 10)
]

{ #category : #tests }
GCircleTest >> testCosBetweenAnd [
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) cosBetween: 74 , 72 and: 74 , 74) equals: 0.9987089260705257.
	self assert: ((GCircle center: 0 , 0 radius: 15) cosBetween: 15 , 0 and: 0 , 15) equals: 0.
	self assert: ((GCircle center: 0 , 0 radius: 15) cosBetween: 15 , 0 and: 15 , 0) equals: 1
]

{ #category : #tests }
GCircleTest >> testEncompassingRectangle [
	self assert: (GCircle center: 2 , 2 radius: 3) encompassingRectangle equals: (-1 , -1 corner: 5 , 5)
]

{ #category : #tests }
GCircleTest >> testEquals [
	self assert: (GCircle center: 1 , 1 radius: 3) equals: (GCircle center: 1 , 1 radius: 3).
	self deny: (GCircle center: 1 , 1 radius: 3) = (GCircle center: 1.002 , 1.009 radius: 3).
	self assert: (GCircle center: 1 , 1 radius: 3) equals: (GCircle center: 1 , 1 radius: 2.999999999).
	self assert: (GCircle center: 1 , 1 radius: 3) equals: (GCircle center: 1.00000001 , 0.9999991 radius: 2.999999999).
	self deny: (GCircle center: 1 , 1 radius: 3) = (GCircle center: 1 , 1 radius: 34).
	self deny: (GCircle center: 1.4 , 1 radius: 3) = (GCircle center: 1 , 1 radius: 34)
]

{ #category : #tests }
GCircleTest >> testEqualsWithApproximation [
	| cos |
	cos := (GCircle center: 609 / 17 , (10837 / 136) radius: 38.27069133568686) cosBetween: 74 , 72 and: 74 , 74.
	self
		assert:
			((GCircle center: 609 / 17 , (10837 / 136) radius: 38.27069133568686)
				equal: (GCircle center: 36819 / 1022 , (82249 / 1022) radius: 38.90857726043159)
				withApproximation: cos).
	cos := (GCircle center: 609 / 17 , (10837 / 136) radius: 38.27069133568686) cosBetween: 52 , 45 and: 74 , 74.
	self
		deny:
			((GCircle center: 609 / 17 , (10837 / 136) radius: 38.27069133568686)
				equal: (GCircle center: 36819 / 1022 , (82249 / 1022) radius: 38.90857726043159)
				withApproximation: cos)
]

{ #category : #tests }
GCircleTest >> testLength [
	self assert: (GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) length equals: 240.46184549599278
]

{ #category : #tests }
GCircleTest >> testPointIsTooCloseTo [
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) point: 74 , 72 isTooCloseTo: 74 , 74).
	self deny: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) point: 74 , 72 isTooCloseTo: 52 , 45)
]

{ #category : #tests }
GCircleTest >> testPolygonOn [
	self assert: (((GCircle center: 1 , 1 radius: 3) polygonOn: {(-20 , 10) . (40 , 10) . (10 , -20)}) at: 1) v1 equals: -20 , 10
]

{ #category : #tests }
GCircleTest >> testUpperPoint [
	self assert: (GCircle center: 1 , 1 radius: 3) upperPoint equals: 1 , 4
]

{ #category : #tests }
GCircleTest >> testWithBoundaryContains [
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) with: 74 , 77 boundaryContains: 74 , 72).
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) with: 5 , 57 boundaryContains: 74 , 77).
	self deny: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) with: 5 , 57 boundaryContains: 74 , 74)
	
	"self deny: ((GCircle  center: (609/17),(10837/136) radius: 38.27069133568686)  with: (74,77) boundaryContains1:(74,72))"
]
