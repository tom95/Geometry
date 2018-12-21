Class {
	#name : #GCircleTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GCircleTest >> testBoundaryContains [
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 5 , 57).
	self assert: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 74 , 77).
	self assert: ((GCircle center: 2 , 2 radius: 3) boundaryContains: 5 , 2).
	self deny: ((GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) boundaryContains: 74 , 72)
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsAny [
	self assert: ((GCircle center: 2 , 2 radius: 3) boundaryContainsAny: {(2 , 2) . (5 , 2)})
]

{ #category : #tests }
GCircleTest >> testBoundaryContainsWhichOf [
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
GCircleTest >> testIncludesPoint [
	self assert: ((GCircle center: 2 , 2 radius: 3) includesPoint: 2 , 2).
	self deny: ((GCircle center: 2 , 2 radius: 3) includesPoint: 6 , 2).
	self assert: ((GCircle center: 30 , 30 radius: 20) includesPoint: 50 , 30).
	self assert: ((GCircle center: 30 , 30 radius: 20) includesPoint: 10 , 30).
	self assert: ((GCircle center: 30 , 30 radius: 20) includesPoint: 30 , 10).
	self assert: ((GCircle center: 30 , 30 radius: 20) includesPoint: 30 , 30).
	self assert: ((GCircle center: 0 , 0 radius: 31.62277660168381) includesPoint: -30 , -10).
	self assert: ((GCircle center: 0 , 0 radius: 31.62277660168381) includesPoint: 10 , -30).
	self assert: ((GCircle center: 0 , 0 radius: 31.62277660168381) includesPoint: 30 , 10).
	self deny: ((GCircle center: 0 , 0 radius: 31.62277660168381) includesPoint: 30 , 30).
	self deny: ((GCircle center: 0 , 0 radius: 31.61277660168381) includesPoint: 30 , 10).
	self assert: ((GCircle center: 0 , 0 radius: 31.62277660168381) includesPoint: 10 , 10)
]

{ #category : #tests }
GCircleTest >> testPerimeter [
	self assert: (GCircle center: (609 / 17) , (10837 / 136) radius: 38.27069133568686) perimeter equals: 240.46184549599278
]

{ #category : #tests }
GCircleTest >> testPolygonOn [
	self assert: (((GCircle center: 1 , 1 radius: 3) polygonOn: {(-20 , 10) . (40 , 10) . (10 , -20)}) at: 1) v1 equals: -20 , 10
]

{ #category : #tests }
GCircleTest >> testUpperPoint [
	self assert: (GCircle center: 1 , 1 radius: 3) upperPoint equals: 1 , 4
]
