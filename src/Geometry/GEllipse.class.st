"
I am an Ellipse geometry.

I am described by center and two radii.

- `center `is the center point of the ellipse
- `a` is the major radius along the x axis
- `b` is the minor radius along the y axis
"
Class {
	#name : #GEllipse,
	#superclass : #GShape,
	#instVars : [
		'center',
		'a',
		'b'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GEllipse class >> center: aPoint a: xRadius b: yRadius [
	^ self new setCenter: aPoint a: xRadius b: yRadius
]

{ #category : #comparing }
GEllipse >> = anEllipse [
	self species = anEllipse species
		ifFalse: [ ^ false ].
	^ self center = anEllipse center & (self a = anEllipse a) & (self b = anEllipse b)
]

{ #category : #accessing }
GEllipse >> a [
	^ a
]

{ #category : #accessing }
GEllipse >> b [
	^ b
]

{ #category : #accessing }
GEllipse >> center [
	^ center
]

{ #category : #accessing }
GEllipse >> encompassingRectangle [
	^ center - (a @ b) corner: center + (a @ b)
]

{ #category : #transforming }
GEllipse >> fitInExtent: aPoint [
	a := (aPoint x min: aPoint y) / 2.
	b := (aPoint x max: aPoint y) / 2
]

{ #category : #comparing }
GEllipse >> hash [
	^ (a bitXor: b) bitXor: center hash
]

{ #category : #accessing }
GEllipse >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
GEllipse >> includesPoint: aPoint [
	^ (aPoint x - center x) squared / a squared + ((aPoint y - center y) squared / b squared) <= 1
]

{ #category : #comparing }
GEllipse >> intersectLineSegment: aLineSegment [
	^ aLineSegment intersectEllipse: self
]

{ #category : #initialization }
GEllipse >> setCenter: aCenter a: xRadius b: yRadius [
	center := aCenter.
	a := xRadius.
	b := yRadius
]

{ #category : #transforming }
GEllipse >> translateBy: aPoint [ 
	center := center + aPoint
]

{ #category : #accessing }
GEllipse >> width [
	^ self encompassingRectangle width
]
