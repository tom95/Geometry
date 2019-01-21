Class {
	#name : #GTriangleTest,
	#superclass : #GTestCase,
	#instVars : [
		'triangle'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GTriangleTest >> actualClass [
	^ GTriangle
]

{ #category : #tests }
GTriangleTest >> testArea [
	self assert: ((GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2) area closeTo: 2)
]

{ #category : #tests }
GTriangleTest >> testCircumscribedCircle [
	| circle |
	circle := (GTriangle with: -1 , 2 with: 0 , 0 with: 2 , 1) circumscribedCircle.
	self assert: circle center equals: 0.5 , 1.5.
	self assert: (circle radius closeTo: 10 sqrt / 2).

	circle := (GTriangle with: -1 , 1 with: 3 , 0 with: 1 , 3) circumscribedCircle.
	self assert: circle center equals: (11 / 10) , (9 / 10).
	self assert: (circle radius closeTo: (1 + (21 * 21)) sqrt / 10).
	
	circle := (GTriangle with: -1 , 1 with: 2 , 3 with: 5 , -3) circumscribedCircle.
	self assert: circle center equals: (9 / 4) , (-5 / 8).
	self assert: (circle radius closeTo: 5 sqrt * 13 / 8).
	
	circle := (GTriangle with: 2 , 3 with: 7 , 4 with: 5 , 7) circumscribedCircle.
	self assert: circle center equals: (147 / 34) , (149 / 34)
]

{ #category : #tests }
GTriangleTest >> testEquals [
	triangle := GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2.
	self assert: triangle equals: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2).
	self assert: triangle hash equals: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2) hash.
	self deny: triangle = (GTriangle with: 1 , 0 with: 2 , 0 with: 0 , 2).
	self deny: triangle hash = (GTriangle with: 1 , 0 with: 2 , 0 with: 0 , 2) hash
]

{ #category : #tests }
GTriangleTest >> testIsDegenerate [
	self assert: (GTriangle with: 0 , 0 with: 2 , 0 with: 3 , 0) isDegenerate.
	self deny: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 3) isDegenerate.
	self assert: (GTriangle with: 1 , 0 with: 1 , 2 with: 1 , -1) isDegenerate.
	self assert: (GTriangle with: 1 , 1 with: 3 , 3 with: 2 , 2) isDegenerate.
	self assert: (GTriangle with: 1 , 1 with: 2 , 2 with: 3 , 3) isDegenerate.
	self deny: (GTriangle with: 1 , 1 with: 2 , 2 with: 2 , 1) isDegenerate.
	self assert: (GTriangle with: 1.9357176033002985e-6 , 212.13203242024665 with: 1.1175870793405243e-6 , 122.47448602157178 with: 1.5805068047363063e-6 , 173.2050791763809) isDegenerate.
	self deny: (GTriangle with: 1.9357176033002985e-6 , 212.13203242024665 with: -2.7375180875116245e-6 , 299.9999972624819 with: 1.5805068047363063e-6 , 173.2050791763809) isDegenerate.
	self deny: (GTriangle with: 1.9357176033002985e-6 , 212.13203242024665 with: -2.7375180875116245e-6 , 299.9999972624819 with: 1.1175870793405243e-6 , 122.47448602157178) isDegenerate.
	self assert: (GTriangle with: -10 , -30 with: -30 , -10 with: -10 , -30) isDegenerate
]

{ #category : #tests }
GTriangleTest >> testPerimeter [
	self assert: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2) perimeter equals: 4 + 8 sqrt
]

{ #category : #tests }
GTriangleTest >> testSemiperimeter [
	self assert: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2) semiperimeter equals: 2 + 2 sqrt
]
