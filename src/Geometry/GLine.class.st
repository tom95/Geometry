"
A GLine has 3 instance variables, which are koeficients  of line:
ax+by+c=0


"
Class {
	#name : #GLine,
	#superclass : #GElement,
	#instVars : [
		'a',
		'b',
		'c'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'as yet unclassified' }
GLine class >> a: aNumber1 b: aNumber2 c: aNumber3 [
	^ self new initializeWithA: aNumber1 b: aNumber2 c: aNumber3
]

{ #category : #'as yet unclassified' }
GLine class >> through: aPoint1 and: aPoint2 [
	| ai bi ci |
	aPoint1 y = aPoint2 y ifTrue: [ ^ GLine a: 0 b: 1 c: aPoint1 y negated ].
	aPoint1 x = aPoint2 x ifTrue: [ ^ GLine a: 1 b: 0 c: aPoint1 x negated ].
	
	ai := aPoint1 y - aPoint2 y.
	bi := aPoint2 x - aPoint1 x.
	ci := (aPoint1 x - aPoint2 x) * aPoint1 y + ((aPoint2 y - aPoint1 y) * aPoint1 x).
	^ self a: ai b: bi c: ci
]

{ #category : #comparing }
GLine >> = line [ 
^( self a asFloat =~ line a asFloat and: [ self b asFloat =~ line b asFloat and: [ self c asFloat =~ line c asFloat ] ] )  
or:
[ ( line a ~=~ 0 and: [ line b ~=~ 0 and: [ line c ~=~ 0 ] ] ) 
	ifTrue: [ ( self a / line a ) asFloat =~ ( self b / line b ) asFloat and: [ ( self b / line b ) asFloat =~ ( self c / line c ) asFloat] ]
	ifFalse:[ ( self a ~=~ 0 and: [self b ~=~ 0 and: [ self c ~=~ 0 ]]) 
		ifTrue: [ ( line a / self a ) asFloat =~ ( line b / self b) asFloat and: [ ( line b / self b ) asFloat =~ ( line c / self c ) asFloat ] ]
		ifFalse:[ ( line a ~=~ 0 and: [ line c ~=~ 0 ] )
			ifTrue:[ ( self a / line a ) asFloat =~ ( self c / line c ) asFloat]
			ifFalse:[ ( line b ~=~ 0 and:[ line c ~=~ 0] )
				ifTrue:[ ( self b / line b ) asFloat =~ ( self c / line c ) asFloat ] 
				ifFalse:[ ( line a ~=~ 0 and:[ line b ~=~ 0] )
					ifTrue:[ ( self a / line a ) asFloat =~ ( self b / line b ) asFloat ] 
					ifFalse:[ ( line a =~ 0 and: [ line c =~ 0 ] ) or: [ ( line b =~ 0 and: [ line c =~ 0 ] ) ]
					]
				] 
			]]]
	]

]

{ #category : #accessing }
GLine >> a [
	^a

]

{ #category : #converting }
GLine >> asLine [
	^ self 
]

{ #category : #accessing }
GLine >> b [
	^b

]

{ #category : #accessing }
GLine >> c [
	^c

]

{ #category : #properties }
GLine >> cutWith: frame [
| coll |
coll := OrderedCollection new.
frame edges
	collect: [ :edge | edge intersectionPointWithLine: self ]
	thenDo: [ :p |
		(p notNil and: [ coll noneSatisfy: [ :p2 | p2 =~ p ] ])
			ifTrue: [ coll add: p ] ] .
coll isEmpty
	ifTrue:  [ ^ nil ]
	ifFalse: [ ^ GSegment with: coll first with: coll second ]
					

]

{ #category : #accessing }
GLine >> determinantWith: aLine [
	"I return the determinant between two line.
	
	First line: ax + by + c = 0
	Second line: px + qy + c = 0
	
	Determinant: a*q - p*b
	"
	
	^ a * aLine b - (aLine a * b)
]

{ #category : #'distance functions' }
GLine >> dist: p [
	^ ( ( a * p x ) + ( b * p y ) + c )abs
	/
	( ( a * a + ( b * b ) ) sqrt)

]

{ #category : #properties }
GLine >> hasPoint: aPoint [

	^ a * aPoint x + (b * aPoint y) + c =~ 0
]

{ #category : #properties }
GLine >> hasPoint: aPoint withApproximation: approx [
	(self a * aPoint x) + (self b * aPoint y) + self c - (((self a * approx) + (self b * approx))abs + self c)  <=~ 0.
	^ "(self a * aPoint x) + (self b * aPoint y) + self c <=~ (2 * approx)"
	(self dist: aPoint) <=~ (2 * approx)
	
]

{ #category : #comparing }
GLine >> hash [
^( a hash  + b hash + c hash ) hashMultiply

]

{ #category : #initialization }
GLine >> initializeWithA: aNumber1 b: aNumber2 c: aNumber3 [
	super initialize.
	a := aNumber1.
	b := aNumber2.
	c := aNumber3.
]

{ #category : #'rectangle functions' }
GLine >> intersect: aGLine [
	"ax + by = c and px + qy = r"

	| p q r xi yi determinant |
	determinant := self determinantWith: aGLine.
	determinant = 0 ifTrue: [ ^ nil	"Line are parallel if determinant = 0" ].
	p := aGLine a.
	q := aGLine b.
	r := aGLine c.
	
	xi := (c negated * q - (r negated * b)) / determinant.
	yi := (a * r negated - (p * c negated)) / determinant.
	^ xi , yi
]

{ #category : #comparing }
GLine >> intersectPolygon: aGPolygon [
	^ aGPolygon intersectLine: self
]

{ #category : #properties }
GLine >> parallelTo: aLine [
	"If the determinant it 0 then the lines are parallel"

	^ (self determinantWith: aLine) = 0
]

{ #category : #properties }
GLine >> pointsWithDist1: aNumber to: aPoint [
	| deltaX delta |
	
	"(self hasPoint: aPoint) ifFalse: [
		Error signal: 'This line does not contain ', aPoint asString ]."

	b = 0 ifTrue: [
		^ { aPoint + (0 @ aNumber) . aPoint - (0 @ aNumber) } ].
	
	deltaX := aNumber / ((a / b) squared + 1) sqrt.		
	delta := deltaX @ (deltaX * a / b) negated.

	^ { aPoint + delta . aPoint - delta }
	
]

{ #category : #properties }
GLine >> pointsWithDist: aNumber to: aPoint [
	| deltaX delta |
	
	(self hasPoint: aPoint) ifFalse: [
		Error signal: 'This line does not contain ', aPoint asString ].

	b = 0 ifTrue: [
		^ { aPoint + (0 @ aNumber) . aPoint - (0 @ aNumber) } ].
	
	deltaX := aNumber / ((a / b) squared + 1) sqrt.		
	delta := deltaX @ (deltaX * a / b) negated.

	^ { aPoint + delta . aPoint - delta }
	
]

{ #category : #printing }
GLine >> printOn: aStream [
	a printOn: aStream.
	aStream nextPutAll: 'x '.
	b sign >= 0 ifTrue: [ 
		aStream nextPut: $+ ].
	b printOn: aStream.
	aStream nextPutAll: 'y '.
	c sign >= 0 ifTrue: [ 
		aStream nextPut: $+ ].
	c printOn: aStream.
	aStream nextPutAll: ' = 0'.
	
]

{ #category : #properties }
GLine >> through: aPoint1 and: aPoint2 hasPoint: aPoint [

	^(GTriangle with: aPoint1 with: aPoint2 with: aPoint) isDegenerate . 
]

{ #category : #properties }
GLine >> xFor: anY [

	^ ((anY * b + c) / a) negated
]

{ #category : #properties }
GLine >> yFor: anX [

	^ ((anX * a + c) / b) negated
]
