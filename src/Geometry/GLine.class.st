"
A GLine has 3 instance variables, which are koeficients  of line:
ax+by+c=0


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
	self == line ifTrue: [^ true].
	self class = line class ifFalse: [^ false].

	(self parallelTo: line) ifFalse: [^ false].

	^ [(self yFor: 1) =~ (line yFor: 1)]
		on: GError
		do: ["This can happen if b = 0" (self xFor: 1) =~ (line xFor: 1)]
]

{ #category : #accessing }
GLine >> a [
	^a

]

{ #category : #accessing }
GLine >> a: anObject [
	a := anObject
]

{ #category : #converting }
GLine >> asGLine [
	^ self 
]

{ #category : #accessing }
GLine >> b [
	^b

]

{ #category : #accessing }
GLine >> b: anObject [
	b := anObject
]

{ #category : #accessing }
GLine >> c [
	^c

]

{ #category : #accessing }
GLine >> c: anObject [
	c := anObject
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
GLine >> distanceTo: aGPoint [
	^ (a * aGPoint x + (b * aGPoint y) + c) abs / (a * a + (b * b)) sqrt
]

{ #category : #comparing }
GLine >> hash [
	^ (a hash bitXor: b hash) bitXor: c hash
]

{ #category : #properties }
GLine >> includes: aPoint [

	^ a * aPoint x + (b * aPoint y) + c =~ 0
]

{ #category : #intersections }
GLine >> intersectionWithLine: aGLine [
	"ax + by = c and px + qy = r"

	| p q r x y determinant |
	determinant := self determinantWith: aGLine.

	determinant =~ 0 ifTrue: [ ^ nil "Line are parallel if determinant = 0" ].

	p := aGLine a.
	q := aGLine b.
	r := aGLine c.
	
	x := (c negated * q - (r negated * b)) / determinant.
	y := (a * r negated - (p * c negated)) / determinant.
	^ (x , y)
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

{ #category : #accessing }
GLine >> length [
	^ Float infinity
]

{ #category : #properties }
GLine >> parallelTo: aLine [
	"If the determinant it 0 then the lines are parallel"

	^ (self determinantWith: aLine) =~ 0
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

{ #category : #properties }
GLine >> xFor: anY [
	a = 0 ifTrue: [self error: 'Cannot answer a x if a = 0'].

	^ ((anY * b + c) / a) negated
]

{ #category : #properties }
GLine >> yFor: anX [
	b = 0 ifTrue: [self error: 'Cannot answer an y if b = 0'].

	^ ((anX * a + c) / b) negated
]
