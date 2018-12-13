"
I am an Ellipse geometry.

I am described by center and two radii.

- `center `is the center point of the ellipse
- `a` is the radius along the x axis
- `b` is the radius along the y axis

TODO
------------------

(Cyril Ferlicot) Note: I think that this representation of an ellipse is not correct. With that we can represent only ellipse whose major and minor axes are on x and y axis. But we cannot represent all ellipses. For example we cannot make a GEllipse rotate. 

We will need to review the implementation to get:
- A center
- A semi minor axis
- A semi major axis
- An angle between the x axis and the major axis 

Another problem is that here we have one center, but an ellipse would be better described with two focus instead of one center.
"
Class {
	#name : #GEllipse,
	#superclass : #GShape,
	#instVars : [
		'center',
		'xRadius',
		'yRadius'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GEllipse class >> center: aPoint a: xRadius b: yRadius [
	self
		deprecated: 'Use #center:xRadius:yRadius: instead'
		transformWith: '`@receiver center: `@statements1 a: `@statements2 b: `@statements3' -> '`@receiver center: `@statements1 xRadius: `@statements2 yRadius: `@statements3'.
	^ self center: aPoint xRadius: xRadius yRadius: yRadius
]

{ #category : #'instance creation' }
GEllipse class >> center: aPoint xRadius: aNumber yRadius: anotherNumber [
	^ self new
		setCenter: aPoint xRadius: aNumber yRadius: anotherNumber;
		yourself
]

{ #category : #comparing }
GEllipse >> = anEllipse [
	self == anEllipse ifTrue: [ ^ true ].
	self species = anEllipse species ifFalse: [ ^ false ].

	^ center = anEllipse center and: [ xRadius = anEllipse xRadius and: [ yRadius = anEllipse yRadius ] ]
]

{ #category : #accessing }
GEllipse >> a [
	self deprecated: 'Use #xRadius instead' transformWith: '`@receiver a' -> '`@receiver xRadius'.
	^ self xRadius
]

{ #category : #accessing }
GEllipse >> b [
	self deprecated: 'Use #yRadius instead' transformWith: '`@receiver b' -> '`@receiver yRadius'.
	^ self yRadius
]

{ #category : #accessing }
GEllipse >> center [
	"Since we have it, diretly return it to be faster than my original implementation"
	
	^ center
]

{ #category : #accessing }
GEllipse >> encompassingRectangle [
	^ center - (xRadius @ yRadius) corner: center + (xRadius @ yRadius)
]

{ #category : #transforming }
GEllipse >> fitInExtent: aPoint [
	"Since we need to keep the proportions, we will divide both points by the furthest point in order to fit the ellipse in a rectangle of size 1 then we will multiply by the extent."

	| majorDiagonalSize |
	majorDiagonalSize := self majorRadius * 2.

	xRadius := xRadius / majorDiagonalSize * aPoint x.
	yRadius := yRadius / majorDiagonalSize * aPoint y
]

{ #category : #comparing }
GEllipse >> hash [
	^ (xRadius hash bitXor: yRadius hash) bitXor: center hash
]

{ #category : #accessing }
GEllipse >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
GEllipse >> includesPoint: aPoint [
	"Solution from: https://math.stackexchange.com/questions/76457/check-if-a-point-is-within-an-ellipse"

	^ (aPoint x - center x) squared / xRadius squared + ((aPoint y - center y) squared / yRadius squared) <= 1
]

{ #category : #comparing }
GEllipse >> intersectLine: aGLine [ 
	^ {  }
]

{ #category : #comparing }
GEllipse >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectEllipse: self
]

{ #category : #accessing }
GEllipse >> majorRadius [
	^ xRadius max: yRadius
]

{ #category : #accessing }
GEllipse >> minorRadius [
	^ xRadius min: yRadius
]

{ #category : #initialization }
GEllipse >> setCenter: aCenter a: xRad b: yRad [
	self
		deprecated: 'Use #setCenter:xRadius:yRadius: instead'
		transformWith: '`@receiver setCenter: `@statements1 a: `@statements2 b: `@statements3' -> '`@receiver setCenter: `@statements1 xRadius: `@statements2 yRadius: `@statements3'.
	self setCenter: aCenter xRadius: xRad yRadius: yRad
]

{ #category : #initialization }
GEllipse >> setCenter: aCenter xRadius: xRad yRadius: yRad [
	center := aCenter.
	xRadius := xRad.
	yRadius := yRad
]

{ #category : #transforming }
GEllipse >> translateBy: aPoint [ 
	center := center + aPoint
]

{ #category : #accessing }
GEllipse >> width [
	^ self encompassingRectangle width
]

{ #category : #accessing }
GEllipse >> xRadius [
	^ xRadius
]

{ #category : #accessing }
GEllipse >> yRadius [
	^ yRadius
]
