"
I am ellipse I have center and 2 vertices.

Example

```Smalltalk
""circle radius = 10""
GEllipse center: 0@0 vertex: 0@10 coVertex: 10@0
``` 
"
Class {
	#name : #GEllipse,
	#superclass : #GShape,
	#instVars : [
		'center',
		'vertex',
		'coVertex'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GEllipse class >> center: aGPoint vertex: aGPoint2 coVertex: aGPoint3 [
	| d1 d2 zero |
	d1 := aGPoint - aGPoint2.
	d2 := aGPoint - aGPoint3.
	zero := GVector x: 0 y: 0."Zero vector"
	(d1 = zero and: [ d2 = zero ]) ifTrue: [ 
		self error: 'This is not an ellipse but a point.'  ].
	(d1 = zero or: [ d2 = zero ]) ifTrue: [ 
		self error: 'This is not an ellipse but a line.' ].
	^ self new
		center: aGPoint;
		vertex: aGPoint2;
		coVertex: aGPoint3;
		yourself
]

{ #category : #comparing }
GEllipse >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ vertex =~ anObject vertex and: [ center =~ anObject center and: [ coVertex =~ anObject coVertex ] ]
]

{ #category : #accessing }
GEllipse >> area [
	"pi * a * b"

	^ (self semiMajorAxisLength * self semiMinorAxisLength)π
]

{ #category : #testing }
GEllipse >> boundaryContains: aPoint [
	"Solution from: https://math.stackexchange.com/questions/76457/check-if-a-point-is-within-an-ellipse"

	^ (aPoint x - center x) squared / self semiMajorAxisLength squared + ((aPoint y - center y) squared / self semiMinorAxisLength squared) = 1
]

{ #category : #accessing }
GEllipse >> center [
	^ center
]

{ #category : #accessing }
GEllipse >> center: anObject [
	center := anObject
]

{ #category : #accessing }
GEllipse >> coVertex [
	^ coVertex
]

{ #category : #accessing }
GEllipse >> coVertex: anObject [
	coVertex := anObject
]

{ #category : #accessing }
GEllipse >> encompassingRectangle [
	| radiuxPoints |
	radiuxPoints := { vertex . (center + (center - vertex)). coVertex . (center + (center - coVertex)) } collect: #coordinates.
	^ GRectangle origin: (radiuxPoints fold: [ :pt1 :pt2 | pt1 upperLimitsWith: pt2 ]) asGPoint corner: (radiuxPoints fold: [ :pt1 :pt2 | pt1 lowerLimitsWith: pt2 ]) asGPoint
]

{ #category : #transforming }
GEllipse >> fitInExtent: extent [
	| scales |
	scales := extent coordinatesWith: self encompassingRectangle extent coordinates collect: [ :number1 :number2 | number1 / number2 ].
	vertex := ((vertex - center) coordinates coordinatesWith: scales collect: [ :a :b | a * b ]) asGVector + center.
	coVertex := ((coVertex - center) coordinates coordinatesWith: scales collect: [ :a :b | a * b ]) asGVector + center
]

{ #category : #accessing }
GEllipse >> foci [
	^ self majorAxis asGLine intersectionsWith: (GCircle center: center radius: self fociLocation)
]

{ #category : #accessing }
GEllipse >> fociLocation [
	"c² = a² - b²"

	^ (self semiMajorAxisLength squared - self semiMinorAxisLength squared) sqrt
]

{ #category : #comparing }
GEllipse >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ vertex hash bitXor: (center hash bitXor: coVertex hash)
]

{ #category : #testing }
GEllipse >> includes: aPoint [
	"Solution from: https://math.stackexchange.com/questions/76457/check-if-a-point-is-within-an-ellipse"

	^ (aPoint x - center x) squared / self semiMajorAxisLength squared + ((aPoint y - center y) squared / self semiMinorAxisLength squared) <= 1
]

{ #category : #intersections }
GEllipse >> intersectionsWith: anElement [
	^ anElement intersectionsWithEllipse: self
]

{ #category : #intersections }
GEllipse >> intersectionsWithEllipse: aGEllipse [
	"And also tested"

	self shouldBeImplemented
]

{ #category : #intersections }
GEllipse >> intersectionsWithLine: aGLine [
	"
	http://www.ambrsoft.com/TrigoCalc/Circles2/Ellipse/EllipseLine.htm
	
	Ellipse: ((x-h)²/a²) + ((y - k)²/b²) = 1
	Line: y = mx + c
	"

	| h k a b m c e t a2m2 ab a2 b2 m2 k2 t2 tk sqrt abm x1 x2 y1 y2 sqrtContent |
	
	"If b = 0 this is a vertical line"
	aGLine b = 0 ifTrue: [ ^ self intersectionsWithVerticalLine: aGLine ].
	
	h := center x.
	k := center y.
	a := self semiMajorAxisLength.
	b := self semiMinorAxisLength.
	
	m := aGLine a / aGLine b negated.
	c := aGLine c / aGLine b negated.
	e := c - k.
	t := c + (m * h).
	ab := a * b.
	abm := ab * m.
	a2 := a squared.
	b2 := b squared.
	m2 := m squared.
	k2 := k squared.
	t2 := t squared.
	a2m2 := a2 * m2.
	tk := t * k.
	sqrtContent := (a2m2 + b2 - t2 - k2 + (2 * tk)).
	sqrtContent >= 0 ifFalse: [ ^ {  } ]. "No intersections"
	
	sqrt := (a2m2 + b2 - t2 - k2 + (2 * tk)) sqrt.
	x1 := (h * b2 - (m * a2 * e) + (ab * sqrt)) / (a2m2 + b2).
	x2 := (h * b2 - (m * a2 * e) - (ab * sqrt)) / (a2m2 + b2).
	y1 := (b2 * t + (k * a2m2) + (abm * sqrt)) / (a2m2 + b2).
	y2 := (b2 * t + (k * a2m2) - (abm * sqrt)) / (a2m2 + b2).

	^ {(x1 , y1) . (x2 , y2)} asSet
]

{ #category : #intersections }
GEllipse >> intersectionsWithVerticalLine: aGLine [
	"
	Ellipse: ((x-h)²/a²) + ((y - k)²/b²) = 1
	Line: x = -c/a 
	"

	| h k a2 b2 x sqrt y1 y2 tmp tmp2 |
	h := center x.
	k := center y.
	a2 := self semiMajorAxisLength squared.
	b2 := self semiMinorAxisLength squared.
	x := aGLine c negated / aGLine a.
	tmp := (x - h) squared / a2.
	tmp2 := (b2 * (1 - tmp)).
	
	"I am not sure this is correct but I have the impression that if this is negative, there is no intersection."
	tmp2 < 0 ifTrue: [ ^ {  } ].
	
	sqrt := tmp2 sqrt.

	y1 := k + sqrt.
	y2 := k - sqrt.

	^ {(x , y1) . (x , y2)} asSet
]

{ #category : #accessing }
GEllipse >> majorAxis [
	^ GSegment with: center + (center - vertex) with: center + (vertex - center)
]

{ #category : #accessing }
GEllipse >> majorAxisLength [
	^ self majorAxis length
]

{ #category : #accessing }
GEllipse >> minorAxis [
	^ GSegment with: center + (center - coVertex) with: center + (coVertex - center)
]

{ #category : #accessing }
GEllipse >> minorAxisLength [
	^ self minorAxis length
]

{ #category : #accessing }
GEllipse >> perimeter [
	"The perimeter of an ellipse cannot be calculated easily. This method will give an approximation with Ramanujan II"

	| h semiMajorAndMinorLength |
	semiMajorAndMinorLength := self semiMajorAxisLength + self semiMinorAxisLength.
	h := (self semiMajorAxisLength - self semiMinorAxisLength) squared / semiMajorAndMinorLength squared.

	^ (semiMajorAndMinorLength * (1 + (3 * h / (10 + (4 - (3 * h)) squared))))π
]

{ #category : #printing }
GEllipse >> printOn: aStream [
	aStream nextPutAll: ('((x - {1})²/{2}) + ((y - {3})²/{4}) = 1' format: {center x . self semiMajorAxisLength squared . center y . self semiMinorAxisLength squared})
]

{ #category : #accessing }
GEllipse >> semiMajorAxisLength [
	^ self majorAxis length / 2
]

{ #category : #accessing }
GEllipse >> semiMinorAxisLength [
	^ self minorAxis length / 2
]

{ #category : #transforming }
GEllipse >> translateBy: aGVector [ 
	center translateBy: aGVector.
	vertex translateBy: aGVector.
	coVertex translateBy: aGVector
]

{ #category : #accessing }
GEllipse >> vertex [
	^ vertex
]

{ #category : #accessing }
GEllipse >> vertex: anObject [
	vertex := anObject
]
