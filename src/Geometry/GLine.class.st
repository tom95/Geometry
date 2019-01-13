"
Description
--------------------

A GLine has 3 instance variables, which are coeficients of line: ax + by + c = 0.

Maybe later the implementation will change to have one point and one vector to be able to implement in a simpler way features such as translations. 

Examples
--------------------

	GLine a: 1 b: 1 c: -13.
	
	GLine through: 1 , 3 and: 3 , 0.
	
	(GLine a: 2 b: -3 c: 0.5) intersectionsWith: (GLine a: -2 b: -2 c: 4).
	
	(GLine a: 1 b: 2 c: 0.5) isParallelTo: (GLine a: 2 b: 4 c: 4).
	
	(GLine through: -1 , -4 and: 1 , -2) translateBy: #(1 -2) asGVector.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	a:		<aNumber>		a coefficient in the ax + by + c = 0 line equation.
	b:		<aNumber>		b coefficient in the ax + by + c = 0 line equation.
	c:		<aNumber>		c coefficient in the ax + by + c = 0 line equation.

"
Class {
	#name : #GLine,
	#superclass : #G1DElement,
	#instVars : [
		'a',
		'b',
		'c'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GLine class >> a: aNumber1 b: aNumber2 c: aNumber3 [
	^ self new
		a: aNumber1;
		b: aNumber2;
		c: aNumber3;
		yourself
]

{ #category : #'instance creation' }
GLine class >> through: aPoint1 and: aPoint2 [
	| ai bi ci |
	aPoint1 y = aPoint2 y ifTrue: [ ^ self a: 0 b: 1 c: aPoint1 y negated ].
	aPoint1 x = aPoint2 x ifTrue: [ ^ self a: 1 b: 0 c: aPoint1 x negated ].
	
	ai := aPoint1 y - aPoint2 y.
	bi := aPoint2 x - aPoint1 x.
	ci := (aPoint1 x - aPoint2 x) * aPoint1 y + ((aPoint2 y - aPoint1 y) * aPoint1 x).
	^ self a: ai b: bi c: ci
]

{ #category : #comparing }
GLine >> = line [
	self == line ifTrue: [ ^ true ].
	self class = line class ifFalse: [ ^ false ].

	(self isParallelTo: line) ifFalse: [ ^ false ].

	^ [ (self yFor: 1) =~ (line yFor: 1) ]
		on: GError
		do: [ "This can happen if b = 0" (self xFor: 1) =~ (line xFor: 1) ]
]

{ #category : #accessing }
GLine >> a [
	^ a
]

{ #category : #accessing }
GLine >> a: aNumber [
	a := aNumber
]

{ #category : #arithmetic }
GLine >> angleWith: aLine [
	| line1Points line2Points |
	line1Points := self getTwoRandomPoints.
	line2Points := aLine getTwoRandomPoints.
	^ line1Points first - line1Points second angleWith: line2Points first - line2Points second
]

{ #category : #converting }
GLine >> asGLine [
	^ self 
]

{ #category : #accessing }
GLine >> b [
	^ b
]

{ #category : #accessing }
GLine >> b: aNumber [
	b := aNumber
]

{ #category : #accessing }
GLine >> c [
	^ c

]

{ #category : #accessing }
GLine >> c: aNumber [
	c := aNumber
]

{ #category : #accessing }
GLine >> determinantWith: aLine [
	"I return the determinant between two line.
	
	First line: ax + by + c = 0
	Second line: px + qy + c = 0
	
	Determinant: a*q - p*b
	"

	^ (GMatrix rows: {{a . b} . {aLine a . aLine b}}) determinant
]

{ #category : #'distance functions' }
GLine >> distanceTo: aGPoint [
	^ (a * aGPoint x + (b * aGPoint y) + c) abs / (a * a + (b * b)) sqrt
]

{ #category : #accessing }
GLine >> getTwoRandomPoints [
	"Since we represent the line with is equation, there is multiple thing we will need to resolve with two points on the line. This method will retrun those two points"

	"If a = 0 we cannot find a x for a y value since the line to parallel to the y axis"
	^ a = 0 ifTrue: [ {((self xFor: 1) , 1) . ((self xFor: 2) , 2)} ] ifFalse: [ {(1 , (self yFor: 1)) . (2 , (self yFor: 2))} ]
]

{ #category : #comparing }
GLine >> hash [
	^ (a hash bitXor: b hash) bitXor: c hash
]

{ #category : #testing }
GLine >> includes: aPoint [
	^ a * aPoint x + (b * aPoint y) + c =~ 0
]

{ #category : #intersections }
GLine >> intersectionsWith: anElement [
	^ anElement intersectionsWithLine: self
]

{ #category : #intersections }
GLine >> intersectionsWithEllipse: aGEllipse [ 
	^ aGEllipse intersectionsWithLine: self
]

{ #category : #intersections }
GLine >> intersectionsWithLine: aGLine [
	| p q r x y determinant |
	determinant := self determinantWith: aGLine.

	determinant =~ 0 ifTrue: [ ^ { } "Line are parallel if determinant = 0" ].

	p := aGLine a.
	q := aGLine b.
	r := aGLine c.
	
	x := (c negated * q - (r negated * b)) / determinant.
	y := (a * r negated - (p * c negated)) / determinant.
	^ { (x , y) }
]

{ #category : #properties }
GLine >> isParallelTo: aLine [
	"If the determinant it 0 then the lines are parallel"

	^ (self determinantWith: aLine) =~ 0
]

{ #category : #accessing }
GLine >> length [
	^ Float infinity
]

{ #category : #printing }
GLine >> printOn: aStream [
	a ~~ 0
		ifTrue: [ a ~~ 1 ifTrue: [ a printOn: aStream ].
			aStream nextPutAll: 'x '.
			b sign >= 0 ifTrue: [ aStream nextPutAll: '+ ' ] ].
	b ~~ 0
		ifTrue: [ b ~~ 1 ifTrue: [ b printOn: aStream ].
			aStream nextPutAll: 'y' ].
	c ~~ 0
		ifTrue: [ aStream space.
			c sign >= 0 ifTrue: [ aStream nextPutAll: '+ ' ].
			c printOn: aStream ].
	aStream nextPutAll: ' = 0'
]

{ #category : #transforming }
GLine >> translateBy: aGVector [
	| translatedLine points |
	self flag: #todo.	"I think we can do better, especialy for perfs but for now I want something working."
	points := self getTwoRandomPoints collect: [ :point | point + aGVector ].
	translatedLine := self class through: points first and: points second.
	
	a := translatedLine a.
	b := translatedLine b.
	c := translatedLine c
]

{ #category : #properties }
GLine >> xFor: anY [
	a = 0 ifTrue: [ self error: 'Cannot answer a x if a = 0' ].

	^ ((anY * b + c) / a) negated
]

{ #category : #properties }
GLine >> yFor: anX [
	b = 0 ifTrue: [ self error: 'Cannot answer an y if b = 0' ].

	^ ((anX * a + c) / b) negated
]
