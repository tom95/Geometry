"
Description
--------------------

A GLine goes through two points and can be represented by an equation of the form ax + by + c = 0.

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
	v1:						<aGPoint>				One points on the line.
	v2:						<aGPoint>				Another point on the line.
	equationCache:		<aDictionary>		Dictionary caching the values of the equation ax + by + c = 0.

"
Class {
	#name : #GLine,
	#superclass : #G1DElement,
	#instVars : [
		'v1',
		'v2',
		'equationCache'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GLine class >> a: a b: b c: c [
	"ax + by + c = 0
	ax + c = -by
	-((ax + c) / b) = y
	
	ax + by + c = 0
	by + c = -ax
	-((by + c) / a) = x
	"

	^ b = 0 ifFalse: [ self through: 1 , ((a * 1 + c) / b) negated and: 2 , ((a * 2 + c) / b) negated ] ifTrue: [ self through: ((b * 1 + c) / a) negated , 1 and: ((b * 2 + c) / a) negated , 2 ]
]

{ #category : #'instance creation' }
GLine class >> through: aPoint1 and: aPoint2 [
	^ self new
		v1: aPoint1;
		v2: aPoint2;
		yourself
]

{ #category : #comparing }
GLine >> = line [
	self == line ifTrue: [ ^ true ].
	self class = line class ifFalse: [ ^ false ].

	(self isParallelTo: line) ifFalse: [ ^ false ].

	^ [ (self yFor: 1) =~ (line yFor: 1) ]
		on: GeometryError
		do: [ "This can happen if b = 0" (self xFor: 1) =~ (line xFor: 1) ]
]

{ #category : #accessing }
GLine >> a [
	^ self linearEquation at: #a
]

{ #category : #arithmetic }
GLine >> angleWith: aLine [
	^ self v1 - self v2 angleWith: aLine v1 - aLine v2
]

{ #category : #converting }
GLine >> asGLine [
	^ self 
]

{ #category : #accessing }
GLine >> b [
	^ self linearEquation at: #b
]

{ #category : #accessing }
GLine >> c [
	^ self linearEquation at: #c
]

{ #category : #accessing }
GLine >> determinantWith: aLine [
	"I return the determinant between two line.
	
	First line: ax + by + c = 0
	Second line: px + qy + c = 0
	
	Determinant: a*q - p*b
	"

	^ (GMatrix rows: {{self a . self b} . {aLine a . aLine b}}) determinant
]

{ #category : #'distance functions' }
GLine >> distanceTo: aGPoint [
	^ (self a * aGPoint x + (self b * aGPoint y) + self c) abs / (self a squared + self b squared) sqrt
]

{ #category : #comparing }
GLine >> hash [
	^ ([ self yFor: 1 ]
		on: GeometryError
		do: [ "This can happen if b = 0" self xFor: 1 ]) hash
]

{ #category : #testing }
GLine >> includes: aPoint [
	^ self a * aPoint x + (self b * aPoint y) + self c =~ 0
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
	
	x := (self c negated * q - (r negated * self b)) / determinant.
	y := (self a * r negated - (p * self c negated)) / determinant.
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

{ #category : #accessing }
GLine >> linearEquation [
	"Return a dictionary with value for a, b and c representing the line with an equation of the form: ax + by + c = 0"

	^ equationCache ifNil: [ equationCache := self privateLinearEquationComputation ]
]

{ #category : #printing }
GLine >> printOn: aStream [
	self a ~~ 0
		ifTrue: [ self a ~~ 1 ifTrue: [ self a printOn: aStream ].
			aStream nextPutAll: 'x '.
			self b sign >= 0 ifTrue: [ aStream nextPutAll: '+ ' ] ].
	self b ~~ 0
		ifTrue: [ self b ~~ 1 ifTrue: [ self b printOn: aStream ].
			aStream nextPutAll: 'y' ].
	self c ~~ 0
		ifTrue: [ aStream space.
			self c sign >= 0 ifTrue: [ aStream nextPutAll: '+ ' ].
			self c printOn: aStream ].
	aStream nextPutAll: ' = 0'
]

{ #category : #private }
GLine >> privateLinearEquationComputation [
	v1 y = v2 y ifTrue: [ ^ Dictionary with: #a -> 0 with: #b -> 1 with: #c -> v1 y negated ].
	v1 x = v2 x ifTrue: [ ^ Dictionary with: #a -> 1 with: #b -> 0 with: #c -> v1 x negated ].

	^ Dictionary with: #a -> (v1 y - v2 y) with: #b -> (v2 x - v1 x) with: #c -> ((v1 x - v2 x) * v1 y + ((v2 y - v1 y) * v1 x))
]

{ #category : #initialization }
GLine >> resetEquationCache [
	equationCache := nil
]

{ #category : #transforming }
GLine >> translateBy: aGVector [
	self v1: self v1 + aGVector.
	self v2: self v2 + aGVector
]

{ #category : #accessing }
GLine >> v1 [
	^ v1
]

{ #category : #accessing }
GLine >> v1: aPoint [
	v1 := aPoint.
	self resetEquationCache
]

{ #category : #accessing }
GLine >> v2 [
	^ v2
]

{ #category : #accessing }
GLine >> v2: aPoint [
	v2 := aPoint.
	self resetEquationCache
]

{ #category : #properties }
GLine >> xFor: anY [
	self a = 0 ifTrue: [ self error: 'Cannot answer a x if a = 0' ].

	^ ((anY * self b + self c) / self a) negated
]

{ #category : #properties }
GLine >> yFor: anX [
	self b = 0 ifTrue: [ self error: 'Cannot answer an y if b = 0' ].

	^ ((anX * self a + self c) / self b) negated
]
